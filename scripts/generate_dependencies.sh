#!/usr/bin/env bash
set -euo pipefail

# ModernDoc Dependency Generator
# - Does NOT build anything
# - Reads existing LaTeX .log files and resolves to tlmgr package names (if tlmgr is available)
# - Optionally scans sources for \usepackage / \RequirePackage

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_FILE="${OUTPUT_FILE:-$PROJECT_ROOT/dependencies.txt}"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

LOG_LATEX_DIRS="$TMP_DIR/log_latex_dirs.txt"
LOG_PKGS="$TMP_DIR/log_pkg_names.txt"
LOG_PATHS="$TMP_DIR/log_paths.txt"
SRC_PKGS="$TMP_DIR/src_pkg_names.txt"
FINAL_PKGS="$TMP_DIR/final_pkgs.txt"

: > "$LOG_LATEX_DIRS"
: > "$LOG_PKGS"
: > "$LOG_PATHS"
: > "$SRC_PKGS"
: > "$FINAL_PKGS"

have() { command -v "$1" >/dev/null 2>&1; }

PYTHON_BIN=""
if have python3; then
  PYTHON_BIN="python3"
elif have python; then
  PYTHON_BIN="python"
fi

# Collect logs: args first, otherwise ./build/*.log
LOG_FILES=()
if [ "$#" -gt 0 ]; then
  LOG_FILES=("$@")
else
  if [ -d "$PROJECT_ROOT/build" ]; then
    if have fd; then
      while IFS= read -r f; do LOG_FILES+=("$f"); done < <(fd -H -I -t f -e log . "$PROJECT_ROOT/build" || true)
    fi
    if [ "${#LOG_FILES[@]}" -eq 0 ]; then
      while IFS= read -r -d '' f; do LOG_FILES+=("$f"); done < <(find "$PROJECT_ROOT/build" -type f -name "*.log" -print0 2>/dev/null)
    fi
  fi
fi

if [ "${#LOG_FILES[@]}" -eq 0 ]; then
  echo "No .log files found. Pass logs as args or ensure $PROJECT_ROOT/build contains *.log" >&2
  exit 1
fi

echo "Scanning ${#LOG_FILES[@]} log(s) for dependencies..."

# --- Extraction helpers (rg-first, grep fallback) ---
extract_with_rg() {
  local log="$1"

  # TeX logs sometimes use backticks around filenames; normalize to single quotes for easier matching.
  # (We still handle both in regexes, but this helps.)
  local norm="$TMP_DIR/$(basename "$log").norm"
  tr '\140' "'" < "$log" > "$norm" || cp "$log" "$norm"

  # 1) Direct latex dir hits (your proven approach)
  rg --no-filename -o 'texmf-dist/tex/latex/[^/]+/' "$norm" \
    | sed 's#.*texmf-dist/tex/latex/##; s#/$##' \
    >> "$LOG_LATEX_DIRS" || true

  # 2) texmf-dist relative file paths
  rg --no-filename -o 'texmf-dist/[^[:space:])]+?\.(sty|cls|ltx)' "$norm" \
    | sed 's#.*texmf-dist/##' \
    >> "$LOG_PATHS" || true

  # 3) Missing file names: File 'foo.sty' not found / Missing input file ... / I can't find file ...
  rg --no-filename -oP "(?:File|Missing input file|I can't find file) ['\`]\K[^'\`]+(?=\.(?:sty|cls|ltx)['\`])" "$norm" \
    >> "$LOG_PKGS" || true

  # 4) Loaded absolute paths: /.../something.sty  -> something
  rg --no-filename -o '/[^[:space:])]+?\.(sty|cls|ltx)' "$norm" \
    | sed -E 's#.*/##; s/\.(sty|cls|ltx)$//' \
    >> "$LOG_PKGS" || true

  # 5) Package lines
  rg --no-filename -oP '^Package:\s+\K\S+' "$norm" >> "$LOG_PKGS" || true
  rg --no-filename -oP '^Package\s+\K\S+(?=\s+Info:)' "$norm" >> "$LOG_PKGS" || true
}

