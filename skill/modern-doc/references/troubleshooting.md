# Troubleshooting Guide

## Table of Contents
- [Installation Issues](#installation-issues)
- [Minted/Pygments Errors](#mintedpygments-errors)
- [Bibliography/Biber Issues](#bibliographybiber-issues)
- [Font Issues](#font-issues)
- [PDF/A Compliance Issues](#pdfa-compliance-issues)
- [Common LaTeX Errors](#common-latex-errors)
- [Build System Issues](#build-system-issues)

---

## Installation Issues

### TeX Live Not Found

**Error:** `lualatex: command not found`

**Solution:**
```bash
# macOS (Homebrew)
brew install --cask mactex

# macOS (BasicTeX - smaller)
brew install --cask basictex
sudo tlmgr update --self
sudo tlmgr install collection-fontsrecommended collection-luatex

# Ubuntu/Debian
sudo apt-get install texlive-full

# Fedora
sudo dnf install texlive-scheme-full

# Windows
# Download from https://tug.org/texlive/
```

### Missing LaTeX Packages

**Error:** `! LaTeX Error: File 'packagename.sty' not found.`

**Solution:**
```bash
# Update tlmgr
sudo tlmgr update --self

# Install specific package
sudo tlmgr install packagename

# Common modern-doc dependencies
sudo tlmgr install \
  fontspec microtype geometry polyglossia \
  biblatex biber minted tcolorbox tabularray \
  koma-script hyperref cleveref caption \
  unicode-math mathtools csquotes enumitem \
  lettrine marginnote appendix abstract \
  xcolor graphicx etoolbox
```

### Wrong LaTeX Engine

**Error:** `! Fatal fontspec error: "cannot-use-pdftex"`

**Cause:** Using pdflatex instead of lualatex.

**Solution:**
```bash
# Use lualatex, not pdflatex
lualatex --shell-escape document.tex

# Or with latexmk
latexmk -lualatex document.tex
```

---

## Minted/Pygments Errors

### Pygments Not Installed

**Error:** `! Package minted Error: You must invoke LaTeX with the -shell-escape flag.`
or `! Package minted Error: You must have 'pygmentize' installed`

**Solution:**
```bash
# Install Pygments
pip install Pygments

# Or with pip3
pip3 install Pygments

# Verify installation
pygmentize -V

# Compile with shell-escape
lualatex --shell-escape document.tex
```

### Shell Escape Not Enabled

**Error:** `! Package minted Error: You must invoke LaTeX with the -shell-escape flag.`

**Solution:**
```bash
# Command line
lualatex --shell-escape document.tex

# latexmk (add to latexmkrc)
$lualatex = 'lualatex --shell-escape %O %S';

# VS Code LaTeX Workshop (settings.json)
"latex-workshop.latex.tools": [{
  "name": "lualatex",
  "command": "lualatex",
  "args": ["--shell-escape", "-interaction=nonstopmode", "%DOC%"]
}]
```

### Minted Cache Issues

**Error:** Stale code highlighting or missing cache

**Solution:**
```bash
# Remove minted cache directories
rm -rf _minted-*

# Rebuild
lualatex --shell-escape document.tex
```

### Disable Minted (Workaround)

If minted issues persist:
```latex
\usepackage[article, minted=false]{modern-doc}

% Use listings instead
\usepackage{listings}
\begin{lstlisting}[language=Python]
code here
\end{lstlisting}
```

---

## Bibliography/Biber Issues

### Biber Not Found

**Error:** `biber: command not found`

**Solution:**
```bash
# Install biber
sudo tlmgr install biber

# Or on Ubuntu
sudo apt-get install biber
```

### Biber Version Mismatch

**Error:** `ERROR - Error: Found biblatex control file version X.Y, expected version A.B`

**Solution:**
```bash
# Update both packages
sudo tlmgr update biblatex biber

# Clear auxiliary files
rm -f *.aux *.bbl *.bcf *.blg *.run.xml
```

### Bibliography Not Appearing

**Checklist:**
1. Verify `.bib` file exists and path is correct
2. Check for `\addbibresource{file.bib}` in preamble
3. Ensure `\printbibliography` is in document
4. Run full compilation cycle:

```bash
lualatex --shell-escape document.tex
biber document
lualatex --shell-escape document.tex
lualatex --shell-escape document.tex
```

### Citation Undefined

**Error:** `LaTeX Warning: Citation 'key' undefined`

**Solution:**
1. Check citation key matches `.bib` entry exactly (case-sensitive)
2. Run biber: `biber document`
3. Recompile twice

---

## Font Issues

### Font Not Found

**Error:** `! Package fontspec Error: The font "IBMPlexSerif" cannot be found.`

**Solution 1: Use bundled fonts**
```bash
# Ensure fonts directory is in TEXMFHOME
export TEXMFHOME=/path/to/modern-latex-templates
```

**Solution 2: Install system fonts**
```bash
# macOS
cp fonts/*/*.otf ~/Library/Fonts/

# Linux
cp fonts/*/*.otf ~/.local/share/fonts/
fc-cache -fv
```

**Solution 3: Use alternative font option**
```latex
\usepackage[article, font=stix]{modern-doc}    % STIX (TeX Live)
\usepackage[article, font=palatino]{modern-doc} % TeX Gyre (TeX Live)
```

### Japanese Font Missing

**Error:** `! Package fontspec Error: The font "IBMPlexSansJP" cannot be found.`

**Solution:**
```bash
# Install Noto Sans JP (fallback)
sudo tlmgr install noto-cjk

# Or install system-wide
# macOS: Download from fonts.google.com and install
# Linux: sudo apt-get install fonts-noto-cjk
```

### Missing Italic/Bold Variants

**Warning:** `LaTeX Font Warning: Font shape ... undefined`

This is normal for CJK fonts. The warning is suppressed by modern-doc.

---

## PDF/A Compliance Issues

### PDF/A Validation Fails

**Common causes and fixes:**

1. **Embedded fonts issue:**
```latex
% Ensure all fonts are embedded (default behavior)
% Check with: pdffonts output.pdf
```

2. **Color space issue:**
```latex
% modern-doc uses sRGB by default
% Verify images are RGB, not CMYK
```

3. **Transparency issue:**
```latex
% Avoid transparency in images
% Convert: convert image.png -alpha remove image-flat.png
```

### PDF Version Mismatch

**Error:** PDF readers show wrong version

**Note:** modern-doc uses PDF 2.0 for PDF/A-4 compliance. Older readers may not fully support this. The document remains readable.

---

## Common LaTeX Errors

### Undefined Control Sequence

**Error:** `! Undefined control sequence. \somecommand`

**Causes:**
- Typo in command name
- Missing package
- Command used before definition

**Solution:**
```latex
% Check spelling
% Ensure required package is loaded
% Define command before use
```

### Missing $ Inserted

**Error:** `! Missing $ inserted.`

**Cause:** Math mode required but not active.

**Solution:**
```latex
% Wrap math in $...$
The formula $E = mc^2$ is famous.

% Or use equation environment
\begin{equation}
E = mc^2
\end{equation}
```

### Overfull/Underfull Boxes

**Warning:** `Overfull \hbox (X.Xpt too wide)`

**Solutions:**
```latex
% Allow more flexibility
\sloppy  % In preamble (global)

% Or per-paragraph
{\sloppy
Problematic paragraph text...
}

% For specific words
\hyphenation{prob-lem-at-ic}

% Use microtype (included by modern-doc)
\usepackage{microtype}
```

### Float Placement Issues

**Problem:** Figures/tables appear in wrong location

**Solutions:**
```latex
% Force placement
\begin{figure}[H]  % Requires float package

% Adjust float parameters
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}

% Clear floats
\clearpage
```

---

## Build System Issues

### Make Errors

**Error:** `make: *** No rule to make target`

**Solution:**
```bash
# Ensure you're in project root
cd /path/to/modern-latex-templates

# Check Makefile exists
ls Makefile

# Run specific target
make article
```

### latexmk Configuration

**Error:** latexmk using wrong engine

**Solution:** Create/update `latexmkrc`:
```perl
$pdf_mode = 4;  # 4 = lualatex
$lualatex = 'lualatex --shell-escape --interaction=nonstopmode %O %S';
$bibtex_use = 2;
$max_repeat = 5;
```

### Build Output Location

**Problem:** PDFs not appearing in expected location

**Solution:**
```bash
# Check output directory
ls output/

# Manual build to current directory
cd templates && latexmk -lualatex article.tex

# Using Makefile (outputs to output/)
make article && ls output/
```

---

## Debug Workflow

1. **Isolate the problem:**
   ```bash
   # Create minimal example
   cat > test.tex << 'EOF'
   \documentclass{scrartcl}
   \usepackage[article]{modern-doc}
   \begin{document}
   Hello World
   \end{document}
   EOF

   lualatex --shell-escape test.tex
   ```

2. **Check log file:**
   ```bash
   # Look for errors and warnings
   grep -E "^!" document.log
   grep -i "error\|warning" document.log | head -20
   ```

3. **Clean and rebuild:**
   ```bash
   rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.toc *.lof *.lot
   rm -rf _minted-*
   make clean && make article
   ```

4. **Verify installation:**
   ```bash
   lualatex --version
   biber --version
   pygmentize -V
   kpsewhich modern-doc.sty
   ```
