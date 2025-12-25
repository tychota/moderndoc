# Tutorial: Your first document

This tutorial walks you from “zero” to a finished PDF.

You’ll learn:

- which template to use
- what the minimal file should look like
- how to build and iterate safely

---

## 0) Prerequisites

Make sure these work:

```bash
lualatex --version
latexmk --version
```

If not, follow: **How-to → Install TeX Live**

---

## 1) Create a new folder

```bash
mkdir my-doc
cd my-doc
```

Create these files:

```
my-doc/
├── main.tex
└── references.bib   (optional)
```

---

## 2) Pick a template

Use this rule:

- **Article**: most docs
- **Paper**: two-column conference layout
- **Report**: chapters + executive summary style
- **Book/Thesis**: long-form with frontmatter/mainmatter/backmatter
- **Letter**: formal correspondence

---

## 3) Minimal article (recommended starter)

```tex
\DocumentMetadata{pdfversion=2.0,pdfstandard=a-4,lang=en-US}

\documentclass[11pt,a4paper]{scrartcl}
\usepackage[
  doctype=article,
  language=en-US,
  font=plex,
  minted=true,
  biblatex=false
]{moderndoc}

\title{My First ModernDoc Document}
\author{Your Name}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
This is my first document.
\end{abstract}

\section{Introduction}
Write normally. Use semantic helpers like \term{kerning}, \foreign{raison d’être}, \software{LuaLaTeX}.

\end{document}
```

---

## 4) Build

From your document folder:

```bash
latexmk -lualatex --shell-escape main.tex
```

This produces `main.pdf` (or in `build/` depending on configuration).

### Why `--shell-escape`?

It’s required by **minted** (code highlighting). If you don’t need minted, set `minted=false` in options and rebuild without it.

> Security note: Only compile documents you trust when shell escape is enabled.

---

## 5) Add a bibliography (optional)

Create `references.bib`:

```bibtex
@book{bringhurst2004elements,
  author    = {Robert Bringhurst},
  title     = {The Elements of Typographic Style},
  year      = {2004},
  publisher = {Hartley \& Marks}
}
```

Then enable biblatex:

```tex
\usepackage[doctype=article,biblatex=true]{moderndoc}
\addbibresource{references.bib}
```

In the document:

```tex
As argued by \textcite{bringhurst2004elements}, typography exists to honor content.

\printbibliography
```

Build again with latexmk.

---

## 6) Iterate faster

### Watch mode

```bash
latexmk -lualatex --shell-escape -pvc main.tex
```

### Clean

```bash
latexmk -C
rm -rf _minted-*
```

---

## Done ✅

Next tutorial: **Writing with AI**
