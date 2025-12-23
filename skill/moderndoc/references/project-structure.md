# Project Structure

## Table of Contents
- [Single-File Documents](#single-file-documents)
- [Multi-File Documents](#multi-file-documents)
- [Thesis/Book Structure](#thesisbook-structure)
- [Shared Resources](#shared-resources)
- [Build Configuration](#build-configuration)

---

## Single-File Documents

For articles, papers, letters, and short reports.

```
project/
├── document.tex          # Main document
├── references.bib        # Bibliography
├── figures/              # Images and diagrams
│   ├── figure1.pdf
│   └── diagram.tikz
├── styles/               # Style package
│   └── moderndoc.sty
├── fonts/                # Bundled fonts (optional)
│   ├── Serif/
│   ├── Sans/
│   └── Mono/
├── build/                # Compilation output (gitignored)
├── Makefile              # Build automation
└── latexmkrc             # latexmk configuration
```

### Document Template

```latex
% document.tex
\documentclass[11pt, a4paper]{scrartcl}
\usepackage[article]{moderndoc}

\title{Document Title}
\author{Author Name}
\date{\today}

\addbibresource{references.bib}
\graphicspath{{figures/}}

\begin{document}
\maketitle
\begin{abstract}
  Abstract text.
\end{abstract}

\section{Introduction}
Content...

\printbibliography
\end{document}
```

---

## Multi-File Documents

For reports and medium-length documents with modular content.

```
project/
├── main.tex              # Master document
├── preamble.tex          # Package imports, settings
├── metadata.tex          # Title, author, date
├── references.bib
│
├── content/              # Document sections
│   ├── introduction.tex
│   ├── methodology.tex
│   ├── results.tex
│   └── conclusion.tex
│
├── figures/
│   ├── plots/
│   └── diagrams/
│
├── tables/               # External table files (optional)
│   └── data-table.tex
│
├── styles/
│   └── moderndoc.sty
│
├── build/
└── Makefile
```

### Master Document

```latex
% main.tex
\documentclass[11pt, a4paper]{scrreprt}
\input{preamble}
\input{metadata}

\begin{document}
\maketitle
\tableofcontents

\input{content/introduction}
\input{content/methodology}
\input{content/results}
\input{content/conclusion}

\printbibliography
\end{document}
```

### Preamble File

```latex
% preamble.tex
\usepackage[report, citestyle=numeric]{moderndoc}

\addbibresource{references.bib}
\graphicspath{{figures/}{figures/plots/}{figures/diagrams/}}

% Project-specific commands
\newcommand{\projectname}{Project Name}
\newcommand{\version}{1.0}
```

### Metadata File

```latex
% metadata.tex
\title{\projectname}
\author{Author Name}
\date{Version \version{} --- \today}
```

### Content Files

```latex
% content/introduction.tex
\chapter{Introduction}

This chapter introduces...

\section{Background}
Background information...

\section{Objectives}
The objectives are...
```

---

## Thesis/Book Structure

For dissertations, books, and long documents with parts and chapters.

```
project/
├── main.tex              # Master document
├── preamble.tex          # Packages and configuration
├── metadata.tex          # Thesis/book metadata
├── references.bib
│
├── frontmatter/          # Front matter elements
│   ├── titlepage.tex
│   ├── abstract.tex
│   ├── abstract-fr.tex   # French abstract (if required)
│   ├── dedication.tex
│   ├── acknowledgments.tex
│   └── notation.tex      # List of symbols
│
├── mainmatter/           # Main content
│   ├── part1/            # Part I
│   │   ├── chapter1.tex
│   │   └── chapter2.tex
│   ├── part2/            # Part II
│   │   ├── chapter3.tex
│   │   └── chapter4.tex
│   └── conclusion.tex
│
├── backmatter/           # Back matter
│   ├── appendix-a.tex
│   ├── appendix-b.tex
│   └── glossary.tex
│
├── figures/
│   ├── chapter1/
│   ├── chapter2/
│   └── ...
│
├── code/                 # Code listings (if separate)
│   ├── algorithm1.py
│   └── script.sh
│
├── data/                 # Data files for tables/plots
│   └── results.csv
│
├── styles/
│   └── moderndoc.sty
│
├── fonts/
├── build/
└── Makefile
```

### Master Document (Thesis)

```latex
% main.tex
\documentclass[11pt, a4paper, twoside, openright]{scrbook}
\input{preamble}
\input{metadata}

\begin{document}

% === Front Matter ===
\frontmatterstyle
\input{frontmatter/titlepage}
\input{frontmatter/abstract}
\input{frontmatter/abstract-fr}
\input{frontmatter/dedication}
\input{frontmatter/acknowledgments}

\tableofcontents
\listoffigures
\listoftables
\input{frontmatter/notation}

% === Main Matter ===
\mainmatterstyle

\part{Foundations}
\input{mainmatter/part1/chapter1}
\input{mainmatter/part1/chapter2}

\part{Contributions}
\input{mainmatter/part2/chapter3}
\input{mainmatter/part2/chapter4}

\input{mainmatter/conclusion}

% === Back Matter ===
\backmatter
\printbibliography[heading=bibintoc]

\startappendices
\input{backmatter/appendix-a}
\input{backmatter/appendix-b}

\end{document}
```

### Chapter File

```latex
% mainmatter/part1/chapter1.tex
\chapter{Introduction}
\label{ch:introduction}

\begin{chapterquote}{Donald Knuth}{1984}
  Premature optimization is the root of all evil.
\end{chapterquote}

\lettrine{T}{his} chapter provides an introduction to the research.

\section{Motivation}
\label{sec:motivation}
The motivation for this work...

\section{Research Questions}
\label{sec:questions}
We address the following questions:
\begin{enumerate}
  \item First question
  \item Second question
\end{enumerate}

\section{Contributions}
\label{sec:contributions}
The main contributions are...

\section{Outline}
\label{sec:outline}
Chapter~\ref{ch:background} presents...
```

---

## Shared Resources

### Multiple Documents with Shared Style

```
organization/
├── shared/                   # Shared across all documents
│   ├── styles/
│   │   └── moderndoc.sty
│   ├── fonts/
│   ├── logos/
│   │   ├── company-logo.pdf
│   │   └── university-logo.pdf
│   └── templates/
│       ├── article-template.tex
│       └── report-template.tex
│
├── paper-2024-conference/    # Individual project
│   ├── main.tex
│   ├── references.bib
│   └── figures/
│
├── thesis-phd/               # Another project
│   ├── main.tex
│   └── ...
│
└── report-quarterly/
    ├── main.tex
    └── ...
```

### Symlink Setup

```bash
# In each project directory
ln -s ../shared/styles ./styles
ln -s ../shared/fonts ./fonts
```

### TEXMFHOME Configuration

```bash
# Add shared directory to TeX search path
export TEXMFHOME=~/organization/shared

# Or in latexmkrc
$ENV{'TEXMFHOME'} = "$ENV{'HOME'}/organization/shared";
```

---

## Build Configuration

### Makefile

```makefile
# Project Makefile
NAME = main
BUILDDIR = build
OUTDIR = output

# Detect OS for open command
UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
    OPEN = open
else
    OPEN = xdg-open
endif

.PHONY: all pdf watch clean distclean view

all: pdf

pdf:
	@mkdir -p $(BUILDDIR) $(OUTDIR)
	latexmk -lualatex -shell-escape \
		-outdir=$(BUILDDIR) \
		$(NAME).tex
	@cp $(BUILDDIR)/$(NAME).pdf $(OUTDIR)/

watch:
	latexmk -lualatex -shell-escape -pvc \
		-outdir=$(BUILDDIR) \
		$(NAME).tex

view: pdf
	$(OPEN) $(OUTDIR)/$(NAME).pdf

clean:
	rm -rf $(BUILDDIR)
	rm -rf _minted-*

distclean: clean
	rm -rf $(OUTDIR)
```

### latexmkrc

```perl
# latexmkrc
$pdf_mode = 4;  # lualatex
$lualatex = 'lualatex --shell-escape --interaction=nonstopmode %O %S';
$biber = 'biber --validate-datamodel %O %S';
$bibtex_use = 2;
$max_repeat = 5;

# Output directory
$out_dir = 'build';
$aux_dir = 'build';

# Clean extensions
$clean_ext = 'bbl bcf blg run.xml synctex.gz';

# Custom dependencies
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
sub run_makeglossaries {
    system("makeglossaries $_[0]");
}
```

### .gitignore

```gitignore
# Build output
build/
output/

# Auxiliary files
*.aux
*.bbl
*.bcf
*.blg
*.fdb_latexmk
*.fls
*.log
*.out
*.run.xml
*.synctex.gz
*.toc
*.lof
*.lot

# Minted cache
_minted-*/

# Editor files
*.swp
*~
.DS_Store

# Keep style and fonts tracked
!styles/
!fonts/
```

### VS Code Integration

```json
// .vscode/settings.json
{
  "latex-workshop.latex.tools": [
    {
      "name": "lualatex",
      "command": "lualatex",
      "args": [
        "--shell-escape",
        "--synctex=1",
        "--interaction=nonstopmode",
        "--output-directory=build",
        "%DOC%"
      ]
    },
    {
      "name": "biber",
      "command": "biber",
      "args": ["--output-directory=build", "%DOCFILE%"]
    }
  ],
  "latex-workshop.latex.recipes": [
    {
      "name": "lualatex -> biber -> lualatex x2",
      "tools": ["lualatex", "biber", "lualatex", "lualatex"]
    }
  ],
  "latex-workshop.latex.outDir": "build"
}
```

---

## Best Practices

1. **Separate concerns**: Keep content, configuration, and resources in distinct directories
2. **Use relative paths**: `\graphicspath{}` and `\input{}` for portability
3. **One chapter per file**: Easier collaboration and version control
4. **Consistent naming**: `chapter-01.tex`, `figure-methodology.pdf`
5. **Build artifacts outside source**: Use `build/` directory
6. **Version control**: Track `.tex`, `.bib`, styles; ignore build outputs
7. **Symlink shared resources**: Avoid duplication across projects
