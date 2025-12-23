#!/bin/bash

# ModernDoc Dependency Generator
# This script scans the templates and styles for LaTeX packages and maps them to tlmgr package names.

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_FILE="$PROJECT_ROOT/dependencies.txt"

echo "Scanning for dependencies in $PROJECT_ROOT..."

# Temporary file for raw package names
RAW_PKGS=$(mktemp)

# Extract package names from \usepackage and \RequirePackage
# This uses a slightly more portable grep approach
find "$PROJECT_ROOT/templates" "$PROJECT_ROOT/styles" -name "*.tex" -o -name "*.sty" | xargs grep -hE "\\(usepackage|RequirePackage)" | \
    sed -E 's/.*\{(.*)\}.*/\1/' | \
    tr ',' '\n' | \
    sed 's/ //g' | \
    sort -u > "$RAW_PKGS"

echo "Found $(wc -l < "$RAW_PKGS" | xargs) potential package names."
echo "Resolving to tlmgr package names (this may take a while)..."

# Canonical dependencies that we always want
cat <<EOF > "$OUTPUT_FILE"
# ModernDoc Dependencies
# Generated on $(date)

latexmk
biber
luatex
koma-script
fontspec
microtype
polyglossia
csquotes
biblatex
minted
tcolorbox
tabularray
caption
enumitem
hyperref
cleveref
siunitx
booktabs
float
geometry
xcolor
etoolbox
environ
trimspaces
varwidth
luatexja
EOF

# Map found .sty names to tlmgr packages
while read -r pkg; do
    # Skip if already in list (simple check)
    if grep -q "^$pkg$" "$OUTPUT_FILE"; then
        continue
    fi

    # Try to find the package name using tlmgr
    # We look for the file in the tlmgr database
    TL_PKG=$(tlmgr search --file "/$pkg.sty" | head -n 1 | cut -d: -f1)
    
    if [ -n "$TL_PKG" ]; then
        if ! grep -q "^$TL_PKG$" "$OUTPUT_FILE"; then
            echo "$TL_PKG" >> "$OUTPUT_FILE"
            echo "  [+] Resolved $pkg -> $TL_PKG"
        fi
    else
        # If not found, add the raw name as a guess (might be a core package)
        if [[ ! " amsmath amssymb fontspec xcolor graphicx " =~ " $pkg " ]]; then
             echo "  [?] Could not resolve $pkg, adding as is."
             echo "$pkg" >> "$OUTPUT_FILE"
        fi
    fi
done < "$RAW_PKGS"

rm "$RAW_PKGS"

# Sort and unique the output file
sort -u -o "$OUTPUT_FILE" "$OUTPUT_FILE"

echo "Done! dependencies.txt created with $(wc -l < "$OUTPUT_FILE" | xargs) packages."