extract_with_grep() {
  local log="$1"
  local norm="$TMP_DIR/$(basename "$log").norm"
  tr '\140' "'" < "$log" > "$norm" || cp "$log" "$norm"

  grep -oE 'texmf-dist/tex/latex/[^/]+/' "$norm" \
    | sed 's#.*texmf-dist/tex/latex/##; s#/$##' \
    >> "$LOG_LATEX_DIRS" || true

  grep -oE 'texmf-dist/[^[:space:])]+?\.(sty|cls|ltx)' "$norm" \
    | sed 's#.*texmf-dist/##' \
    >> "$LOG_PATHS" || true

  grep -E "File '[^']+\.(sty|cls|ltx)' not found|Missing input file '[^']+\.(sty|cls|ltx)'|I can't find file '[^']+\.(sty|cls|ltx)'" "$norm" \
    | sed -E "s/.*'([^']+)\.(sty|cls|ltx)'.*/\1/" \
    >> "$LOG_PKGS" || true

  grep -oE '/[^[:space:])]+?\.(sty|cls|ltx)' "$norm" \
    | sed -E 's#.*/##; s/\.(sty|cls|ltx)$//' \
    >> "$LOG_PKGS" || true

  grep -oE '^Package: [^[:space:]]+' "$norm" | awk '{print $2}' >> "$LOG_PKGS" || true
  grep -oE '^Package [^[:space:]]+ Info:' "$norm" | awk '{print $2}' >> "$LOG_PKGS" || true
}

for log in "${LOG_FILES[@]}"; do
  if [ ! -f "$log" ]; then
    echo "Warning: missing log: $log" >&2
    continue
  fi
  if have rg; then
    extract_with_rg "$log"
  else
    extract_with_grep "$log"
  fi
done

# Dedupe extracted signals
sort -u "$LOG_LATEX_DIRS" -o "$LOG_LATEX_DIRS" || true
sort -u "$LOG_PATHS" -o "$LOG_PATHS" || true
sort -u "$LOG_PKGS" -o "$LOG_PKGS" || true

echo "Found $(wc -l < "$LOG_LATEX_DIRS" | xargs) latex directory hits."
echo "Found $(wc -l < "$LOG_PATHS"     | xargs) texmf-dist file path hits."
echo "Found $(wc -l < "$LOG_PKGS"      | xargs) package/name hits."

# --- Optional source scan for \usepackage / \RequirePackage ---
SCAN_SOURCES="${SCAN_SOURCES:-1}"
if [ "$SCAN_SOURCES" = "1" ]; then
  SCAN_DIRS=()
  for dir in \
    "$PROJECT_ROOT/examples" \
    "$PROJECT_ROOT/tex/latex/moderndoc" \
    "$PROJECT_ROOT/tex/latex/modern-doc"
  do
    [ -d "$dir" ] && SCAN_DIRS+=("$dir")
  done

  if [ "${#SCAN_DIRS[@]}" -gt 0 ]; then
    if [ -n "$PYTHON_BIN" ]; then
      "$PYTHON_BIN" - "$SRC_PKGS" "${SCAN_DIRS[@]}" <<'PY'
import re
import sys
from pathlib import Path

out_path = Path(sys.argv[1])
dirs = [Path(p) for p in sys.argv[2:]]

pkg_pattern = re.compile(
    r'\\(?:usepackage|RequirePackage)\s*(?:\[[^\]]*\]\s*)?\{([^}]*)\}',
    re.S,
)
plex_pattern = re.compile(r'font\s*=\s*plex')

packages = set()
for base in dirs:
    for path in base.rglob("*"):
        if path.suffix not in {".tex", ".sty", ".cls"}:
            continue
        try:
            text = path.read_text(encoding="utf-8", errors="ignore")
        except OSError:
            continue
        lines = [re.sub(r"(?<!\\\\)%.*", "", line) for line in text.splitlines()]
        text = "\n".join(lines)
        if plex_pattern.search(text):
            packages.add("plex-otf")
        for match in pkg_pattern.findall(text):
            for pkg in match.split(","):
                pkg = pkg.strip()
                if pkg:
                    packages.add(pkg)

out_path.write_text("\n".join(sorted(packages)) + ("\n" if packages else ""))
PY
    elif have rg; then
      rg --no-filename --no-line-number -oP -g '*.tex' -g '*.sty' -g '*.cls' \
        '\\\\(?:usepackage|RequirePackage)(?:\\[[^\\]]*\\])?\\{[^}]+' \
        "${SCAN_DIRS[@]}" | \
        sed 's/.*{//' | \
        tr ',' '\n' | \
        sed 's/ //g' | \
        sort -u >> "$SRC_PKGS" || true
      rg -n --no-filename -g '*.tex' -g '*.sty' -g '*.cls' \
        'font\\s*=\\s*plex' "${SCAN_DIRS[@]}" >/dev/null 2>&1 && echo "plex-otf" >> "$SRC_PKGS"
      sort -u "$SRC_PKGS" -o "$SRC_PKGS" || true
    else
      find "${SCAN_DIRS[@]}" -type f \( -name "*.tex" -o -name "*.sty" -o -name "*.cls" \) -print0 | \
        xargs -0 grep -hE "\\\\(usepackage|RequirePackage)(\\[[^]]*\\])?\\{[^}]+\\}" 2>/dev/null | \
        sed -E 's/.*\{(.*)\}.*/\1/' | \
        tr ',' '\n' | \
        sed 's/ //g' | \
        sort -u >> "$SRC_PKGS" || true
      if find "${SCAN_DIRS[@]}" -type f \( -name "*.tex" -o -name "*.sty" -o -name "*.cls" \) -print0 | \
         xargs -0 grep -hE 'font[[:space:]]*=[[:space:]]*plex' 2>/dev/null | \
         head -n 1 >/dev/null; then
        echo "plex-otf" >> "$SRC_PKGS"
      fi
      sort -u "$SRC_PKGS" -o "$SRC_PKGS" || true
    fi
    echo "Found $(wc -l < "$SRC_PKGS" | xargs) source package hits."
  fi
