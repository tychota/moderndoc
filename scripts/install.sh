#!/bin/bash

# ModernDoc Installer
# Multi-platform (Linux, macOS) installer for ModernDoc dependencies and style files.

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEPS_FILE="$PROJECT_ROOT/dependencies.txt"
STYLE_FILE="$PROJECT_ROOT/styles/moderndoc.sty"

echo "=== ModernDoc Installer ==="

# 1. Check Requirements
echo "Checking requirements..."

if ! command -v tlmgr &> /dev/null; then
    echo "Error: tlmgr (TeX Live Manager) not found. Please install TeX Live 2024+."
    exit 1
fi

if ! command -v lualatex &> /dev/null; then
    echo "Error: lualatex not found."
    exit 1
fi

# 2. Install Python Dependencies
echo "Installing Python dependencies (Pygments)..."
if command -v pip3 &> /dev/null; then
    pip3 install Pygments
elif command -v pip &> /dev/null; then
    pip install Pygments
else
    echo "Warning: pip not found. Pygments (for minted) might not be installed."
fi

# 3. Install LaTeX Packages
if [ -f "$DEPS_FILE" ]; then
    echo "Installing LaTeX packages from dependencies.txt..."
    # Read packages into an array, skipping comments
    mapfile -t PKGS < <(grep -v '^#' "$DEPS_FILE")
    
    # Try to install (may need sudo depending on TL installation)
    if [ "$(id -u)" -ne 0 ] && [ -w "$(tlmgr --version | grep 'root:' | awk '{print $2}')" ]; then
        tlmgr install "${PKGS[@]}"
    else
        echo "Note: Using sudo for tlmgr installation..."
        sudo tlmgr install "${PKGS[@]}"
    fi
else
    echo "Warning: dependencies.txt not found. Run generate_dependencies.sh first?"
fi

# 4. Install moderndoc.sty
echo "Installing moderndoc.sty to local TEXMF directory..."

TEXMFHOME=$(kpsewhich -var-value=TEXMFHOME)
TARGET_DIR="$TEXMFHOME/tex/latex/moderndoc"

mkdir -p "$TARGET_DIR"
cp "$STYLE_FILE" "$TARGET_DIR/"

echo "Installed to $TARGET_DIR"

# 5. Update TeX Database
echo "Updating TeX filename database..."
if command -v mktexlsr &> /dev/null; then
    mktexlsr "$TEXMFHOME"
fi

# 6. Setup Mode (Fetch Skills)
if [[ "$1" == "--setup" ]]; then
    echo "Setup mode: Installing ModernDoc Skill..."
    # Placeholder for fetching skill - for now we just acknowledge the local one
    # In a real library, this might download the .skill file to a standard location.
    echo "Skill file is available at: $PROJECT_ROOT/moderndoc.skill"
    echo "You can provide this file to your AI agent (Claude/GPT) to enable ModernDoc support."
fi

echo "=== Installation Complete ==="
echo "Try building a template: make article"
