# Project structure

## Single-file (article/paper/letter)

```
project/
├── main.tex
├── references.bib
├── figures/
│   └── diagram.pdf
├── build/            # ignored
├── output/           # ignored (optional)
├── Makefile
└── latexmkrc
```

### main.tex (pattern)

```tex
\DocumentMetadata{pdfversion=2.0,pdfstandard=a-4,lang=en-US}
\documentclass[11pt,a4paper]{scrartcl}
\usepackage[doctype=article]{moderndoc}

\begin{document}
\title{Title}\author{Author}\maketitle
\end{document}
```

## Multi-file (report/thesis/book)

```
project/
├── main.tex
├── preamble.tex
├── metadata.tex
├── references.bib
├── content/
│   ├── intro.tex
│   └── conclusion.tex
├── figures/
│   └── diagrams/
├── build/
└── Makefile
```

### main.tex (pattern)

```tex
\documentclass[12pt,a4paper,twoside,open=right]{scrbook}
\input{preamble}
\input{metadata}

\begin{document}
\frontmatter
\maketitle
\tableofcontents

\mainmatter
\input{content/intro}
\input{content/conclusion}

\backmatter
\printbibliography
\end{document}
```

### preamble.tex

```tex
\usepackage[doctype=thesis,citestyle=authoryear]{moderndoc}
\addbibresource{references.bib}
\graphicspath{{figures/}{figures/diagrams/}}
```

## Build system

### latexmkrc (recommended)

```perl
$pdf_mode = 4;  # lualatex
$lualatex = 'lualatex --shell-escape --interaction=nonstopmode %O %S';
$bibtex_use = 2;  # biber
$max_repeat = 5;

$out_dir = 'build';
$aux_dir = 'build';
$cleanup_mode = 2;
```

### Makefile (minimal)

```makefile
NAME=main
BUILDDIR=build
OUTDIR=output

.PHONY: pdf watch clean

pdf:
	mkdir -p $(BUILDDIR) $(OUTDIR)
	latexmk -lualatex --shell-escape -outdir=$(BUILDDIR) $(NAME).tex
	cp $(BUILDDIR)/$(NAME).pdf $(OUTDIR)/

watch:
	latexmk -lualatex --shell-escape -pvc -outdir=$(BUILDDIR) $(NAME).tex

clean:
	rm -rf $(BUILDDIR) _minted-*
```

## .gitignore (recommended)

```gitignore
build/
output/
_minted-*/
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
```