fi

# --- Resolution to tlmgr package names ---
add_final() {
  local pkg="$1"
  [ -z "$pkg" ] && return
  if ! grep -qxF "$pkg" "$FINAL_PKGS" 2>/dev/null; then
    echo "$pkg" >> "$FINAL_PKGS"
  fi
}

tlmgr_pkg_for_file() {
  local needle="$1" # must start with /
  # tlmgr "search --file" lists filenames containing <what>.  [oai_citation:1‡tug.org](https://tug.org/texlive/doc/tlmgr.html)
  tlmgr search --file "$needle" 2>/dev/null | head -n 1 | cut -d: -f1 || true
}

resolve_name() {
  local name="$1"
  name="${name%.sty}"; name="${name%.cls}"; name="${name%.ltx}"
  [ -z "$name" ] && return

  if have tlmgr; then
    local tl=""
    for ext in sty cls ltx; do
      tl="$(tlmgr_pkg_for_file "/${name}.${ext}")"
      [ -n "$tl" ] && break
    done
    if [ -n "$tl" ]; then
      add_final "$tl"
      return
    fi
  fi

  # fallback: keep the name
  add_final "$name"
}

resolve_relpath() {
  local rel="$1"
  [ -z "$rel" ] && return
  if have tlmgr; then
    local tl=""
    tl="$(tlmgr_pkg_for_file "/$rel")"
    if [ -n "$tl" ]; then
      add_final "$tl"
      return
    fi
  fi
  # fallback: try basename as a package name
  resolve_name "$(basename "$rel")"
}

resolve_latex_dir() {
  local dir="$1"
  [ -z "$dir" ] && return
  if have tlmgr; then
    local tl=""
    tl="$(tlmgr_pkg_for_file "/tex/latex/$dir/")"
    if [ -n "$tl" ]; then
      add_final "$tl"
      return
    fi
  fi
  resolve_name "$dir"
}

echo "Resolving via tlmgr (if available)..."
if have tlmgr; then
  echo "  tlmgr found: $(tlmgr --version | head -n 1)"
else
  echo "  tlmgr not found: output will be best-effort names (no mapping)."
fi

# Optional canonical baseline (disable with CANONICAL=0)
CANONICAL="${CANONICAL:-1}"
if [ "$CANONICAL" = "1" ]; then
  cat <<'EOF' | while read -r p; do add_final "$p"; done
latex
latex-bin
latexmk
biber
luatex
EOF
fi

# Prefer file paths/dirs first (strong signal), then loose names
if [ -s "$LOG_PATHS" ]; then
  while IFS= read -r rel; do resolve_relpath "$rel"; done < "$LOG_PATHS"
fi
if [ -s "$LOG_LATEX_DIRS" ]; then
  while IFS= read -r dir; do resolve_latex_dir "$dir"; done < "$LOG_LATEX_DIRS"
fi
if [ -s "$LOG_PKGS" ]; then
  while IFS= read -r name; do resolve_name "$name"; done < "$LOG_PKGS"
fi
if [ -s "$SRC_PKGS" ]; then
  while IFS= read -r name; do resolve_name "$name"; done < "$SRC_PKGS"
fi

sort -u "$FINAL_PKGS" -o "$FINAL_PKGS"

{
  echo "# ModernDoc Dependencies (from LaTeX logs only)"
  echo "# Generated on $(date)"
  echo "# Logs:"
  for f in "${LOG_FILES[@]}"; do echo "#   - $f"; done
  echo
  cat "$FINAL_PKGS"
} > "$OUTPUT_FILE"

echo "Done! Wrote $(wc -l < "$OUTPUT_FILE" | xargs) packages to: $OUTPUT_FILE"
