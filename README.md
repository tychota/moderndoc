# Modern LaTeX Templates

A comprehensive LuaLaTeX template repository for quick, professional document publishing. Designed for articles, papers, theses, and books with modern typography, PDF 2.0 output, and excellent multilingual support.

## ✨ Features

- **Modern PDF Output**: PDF 2.0 with proper metadata and hyperlinks
- **Professional Typography**: IBM Plex font family with microtype for optical kerning
- **Multilingual Support**: English, French, and Japanese out of the box
- **KOMA-Script Base**: Using `scrartcl`, `scrbook`, `scrreprt` for superior European typography
- **Modern Bibliography**: biblatex with biber, ACM/author-year styles
- **Code Highlighting**: minted with Pygments for 150+ languages
- **Styled Quote Boxes**: tcolorbox for paper extracts and callouts
- **Modern Tables**: tabularray (LaTeX3-based) for clean, flexible tables
- **Cross-References**: cleveref for smart, automatic references

## 📁 Repository Structure

```
modern-latex-templates/
├── README.md
├── Makefile
├── latexmkrc
├── styles/
│   └── moderndoc.sty      # Main style package
├── templates/
│   ├── article.tex        # Single-column article
│   ├── paper.tex          # Two-column conference paper
│   ├── thesis.tex         # Dissertation/thesis
│   ├── book.tex           # Technical book
│   └── references.bib     # Example bibliography
├── examples/
│   └── (example outputs)
├── fonts/
│   └── (optional local fonts)
└── scripts/
    └── (build scripts)
```

## 🚀 Quick Start

### Prerequisites

1. **TeX Live 2024** (or later) with LuaLaTeX
2. **Biber** for bibliography processing
3. **Pygments** for code highlighting (Python package)
4. **IBM Plex fonts** (usually included in TeX Live)

```bash
# Install Pygments (required for minted)
pip install Pygments

# Verify LuaLaTeX installation
lualatex --version
biber --version
```

### Building a Document

**Using Make:**
```bash
make article   # Build article template
make paper     # Build conference paper
make thesis    # Build thesis
make book      # Build book
make all       # Build all templates
```

**Using latexmk:**
```bash
cd templates
latexmk -lualatex article.tex
```

**Manual compilation:**
```bash
cd templates
lualatex --shell-escape article.tex
biber article
lualatex --shell-escape article.tex
lualatex --shell-escape article.tex
```

> ⚠️ **Important**: The `--shell-escape` flag is required for minted code highlighting.

## 📖 Template Overview

### Article Template (`article.tex`)
Single-column format for journal articles and general documents.
- Generous margins for readability
- 11pt base font size
- 1.08 line spread

### Paper Template (`paper.tex`)
Two-column format for conference papers.
- Compact margins for space efficiency
- Tighter line spacing
- Condensed lists

### Thesis Template (`thesis.tex`)
Full dissertation format with front matter.
- Extra binding margin
- Double-sided layout
- Chapter-based organization
- Abstract, acknowledgements, lists

### Book Template (`book.tex`)
Complete book layout with parts and chapters.
- Decorative chapter headings
- Drop caps for chapter openings
- Epigraphs
- Colophon

## 🎨 Style Package Options

The `moderndoc.sty` package accepts these options:

```latex
\usepackage[
  article,           % or: paper, thesis, book
  citestyle=numeric, % or: authoryear
  language=en-US,    % or: en-GB, fr, etc.
  minted=true,       % Enable code highlighting
  biblatex=true,     % Enable bibliography
  hyperlinks=true,   % Enable hyperref
]{moderndoc}
```

## 🔤 Typography

### Font Configuration

The template uses the IBM Plex superfamily:

| Purpose   | Font             | Style Notes                    |
|-----------|------------------|--------------------------------|
| Body      | IBM Plex Serif   | Old-style figures, ligatures  |
| Headings  | IBM Plex Sans    | Lining figures, clean lines   |
| Code      | IBM Plex Mono    | 85% scale, coding ligatures   |
| Quotes    | IBM Plex Serif   | Italic variant                |
| Japanese  | IBM Plex Sans JP | 95% scale for harmony         |

### OpenType Features

```latex
% Enabled automatically:
% - Common and TeX ligatures
% - Old-style figures in body text
% - Lining figures in headings
% - Small caps with proper tracking (5%)
```

## 📚 Bibliography

### Adding Your Bibliography

```latex
\addbibresource{your-references.bib}
```

### Citation Styles

```latex
% Numeric style (default for papers)
\usepackage[citestyle=numeric]{moderndoc}
% Result: [1], [2, 3], [4-6]

% Author-year style (default for theses)
\usepackage[citestyle=authoryear]{moderndoc}
% Result: (Smith, 2024), (Doe & Johnson, 2023)
```

### Citation Commands

```latex
\autocite{key}          % Automatic format
\textcite{key}          % "Smith (2024) argues..."
\parencite{key}         % (Smith, 2024)
\autocites{key1}{key2}  % Multiple citations
```

### ArXiv Preprints

```bibtex
@misc{example2024,
  author        = {Author, Name},
  title         = {Paper Title},
  year          = {2024},
  eprint        = {2401.12345},
  archiveprefix = {arXiv},
  primaryclass  = {cs.LG},
}
```

