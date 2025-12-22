# Modern LaTeX Templates

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Fonts: OFL](https://img.shields.io/badge/Fonts-OFL%201.1-orange.svg)](fonts/OFL-LICENSE.txt)
[![LuaLaTeX](https://img.shields.io/badge/Engine-LuaLaTeX-green.svg)](https://www.luatex.org/)

A comprehensive LuaLaTeX template repository for quick, professional document publishing. Designed for articles, papers, theses, books, reports, and letters with modern typography, PDF 2.0 output, and excellent multilingual support.

**Batteries included**: Ships with IBM Plex fonts — no system font installation required.

## Features

- **Modern PDF Output**: PDF 2.0 with proper metadata and hyperlinks
- **Professional Typography**: IBM Plex font family with microtype for optical kerning
- **Bundled Fonts**: IBM Plex (Serif, Sans, Mono, Japanese) included — works offline
- **Publication Quality**: Widow/orphan control, float optimization, proper caption styling
- **Multilingual Support**: English, French, German, and Japanese out of the box
- **Context-Sensitive Quotes**: Automatic quotation marks via csquotes
- **KOMA-Script Base**: Using `scrartcl`, `scrbook`, `scrreprt`, `scrlttr2` for superior European typography
- **Modern Bibliography**: biblatex with biber, back-references, enhanced DOI/arXiv formatting
- **Code Highlighting**: minted with Pygments for 150+ languages
- **Styled Quote Boxes**: tcolorbox for paper extracts and callouts with author/year attribution
- **Modern Tables**: tabularray (LaTeX3-based) for clean, flexible tables
- **Cross-References**: cleveref for smart, automatic references
- **Print Mode**: Option to remove colored links for print output

## Repository Structure

```
modern-latex-templates/
├── LICENSE                # MIT license (repository code)
├── README.md
├── Makefile
├── latexmkrc
├── fonts/                 # Bundled IBM Plex fonts (OFL licensed)
│   ├── OFL-LICENSE.txt    # SIL Open Font License
│   ├── Serif/             # IBM Plex Serif (body text)
│   ├── Sans/              # IBM Plex Sans (headings)
│   ├── Mono/              # IBM Plex Mono (code)
│   └── SansJP/            # IBM Plex Sans JP (Japanese)
├── styles/
│   └── moderndoc.sty      # Main style package (v2.0)
├── templates/
│   ├── article.tex        # Single-column article
│   ├── paper.tex          # Two-column conference paper
│   ├── thesis.tex         # Dissertation/thesis
│   ├── book.tex           # Technical book
│   ├── report.tex         # Technical report
│   ├── letter.tex         # Formal letter
│   ├── minimal.tex        # Minimal test template
│   └── references.bib     # Example bibliography
├── build/                 # Build output directory
└── output/                # Final PDF output
```

## Quick Start

### Prerequisites

1. **TeX Live 2024** (or later) with LuaLaTeX
2. **Biber** for bibliography processing
3. **Pygments** for code highlighting (Python package)

> **Note**: IBM Plex fonts are bundled in the `fonts/` directory — no separate installation needed.

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
make report    # Build technical report
make letter    # Build formal letter
make all       # Build all templates
make clean     # Remove auxiliary files
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

> **Important**: The `--shell-escape` flag is required for minted code highlighting.

## Template Overview

### Article Template (`article.tex`)
Single-column format for journal articles and general documents.
- 25mm margins, 11pt font, 1.08 line spread
- Author/title running headers
- Keywords environment for abstract

### Paper Template (`paper.tex`)
Two-column format for conference papers.
- 18mm margins, 10pt font, 1.04 line spread
- Minimal headers (page number only)
- Keywords and CCS classification environments

### Thesis Template (`thesis.tex`)
Full dissertation format with front matter.
- 40mm binding margin, 25mm outer
- Full-page abstract with French translation support
- Chapter/section headers with page numbers
- 1.25 line spread (1.5-spaced)

### Book Template (`book.tex`)
Complete book layout with parts and chapters.
- 35mm inner / 20mm outer for binding
- Decorative chapter headings with drop caps
- Chapter epigraphs via `chapterquote` environment
- Per-chapter figure/table numbering

### Report Template (`report.tex`) - NEW
Technical/business report format.
- Document control section (version history, approvals)
- Executive summary
- Professional chapter styling

### Letter Template (`letter.tex`) - NEW
Formal business letter using KOMA-Script scrlttr2.
- Sender/recipient formatting
- Multiple letters per document
- Enclosures and CC support

## Style Package Options

The `moderndoc.sty` package (v2.0) accepts these options:

```latex
\usepackage[
  % Document type (choose one)
  article,           % or: paper, thesis, book, report, letter

  % Citation style
  citestyle=numeric, % or: authoryear, authortitle

  % Language
  language=en-US,    % or: en-GB, fr, de

  % Font family
  font=plex,         % or: stix, palatino

  % Feature toggles
  draft=false,       % Add watermark & line numbers
  minted=true,       % Enable code highlighting
  biblatex=true,     % Enable bibliography
  hyperlinks=true,   % Enable hyperref

  % Output mode
  print=false,       % Remove colored links for printing
  makeindex=false,   % Enable index generation
]{moderndoc}
```

### Document Type Settings

| Type | Inner/Left | Outer/Right | Line Spread | Headers |
|------|------------|-------------|-------------|---------|
| Article | 25mm | 25mm | 1.08 | Author / Title |
| Paper | 18mm | 18mm | 1.04 | Page only |
| Thesis | 40mm | 25mm | 1.25 | Chapter / Section |
| Book | 35mm | 20mm | 1.10 | Chapter / Section |
| Report | 25mm | 25mm | 1.10 | Section / Page |
| Letter | 25mm | 25mm | 1.05 | None |

### Font Selection

The `font` option controls the typeface family:

- `plex` (default): IBM Plex superfamily (Serif body, Sans headings, Mono code)
- `stix`: STIX Two Text (Times-like). Traditional, excellent math support
- `palatino`: TeX Gyre Pagella (body) and Heros (headings)

### Print Mode

Enable `print=true` to remove colored hyperlinks for print-ready output:

```latex
\usepackage[article, print=true]{moderndoc}
```

## Quote Environments

### Paper Quotes (Gray Background)

```latex
\begin{paperquote}
This is an extracted quote from a paper or document.
\end{paperquote}
```

### Attributed Quotes (Author Only)

```latex
\begin{attributedquote}{Robert Bringhurst}
Typography exists to honor content.
\end{attributedquote}
```

### Cited Quotes (Author and Year) - NEW

```latex
\begin{citedquote}{Robert Bringhurst}{1992}
Typography is the craft of endowing human language with a durable visual form.
\end{citedquote}
```

### Chapter Epigraphs (for Books/Thesis) - NEW

```latex
\begin{chapterquote}{Albert Einstein}{1933}
Make things as simple as possible, but not simpler.
\end{chapterquote}
```

### Inline Quotes (Context-Sensitive) - NEW

```latex
% Automatic quotation marks based on language
\q{This is a quoted phrase}     % "This is a quoted phrase"
\qq{Nested quote}               % 'Nested quote'
\enquote{Full csquotes command} % Same as \q{}
```

## Abstract and Keywords

### Article/Paper Abstract

```latex
\begin{abstract}
Your abstract text here.

\begin{keywords}
machine learning, optimization, neural networks
\end{keywords}
\end{abstract}
```

### Paper with CCS Classification - NEW

```latex
\begin{abstract}
Abstract text...

\begin{keywords}
keyword1, keyword2
\end{keywords}

\begin{ccsclassification}
Computing methodologies → Machine learning
\end{ccsclassification}
\end{abstract}
```

### Thesis Abstract (Full Page) - NEW

```latex
\begin{thesisabstract}
Full thesis abstract with proper formatting...
\end{thesisabstract}

% French abstract (Résumé)
\begin{abstractfr}
Résumé en français...
\end{abstractfr}
```

## Semantic Markup Commands - NEW

```latex
\foreign{bon appétit}           % Foreign terms (italic)
\term{kerning}                  % Technical terms (with index if enabled)
\acronym{UNESCO}                % Acronyms (small caps)
\bookref{The TeXbook}           % Book titles (italic)
\software{LuaTeX}               % Software names (sans-serif)
\email{user@example.com}        % Email addresses (linked)
```

### Mathematics Helpers

```latex
$\argmax_{x} f(x)$              % arg max operator
$\argmin_{x} f(x)$              % arg min operator
$\abs{x}$                       % |x| absolute value
$\norm{v}$                      % ||v|| norm
$\set{a, b, c}$                 % {a, b, c} set notation
```

## Bibliography

### Enhanced Configuration (v2.0)

The bibliography now includes:
- Back-references to citing pages
- Improved DOI/URL/arXiv formatting
- Sorted citations
- Language-aware formatting

### Citation Commands

```latex
\autocite{key}          % Automatic format
\textcite{key}          % "Smith (2024) argues..."
\parencite{key}         % (Smith, 2024)
\autocites{key1}{key2}  % Multiple citations
```

## Headers and Footers

### Setting Article Headers - NEW

For articles, set plain-text versions for running headers:

```latex
\shorttitle{Short Title for Headers}
\shortauthor{First Author \& Second Author}
```

## Appendix Handling - NEW

### For Book/Thesis

```latex
\backmatter
\startappendices  % Resets figure/table numbering to A.1, A.2, etc.

\chapter{Additional Data}
...
```

## Index Generation - NEW

Enable with the `makeindex` option:

```latex
\usepackage[article, makeindex]{moderndoc}

% In document:
\idx{term}              % Add term to index
\idxbf{important term}  % Add with bold page number
\term{technical term}   % Auto-indexed term

% At end:
\printindex
```

## Troubleshooting

### Common Issues

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

**Font not found (when using system fonts instead of bundled):**
```bash
# Check if IBM Plex is installed system-wide
fc-list | grep -i plex

# Or install via TeX Live
tlmgr install plex
```

### KOMA-Script Warnings

Warnings about `fancyhdr` or `titlesec` with KOMA-Script classes are expected and can be safely ignored. We use these packages intentionally for enhanced control.

## Publication Quality Features

The moderndoc package includes several features for publication-ready output:

- **Widow/Orphan Control**: Prevents single lines at page breaks
- **Float Optimization**: Better figure/table placement
- **Caption Styling**: Tables above, figures below
- **Emergency Stretch**: Avoids overfull boxes
- **Per-Chapter Numbering**: For books and theses (Figure 3.2, Table 5.1)

## License

- **Code & Templates**: [MIT License](LICENSE)
- **IBM Plex Fonts**: [SIL Open Font License 1.1](fonts/OFL-LICENSE.txt)

Use freely for academic and commercial projects.

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## Resources

- [KOMA-Script Manual](https://ctan.org/pkg/koma-script)
- [biblatex Documentation](https://ctan.org/pkg/biblatex)
- [csquotes Documentation](https://ctan.org/pkg/csquotes)
- [minted Documentation](https://ctan.org/pkg/minted)
- [tabularray Documentation](https://ctan.org/pkg/tabularray)
- [fontspec Manual](https://ctan.org/pkg/fontspec)

---

Made with care for the academic community
