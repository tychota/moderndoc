#!/usr/bin/env bash
set -euo pipefail

REPO_RAW_URL="https://raw.githubusercontent.com/tychota/moderndoc/main"
DEPS_URL="$REPO_RAW_URL/dependencies.txt"

PKG_DIR_NAME="moderndoc"
STYLE_URL="$REPO_RAW_URL/tex/latex/moderndoc/moderndoc.sty"

echo "=== moderndoc installer ==="

need() { command -v "$1" >/dev/null 2>&1; }

if ! need tlmgr; then
  echo "Error: tlmgr not found. Install TeX Live 2024+ first."
  exit 1
fi
if ! need lualatex; then
  echo "Error: lualatex not found. Install TeX Live (luatex)."
  exit 1
fi

TEXMFHOME="$(kpsewhich -var-value=TEXMFHOME)"
TARGET_DIR="$TEXMFHOME/tex/latex/$PKG_DIR_NAME"
LEGACY_DIR="$TEXMFHOME/tex/latex/modern-doc"
mkdir -p "$TARGET_DIR" "$LEGACY_DIR"

echo "Installing LaTeX dependencies (tlmgr)…"

# Prefer usermode installs when possible
if tlmgr --usermode info >/dev/null 2>&1; then
  TLMGR="tlmgr --usermode"
else
  tlmgr init-usertree >/dev/null 2>&1 || true
  TLMGR="tlmgr --usermode"
fi

# Fetch dependency list
mapfile -t PKGS < <(curl -sSL "$DEPS_URL" | grep -v '^\s*#' | grep -v '^\s*$' || true)

if [ "${#PKGS[@]}" -gt 0 ]; then
  set +e
  $TLMGR install "${PKGS[@]}"
  RC=$?
  set -e
  if [ $RC -ne 0 ]; then
    echo "Note: usermode install failed; trying system install (may require sudo)…"
    sudo tlmgr install "${PKGS[@]}"
  fi
fi

echo "Installing moderndoc.sty…"
curl -sSL "$STYLE_URL" -o "$TARGET_DIR/moderndoc.sty"

echo "Updating TeX filename database…"
if need mktexlsr; then
  mktexlsr "$TEXMFHOME" >/dev/null 2>&1 || true
fi

echo "Minted note:"
echo "- If minted fails, compile with --shell-escape."
echo "- If your TeX Live minted is older, you may need pygmentize (pip install Pygments)."

echo "=== done ==="
echo "Try: kpsewhich moderndoc.sty"