## 💻 Code Highlighting

### Basic Usage

```latex
% Inline code
\mintinline{python}{def hello(): pass}

% Block code
\begin{minted}{python}
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
\end{minted}
```

### With Options

```latex
\begin{minted}[
  linenos,
  bgcolor=codebg,
  fontsize=\footnotesize,
  breaklines,
]{javascript}
async function fetchData(url) {
  const response = await fetch(url);
  return response.json();
}
\end{minted}
```

### External Files

```latex
\inputminted{python}{scripts/algorithm.py}
\inputminted[firstline=10, lastline=25]{python}{code.py}
```

## 📝 Quote Boxes

### Paper Quotes (Gray Background)

```latex
\begin{paperquote}
This is an extracted quote from a paper or document.
It appears with a gray background and left border.
\end{paperquote}
```

### Attributed Quotes

```latex
\begin{attributedquote}{Robert Bringhurst, 2012}
Typography exists to honor content.
\end{attributedquote}
```

### Note and Warning Boxes

```latex
\begin{notebox}[Important]
Key information that readers should notice.
\end{notebox}

\begin{warningbox}[Caution]
Something to be careful about.
\end{warningbox}
```

## 📊 Tables

Using tabularray for modern table syntax:

```latex
\begin{table}[htbp]
  \centering
  \caption{Comparison of Methods}
  \label{tab:comparison}
  \begin{tblr}{
    colspec = {lXcc},
    row{1}  = {font=\bfseries\sffamily, bg=gray!15},
    hlines  = {0.5pt, gray!50},
    rowsep  = 3pt,
  }
    Method & Description & Accuracy & Speed \\
    Method A & First approach & 92.3\% & Fast \\
    Method B & Second approach & 94.1\% & Medium \\
    Ours & Proposed method & \textbf{96.5\%} & Fast \\
  \end{tblr}
\end{table}
```

## 🌐 Multilingual Support

### Japanese Terms

```latex
% Japanese term with reading
\jpterm{改善}{kaizen} means continuous improvement.

% Direct Japanese text
\jp{日本語テキスト}
```

### French Text

```latex
\textfrench{Voici un exemple en français.}
```

### Document-Level Language

```latex
% In preamble, polyglossia is configured:
\setmainlanguage{english}
\setotherlanguage{french}
\setotherlanguage{japanese}
```

## 🔧 Customization

### Colors

```latex
% Predefined colors in moderndoc.sty
\definecolor{mdocprimary}{RGB}{0, 95, 178}    % Deep blue
\definecolor{mdocsecondary}{RGB}{99, 102, 106} % Neutral gray
\definecolor{mdocaccent}{RGB}{204, 0, 0}       % Alert red

% Override in your document
\colorlet{mdocprimary}{blue!70!black}
```

### Page Geometry

The geometry is set based on document type, but you can override:

```latex
\geometry{
  left   = 30mm,
  right  = 25mm,
  top    = 35mm,
  bottom = 35mm,
}
```

### Custom Heading Fonts

```latex
\newfontfamily\mychapterfont{Some Other Font}
\addtokomafont{chapter}{\mychapterfont}
```

## 📐 Diagram Integration

### Mermaid Diagrams

Since mermaid doesn't integrate directly with LaTeX, use this workflow:

1. Create diagram at [mermaid.live](https://mermaid.live)
2. Export as SVG
3. Include in LaTeX:

```latex
\usepackage{svg}
\includesvg[width=0.8\textwidth]{diagrams/flowchart.svg}
```

Or convert to PDF:
```bash
# Using Inkscape
inkscape --export-pdf=diagram.pdf diagram.svg
```

### TikZ Diagrams

For native LaTeX diagrams:

```latex
\usepackage{tikz}
\usetikzlibrary{shapes, arrows, positioning}

\begin{tikzpicture}[node distance=2cm]
  \node (start) [rectangle, draw] {Start};
  \node (process) [rectangle, draw, right of=start] {Process};
  \draw [->] (start) -- (process);
\end{tikzpicture}
```

## 🐛 Troubleshooting

### Common Issues

**"Font not found" errors:**
```bash
# Check if IBM Plex is installed
fc-list | grep -i plex

# Install via TeX Live
tlmgr install plex
```

**Minted "shell-escape" error:**
```bash
# Add --shell-escape flag
lualatex --shell-escape document.tex
```

**Biber errors:**
```bash
# Clear cache and rebuild
rm -rf `biber --cache`
biber document
```

**Slow compilation:**
```latex
% In preamble, enable draft mode for faster iteration
\documentclass[draft]{scrartcl}
```

## 📄 License

This template is released under the MIT License. Use freely for academic and commercial projects.

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 📚 Resources

- [KOMA-Script Manual](https://ctan.org/pkg/koma-script)
- [biblatex Documentation](https://ctan.org/pkg/biblatex)
- [minted Documentation](https://ctan.org/pkg/minted)
- [tabularray Documentation](https://ctan.org/pkg/tabularray)
- [fontspec Manual](https://ctan.org/pkg/fontspec)
- [ConTeXt Font Manual](https://www.pragma-ade.nl/general/manuals/fonts-mkiv.pdf)

---

Made with ❤️ for the academic community
