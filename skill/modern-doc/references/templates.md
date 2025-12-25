# Templates

These templates use **KOMA-Script classes directly** and load the **moderndoc** package.

## Quick rules

- Always use **LuaLaTeX** (not pdfLaTeX).
- For PDF/A-4, include `\DocumentMetadata{pdfversion=2.0,pdfstandard=a-4,...}`.
- Only add `\addbibresource{...}` and `\printbibliography` if biblatex is enabled.
- For code blocks: minted requires `--shell-escape`.

## 1) Article (single-column)

```tex
\DocumentMetadata{pdfversion=2.0,pdfstandard=a-4,lang=en-US}

\documentclass[11pt,a4paper]{scrartcl}
\usepackage[
  doctype=article,
  language=en-US,
  font=plex,
  citestyle=numeric,
  minted=true,
  biblatex=true
]{moderndoc}

\addbibresource{references.bib}

\hypersetup{
  pdftitle  = {Article Title},
  pdfauthor = {Author Name},
}

\shorttitle{Short Title}
\shortauthor{A. Name}

\title{Article Title}
\author{Author Name}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
Abstract text.
\begin{keywords}
keyword1, keyword2
\end{keywords}
\end{abstract}

\section{Introduction}
Write content using semantic markup: \term{kerning}, \foreign{raison d'être}, \software{LuaLaTeX}.

\printbibliography
\end{document}
```

## 2) Paper (two-column conference style)

```tex
\DocumentMetadata{pdfversion=2.0,pdfstandard=a-4,lang=en-US}

\documentclass[10pt,a4paper,twocolumn]{scrartcl}
\usepackage[
  doctype=paper,
  language=en-US,
  font=plex,
  citestyle=numeric,
  minted=true,
  biblatex=true
]{moderndoc}

\addbibresource{references.bib}

\title{Paper Title\\\large Optional Subtitle}
\author{Jane Doe \and John Smith}
\date{}

\begin{document}
\maketitle

\begin{abstract}
Two-column abstract (kept simple and robust).
\begin{keywords}
typography, layout, latex
\end{keywords}
\end{abstract}

\section{Introduction}
Two-column content.

\printbibliography
\end{document}
```

**If you want “full-width title + abstract above columns”:** Use the standard LaTeX idiom:

```tex
\twocolumn[
  \maketitle
  \begin{abstract}
  ...
  \end{abstract}
  \vspace{1em}
]
```

(Do this only if you really need it; it’s more fragile.)

## 3) Report (chapters)

```tex
\DocumentMetadata{pdfversion=2.0,pdfstandard=a-4,lang=en-US}

\documentclass[11pt,a4paper]{scrreprt}
\usepackage[
  doctype=report,
  language=en-US,
  font=plex,
  citestyle=numeric,
  minted=true,
  biblatex=true
]{moderndoc}

\addbibresource{references.bib}

\hypersetup{
  pdftitle  = {Report Title},
  pdfauthor = {Team Name},
}

\begin{document}

\begin{titlepage}
  \centering
  \vspace*{2cm}
  {\headingfont\Huge\bfseries Report Title\par}
  \vspace{0.5cm}
  {\headingfont\Large 2025 Edition\par}
  \vfill
  {\Large Prepared by: Team Name\par}
  \vspace{0.5cm}
  {\large \today\par}
\end{titlepage}

\tableofcontents

\chapter{Executive Summary}
...

\chapter{Findings}
...

\printbibliography
\end{document}
```

## 4) Thesis (scrbook recommended)

```tex
\DocumentMetadata{pdfversion=2.0,pdfstandard=a-4,lang=en-US}

\documentclass[12pt,a4paper,twoside,open=right]{scrbook}
\usepackage[
  doctype=thesis,
  language=en-US,
  font=plex,
  citestyle=authoryear,
  minted=true,
  biblatex=true,
  bcor=10mm
]{moderndoc}

\addbibresource{references.bib}

\title{Thesis Title}
\author{Author Name}
\date{December 2025}

\begin{document}

\frontmatter
\maketitle

\begin{thesisabstract}
Abstract text.
\end{thesisabstract}

\tableofcontents
\listoffigures
\listoftables

\mainmatter
\chapter{Introduction}
...

\backmatter
\printbibliography
\end{document}
```

## 5) Book

```tex
\DocumentMetadata{pdfversion=2.0,pdfstandard=a-4,lang=en-GB}

\documentclass[11pt,a4paper,twoside,open=right]{scrbook}
\usepackage[
  doctype=book,
  language=en-GB,
  font=plex,
  citestyle=authortitle,
  minted=true,
  biblatex=true,
  bcor=8mm
]{moderndoc}

\addbibresource{references.bib}

\title{Book Title}
\author{Author Name}
\date{\today}

\begin{document}
\frontmatter
\maketitle
\tableofcontents

\mainmatter
\chapter{Chapter One}
\dropcap{T}{his} is a house-styled drop cap.

\backmatter
\printbibliography
\end{document}
```

## 6) Letter (scrlttr2)

```tex
\DocumentMetadata{pdfversion=2.0,pdfstandard=a-4,lang=en-GB}

\documentclass[11pt,a4paper]{scrlttr2}
\usepackage[
  doctype=letter,
  language=en-GB,
  font=plex,
  minted=false,
  biblatex=false
]{moderndoc}

\setkomavar{fromname}{Your Name}
\setkomavar{fromaddress}{Street\\City\\Country}
\setkomavar{signature}{Your Name}
\setkomavar{date}{\today}

\begin{document}

\begin{letter}{Recipient\\Address}
\setkomavar{subject}{Subject line}
\opening{Dear Recipient,}

Letter content.

\closing{Sincerely,}
\end{letter}

\end{document}
```
