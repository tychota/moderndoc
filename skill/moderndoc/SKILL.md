---
name: moderndoc
description: Professional LaTeX document creation using the moderndoc style package with LuaLaTeX and KOMA-Script. Use when working with .tex files that use moderndoc.sty, creating academic documents (articles, papers, theses, books, reports, letters), debugging LaTeX compilation issues, configuring PDF/A-4 archival output, setting up minted code highlighting, structuring multi-file LaTeX projects, or creating TikZ diagrams. Triggers on moderndoc package usage, LuaLaTeX compilation, KOMA-Script document classes (scrartcl, scrbook, scrreprt, scrlttr2).
---

# Moderndoc

Professional LaTeX template system for academic and technical documents. Built on LuaLaTeX + KOMA-Script with PDF/A-4 archival compliance, IBM Plex fonts, and modern typography.

## Workflow Decision Tree

**Creating a new document?**
1. Choose template type → See [references/templates.md](references/templates.md)
2. Copy template file and customize
3. Build with `make <template-name>` or `latexmk -lualatex`

**Structuring a project?**
→ See [references/project-structure.md](references/project-structure.md) for file organization

**Configuring document options?**
→ See [references/options.md](references/options.md) for all package options

**Working with LuaTeX, KOMA-Script, or packages?**
→ See [references/luatex-koma.md](references/luatex-koma.md) for detailed reference

**Creating diagrams?**
→ See [references/mermaid.md](references/mermaid.md) for TikZ patterns and conversion

**Compilation errors?**
→ See [references/troubleshooting.md](references/troubleshooting.md)

## Quick Start

Minimal document setup:

```latex
\documentclass[11pt, a4paper]{scrartcl}
\usepackage[article]{moderndoc}

\title{Document Title}
\author{Author Name}
\date{\today}

\addbibresource{references.bib}

\begin{document}
\maketitle

\begin{abstract}
Abstract text here.
\begin{keywords}
keyword1, keyword2
\end{keywords}
\end{abstract}

\section{Introduction}
Content here.

\printbibliography
\end{document}
```

Build command:
```bash
latexmk -lualatex -shell-escape document.tex
```

## Template Types

| Type | Class | Use Case |
|------|-------|----------|
| `article` | scrartcl | Journal articles, short papers |
| `paper` | scrartcl | Two-column conference papers |
| `thesis` | scrbook | Dissertations, long-form academic |
| `book` | scrbook | Technical books with chapters |
| `report` | scrreprt | Technical/business reports |
| `letter` | scrlttr2 | Formal correspondence |

Full details in [references/templates.md](references/templates.md).

## Core Package Options

```latex
\usepackage[
  article,              % Document type: article|paper|thesis|book|report|letter
  citestyle=numeric,    % Citation: numeric|authoryear|authortitle
  language=en-US,       % Language: en-US|en-GB|fr|de
  font=plex,            % Font: plex|stix|palatino
  draft=false,          % Draft mode with watermark
  minted=true,          % Code highlighting
  biblatex=true,        % Bibliography support
]{moderndoc}
```

Full options in [references/options.md](references/options.md).

## Key Features

### Quote Environments
```latex
\begin{paperquote}
  Quoted text in gray box.
\end{paperquote}

\begin{attributedquote}{Author Name}
  Quote with attribution.
\end{attributedquote}

\begin{citedquote}{Author}{2024}
  Quote with author and year.
\end{citedquote}
```

### Semantic Markup
```latex
\foreign{bon appétit}      % Foreign terms (italic)
\term{kerning}             % Technical terms
\acronym{UNESCO}           % Acronyms (small caps)
\software{LuaTeX}          % Software names (sans)
\concept{Key Term}         % Bold concepts
```

### Code Blocks (requires minted)
```latex
\begin{minted}{python}
def hello():
    print("Hello, World!")
\end{minted}
```

### Note Boxes
```latex
\begin{notebox}[Title]
  Important information.
\end{notebox}

\begin{warningbox}[Title]
  Warning message.
\end{warningbox}
```

## Project Structure

Basic layout:

```
project/
├── main.tex              # Main document
├── references.bib        # Bibliography
├── styles/
│   └── moderndoc.sty     # Style package
├── fonts/                # Bundled fonts
├── chapters/             # For books/theses
├── figures/              # Images and diagrams
├── build/                # Compilation output
└── Makefile
```

For multi-file documents:
```latex
% main.tex
\input{chapters/introduction}
\input{chapters/methodology}
```

Full guidance in [references/project-structure.md](references/project-structure.md).

## Build System

Using Make:
```bash
make article          # Build article template
make thesis           # Build thesis
make all              # Build all templates
make watch-article    # Watch mode with auto-rebuild
make clean            # Remove auxiliary files
```

Using latexmk directly:
```bash
latexmk -lualatex -shell-escape document.tex
latexmk -pvc -lualatex document.tex  # Watch mode
```

Manual compilation (full cycle):
```bash
lualatex --shell-escape document.tex
biber document
lualatex --shell-escape document.tex
lualatex --shell-escape document.tex
```

## Dependencies

**Required:**
- TeX Live 2024+ or equivalent
- LuaLaTeX compiler
- Biber (bibliography processor)
- Pygments (`pip install Pygments`) for minted

**Key LaTeX packages:**
fontspec, microtype, geometry, polyglossia, biblatex, minted, tcolorbox, tabularray, koma-script, hyperref, cleveref

## Resources

- [references/templates.md](references/templates.md) - Detailed template documentation
- [references/options.md](references/options.md) - All package options
- [references/project-structure.md](references/project-structure.md) - File organization guide
- [references/luatex-koma.md](references/luatex-koma.md) - LuaTeX, KOMA-Script, package reference
- [references/mermaid.md](references/mermaid.md) - TikZ diagrams and Mermaid conversion
- [references/troubleshooting.md](references/troubleshooting.md) - Common issues and fixes
