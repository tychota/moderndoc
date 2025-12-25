# Template Reference

This page provides the basic structure for each document type supported by `modern-doc`. These templates contain only the essential structure needed to start a new document.

## Table of Contents
- [Article Template](#article-template)
- [Paper Template](#paper-template)
- [Thesis Template](#thesis-template)
- [Book Template](#book-template)
- [Report Template](#report-template)
- [Letter Template](#letter-template)

---

## Article Template

Standard academic article format.

```latex
\DocumentMetadata{
  pdfversion=2.0,
  pdfstandard=a-4,
  lang=en-US,
}

\documentclass[article]{modern-doc}

\addbibresource{references.bib}

\hypersetup{
  pdftitle    = {Article Title},
  pdfauthor   = {Author Name},
}

\shorttitle{Short Title}
\shortauthor{A. Name}

\begin{document}

\title{Article Title}
\author{Author Name}
\date{\today}

\maketitle

\begin{abstract}
Abstract text here.
\begin{keywords}
keyword1, keyword2
\end{keywords}
\end{abstract}

\section{Introduction}
% Your content here

\printbibliography
\end{document}
```

---

## Paper Template

Two-column conference paper format.

```latex
\DocumentMetadata{
  pdfversion=2.0,
  pdfstandard=a-4,
  lang=en-US,
}

\documentclass[paper]{modern-doc}

\addbibresource{references.bib}

\hypersetup{
  pdftitle    = {Paper Title},
  pdfauthor   = {Author Name},
}

\title{Paper Title}
\author{Author Name}
\date{}

\begin{document}
\maketitle

[\begin{abstract}]
Abstract text here.
\begin{keywords}
keyword1, keyword2
\end{keywords}
\end{abstract}
[]

\section{Introduction}
% Two-column content starts here

\printbibliography
\end{document}
```

---

## Thesis Template

Long-form academic document (Master's/PhD).

```latex
\DocumentMetadata{
  pdfversion=2.0,
  pdfstandard=a-4,
  lang=en-US,
}

\documentclass[thesis]{modern-doc}

\addbibresource{references.bib}

\hypersetup{
  pdftitle    = {Thesis Title},
  pdfauthor   = {Author Name},
}

\begin{document}

\frontmatter
\pagestyle{plain}
\maketitle

\begin{thesisabstract}
Abstract in English.
\end{thesisabstract}

\tableofcontents
\listoffigures
\listoftables

\mainmatter
\pagestyle{scrheadings}

\chapter{Introduction}
% Your content here

\backmatter
\printbibliography
\end{document}
```

---

## Book Template

Technical or academic book with parts and chapters.

```latex
\DocumentMetadata{
  pdfversion=2.0,
  pdfstandard=a-4,
  lang=en-US,
}

\documentclass[book]{modern-doc}

\addbibresource{references.bib}

\hypersetup{
  pdftitle    = {Book Title},
  pdfauthor   = {Author Name},
}

\begin{document}

\frontmatter
\maketitle
\tableofcontents

\mainmatter

\part{First Part}
\chapter{First Chapter}
\lettrine{F}{irst} word with drop cap.

\backmatter
\printbibliography
\end{document}
```

---

## Report Template

Technical and business report format.

```latex
\DocumentMetadata{
  pdfversion=2.0,
  pdfstandard=a-4,
  lang=en-US,
}

\documentclass[report]{modern-doc}

\addbibresource{references.bib}

\hypersetup{
  pdftitle    = {Report Title},
  pdfauthor   = {Author Name},
}

\begin{document}

\begin{titlepage}
  \centering
  \vspace*{2cm}
  {\headingfont\Huge\bfseries Report Title\par}
  \vfill
  {\Large Prepared by: Author Name\par}
\end{titlepage}

\pagenumbering{roman}
\tableofcontents

\pagenumbering{arabic}
\chapter{Introduction}
% Your content here

\printbibliography
\end{document}
```

---

## Letter Template

Formal business correspondence (DIN standard).

```latex
\DocumentMetadata{
  pdfversion=2.0,
  pdfstandard=a-4,
  lang=en-US,
}

\documentclass[letter, nobiblatex]{modern-doc}

\setkomavar{fromname}{Your Name}
\setkomavar{fromaddress}{Your Address}
\setkomavar{signature}{Your Name}

\begin{document}

\begin{letter}{
  Recipient Name\\
  Recipient Address
}

\setkomavar{subject}{Letter Subject}
\opening{Dear Recipient,}

Letter content here.

\closing{Sincerely,}
\end{letter}

\end{document}
```