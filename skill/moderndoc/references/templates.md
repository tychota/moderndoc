# Template Reference

## Table of Contents
- [Article Template](#article-template)
- [Paper Template](#paper-template)
- [Thesis Template](#thesis-template)
- [Book Template](#book-template)
- [Report Template](#report-template)
- [Letter Template](#letter-template)

---

## Article Template

Single-column academic article for journals and short papers.

**Base class:** `scrartcl` (KOMA-Script article)

**Layout:**
- Margins: 25mm all sides
- Line spread: 1.08
- Single-sided, single-column

**Header/footer:** Author (left) / Title (right) via `\shortauthor{}` and `\shorttitle{}`

**Minimal example:**
```latex
\documentclass[11pt, a4paper, oneside]{scrartcl}
\usepackage[article, citestyle=numeric]{moderndoc}

\title{Article Title}
\author{Author Name}
\shorttitle{Short Title}
\shortauthor{A. Name}
\date{\today}

\addbibresource{references.bib}

\begin{document}
\maketitle

\begin{abstract}
Abstract text here.
\begin{keywords}
keyword1, keyword2, keyword3
\end{keywords}
\end{abstract}

\section{Introduction}
Content...

\printbibliography
\end{document}
```

---

## Paper Template

Two-column conference paper format.

**Base class:** `scrartcl` with `twocolumn` option

**Layout:**
- Margins: 18mm (sides), 22mm (top), 25mm (bottom)
- Line spread: 1.04 (compact for two-column)
- Two-column layout

**Header/footer:** Minimal (page number only)

**Special features:**
- CCS classification environment for ACM conferences
- Tighter list spacing
- Optimized section spacing

**Minimal example:**
```latex
\documentclass[11pt, a4paper, twocolumn]{scrartcl}
\usepackage[paper, citestyle=numeric]{moderndoc}

\title{Conference Paper Title}
\author{Author One \and Author Two}
\date{}

\addbibresource{references.bib}

\begin{document}
\maketitle

\begin{abstract}
Abstract for conference paper.
\begin{keywords}
keyword1, keyword2
\end{keywords}
\end{abstract}

\begin{ccsclassification}
\ccsdesc[500]{Human-centered computing~HCI design}
\ccsdesc[300]{Computing methodologies~Machine learning}
\end{ccsclassification}

\section{Introduction}
Two-column content flows automatically.

\printbibliography
\end{document}
```

---

## Thesis Template

Dissertation and long-form academic document format.

**Base class:** `scrbook` (KOMA-Script book)

**Layout:**
- Margins: 40mm inner (binding), 25mm outer
- Line spread: 1.25 (1.5-spaced for institutional requirements)
- Two-sided, chapters open on right pages

**Header/footer:** Chapter (left) / Section (right), italic styling

**Special features:**
- Full-page abstract environment
- French abstract support (`abstractfr`)
- Front/main/back matter separation
- Custom thesis metadata fields

**Document structure:**
```latex
\documentclass[11pt, a4paper, twoside, openright]{scrbook}
\usepackage[thesis, citestyle=authoryear]{moderndoc}

% Thesis metadata
\title{Thesis Title}
\author{Candidate Name}
\date{2024}

% Custom thesis fields
\newcommand{\department}{Department of Computer Science}
\newcommand{\university}{University Name}
\newcommand{\supervisor}{Prof. Supervisor Name}

\addbibresource{references.bib}

\begin{document}

% Front matter (roman numerals, plain style)
\frontmatterstyle
\maketitle

\begin{thesisabstract}
Full-page abstract in English.
\end{thesisabstract}

\begin{abstractfr}
Résumé en français (if required).
\end{abstractfr}

\tableofcontents
\listoffigures
\listoftables

% Main matter (arabic numerals, chapter headers)
\mainmatterstyle

\chapter{Introduction}
Chapter content here.

\chapter{Literature Review}
More content...

% Back matter
\backmatter
\printbibliography

\startappendices
\chapter{Supplementary Data}
Appendix content...

\end{document}
```

**Matter commands:**
- `\frontmatterstyle` - Roman page numbers, plain headers
- `\mainmatterstyle` - Arabic page numbers, chapter/section headers
- `\startappendices` - Appendix numbering (A, B, C...)

---

## Book Template

Technical book with chapters, decorative elements.

**Base class:** `scrbook`

**Layout:**
- Margins: 35mm inner, 20mm outer (binding optimized)
- Line spread: 1.10
- Two-sided, chapters open on right pages

**Special features:**
- Decorative chapter headings with large scaled numbers
- Drop caps via lettrine for chapter openings
- Per-chapter figure/table numbering
- Chapter epigraphs/quotes
- Part divisions with large headings

**Example with book features:**
```latex
\documentclass[11pt, a4paper, twoside, openright]{scrbook}
\usepackage[book, citestyle=authortitle]{moderndoc}

\title{Book Title}
\author{Author Name}
\date{2024}

\addbibresource{references.bib}

\begin{document}
\frontmatter
\maketitle
\tableofcontents

\mainmatter

\part{Foundation}

\chapter{Introduction}

\begin{chapterquote}{Albert Einstein}{1933}
Make things as simple as possible, but not simpler.
\end{chapterquote}

\lettrine{T}{his} chapter introduces the topic with a decorative drop cap.
The first paragraph continues normally after the initial letter.

Figure and table numbers reset per chapter (Figure 1.1, 1.2, then 2.1...).

\chapter{Background}
Second chapter content...

\part{Applications}

\chapter{Case Studies}
More content...

\backmatter
\printbibliography
\end{document}
```

**Drop cap usage:**
```latex
\lettrine{F}{irst} word of chapter with decorative initial.
```

---

## Report Template

Technical and business report format.

**Base class:** `scrreprt` (KOMA-Script report)

**Layout:**
- Margins: 25mm all sides
- Line spread: 1.10
- Single-sided

**Special features:**
- Document control section (version, approvals)
- Executive summary support
- Scaled chapter numbers with color
- Professional title page with report metadata

**Example:**
```latex
\documentclass[11pt, a4paper, oneside]{scrreprt}
\usepackage[report, citestyle=numeric]{moderndoc}

\title{Technical Report Title}
\author{Report Author}
\date{\today}

% Report metadata
\newcommand{\reportnumber}{TR-2024-001}
\newcommand{\reportversion}{1.0}
\newcommand{\reportstatus}{Final}

\addbibresource{references.bib}

\begin{document}
\maketitle

% Document control
\section*{Document Control}
\begin{tabular}{ll}
Report Number: & \reportnumber \\
Version: & \reportversion \\
Status: & \reportstatus \\
Date: & \today \\
\end{tabular}

\section*{Executive Summary}
Brief overview of report findings and recommendations.

\tableofcontents

\chapter{Introduction}
Report content...

\chapter{Methodology}
Methods used...

\chapter{Results}
Findings...

\chapter{Recommendations}
Conclusions and next steps...

\printbibliography
\end{document}
```

---

## Letter Template

Formal business correspondence using DIN standard.

**Base class:** `scrlttr2` (KOMA-Script letter)

**Layout:**
- DIN standard letter format
- Margins: 25mm
- Line spread: 1.05

**Special features:**
- Sender information via KOMA variables
- Multiple letters per document
- Enclosures and CC support
- No minted/biblatex (disabled by default)

**Example:**
```latex
\documentclass[DIN, 11pt, a4paper]{scrlttr2}
\usepackage[letter, minted=false, biblatex=false]{moderndoc}

% Sender information
\setkomavar{fromname}{Your Name}
\setkomavar{fromaddress}{123 Street Name\\City, Country 12345}
\setkomavar{fromemail}{your.email@example.com}
\setkomavar{fromphone}{+1 234 567 8900}
\setkomavar{signature}{Your Name}

% Optional: place/date
\setkomavar{place}{City}
\setkomavar{date}{\today}

\begin{document}

\begin{letter}{%
  Recipient Name\\
  Organization\\
  456 Address Line\\
  City, Country 67890
}

\opening{Dear Mr./Ms. Recipient,}

This is the body of the letter. Multiple paragraphs are supported.

Second paragraph of the letter with additional content.

\closing{Sincerely,}

\encl{Attachment 1\\Attachment 2}
\cc{Copy Recipient 1\\Copy Recipient 2}

\end{letter}

% Multiple letters in one document
\begin{letter}{Another Recipient\\Different Address}
\opening{Dear Colleague,}
Another letter body...
\closing{Best regards,}
\end{letter}

\end{document}
```

**KOMA letter variables:**
```latex
\setkomavar{fromname}{Name}           % Sender name
\setkomavar{fromaddress}{Address}     % Sender address
\setkomavar{fromemail}{email}         % Email
\setkomavar{fromphone}{phone}         % Phone
\setkomavar{signature}{Name}          % Signature
\setkomavar{place}{City}              % Place for date
\setkomavar{subject}{Subject}         % Letter subject
```
