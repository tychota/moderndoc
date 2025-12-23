#!/bin/bash

# ModernDoc Installer
# Multi-platform (Linux, macOS) installer for ModernDoc dependencies and style files.
# Supports both local execution and piping via curl.

set -e

# Configuration
REPO_RAW_URL="https://raw.githubusercontent.com/tychota/moderndoc/main"
DEPS_URL="$REPO_RAW_URL/dependencies.txt"
STYLE_URL="$REPO_RAW_URL/styles/moderndoc.sty"

echo "=== ModernDoc Installer ==="

# 1. Determine installation source
if [ -f "styles/moderndoc.sty" ] && [ -f "dependencies.txt" ]; then
    echo "Detected local repository."
    LOCAL_MODE=true
    STYLE_FILE="styles/moderndoc.sty"
    DEPS_FILE="dependencies.txt"
else
    echo "Detected remote installation mode."
    LOCAL_MODE=false
fi

# 2. Check Requirements
echo "Checking requirements..."

if ! command -v tlmgr &> /dev/null; then
    echo "Error: tlmgr (TeX Live Manager) not found. Please install TeX Live 2024+."
    exit 1
fi

if ! command -v lualatex &> /dev/null; then
    echo "Error: lualatex not found."
    exit 1
fi

# 3. Install Python Dependencies
echo "Installing Python dependencies (Pygments)..."
if command -v pip3 &> /dev/null; then
    pip3 install Pygments
elif command -v pip &> /dev/null; then
    pip install Pygments
else
    echo "Warning: pip not found. Pygments (for minted) might not be installed."
fi

# 4. Install LaTeX Packages
echo "Installing LaTeX packages..."
if [ "$LOCAL_MODE" = true ]; then
    mapfile -t PKGS < <(grep -v '^#' "$DEPS_FILE")
else
    # Fetch dependencies from remote
    mapfile -t PKGS < <(curl -sSL "$DEPS_URL" | grep -v '^#')
fi

if [ ${#PKGS[@]} -eq 0 ]; then
    echo "  No packages to install."
else
    # Try to install
    if [ "$(id -u)" -ne 0 ] && [ -w "$(tlmgr --version | grep 'root:' | awk '{print $2}')" ]; then
        tlmgr install "${PKGS[@]}"
    else
        echo "Note: Using sudo for tlmgr installation..."
        sudo tlmgr install "${PKGS[@]}"
    fi
fi

# 5. Install moderndoc.sty
echo "Installing moderndoc.sty to local TEXMF directory..."

TEXMFHOME=$(kpsewhich -var-value=TEXMFHOME)
TARGET_DIR="$TEXMFHOME/tex/latex/moderndoc"

mkdir -p "$TARGET_DIR"

if [ "$LOCAL_MODE" = true ]; then
    cp "$STYLE_FILE" "$TARGET_DIR/"
else
    curl -sSL "$STYLE_URL" -o "$TARGET_DIR/moderndoc.sty"
fi

echo "  Installed to $TARGET_DIR"

# 6. Update TeX Database
echo "Updating TeX filename database..."
if command -v mktexlsr &> /dev/null; then
    # We might need sudo for mktexlsr if it's a system-wide update, 
    # but usually TEXMFHOME doesn't need it. 
    # However, running it on TEXMFHOME is safer.
    mktexlsr "$TEXMFHOME"
fi

echo "=== Installation Complete ==="
echo "You can now use \usepackage{moderndoc} in your LaTeX documents."
if [ "$LOCAL_MODE" = false ]; then
    echo "To use our templates, clone the repository: git clone https://github.com/tychota/moderndoc.git"
fi