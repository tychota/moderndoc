# Package Options Reference

## Table of Contents

- [Document Type Options](#document-type-options)
- [Citation Style Options](#citation-style-options)
- [Language Options](#language-options)
- [Font Options](#font-options)
- [Feature Toggle Options](#feature-toggle-options)
- [Color Customization](#color-customization)
- [Complete Options Example](#complete-options-example)

---

## Document Type Options

Mutually exclusive. Choose one based on document purpose.

| Option | KOMA Class | Layout | Line Spread |
| --- | --- | --- | --- |
| `article` | scrartcl | 350pt textwidth (~66 chars), single-column | 1.08 |
| `paper` | scrartcl | 174mm textwidth, two-column (~45 chars/col) | 1.04 |
| `thesis` | scrbook | 350pt textwidth, 35mm/25mm binding | 1.25 |
| `book` | scrbook | 350pt textwidth, 30mm/22mm binding | 1.10 |
| `report` | scrreprt | 350pt textwidth, centered | 1.10 |
| `letter` | scrlttr2 | DIN standard format | 1.05 |

> **Typography Note**: Text widths follow Bringhurst's recommendation of 45-75 characters per line (66 optimal). At 11pt IBM Plex Serif, 350pt ≈ 66 characters.

**Usage:**

```latex
\usepackage[article]{moderndoc}    % Single-column article
\usepackage[paper]{moderndoc}      % Two-column conference paper
\usepackage[thesis]{moderndoc}     % Academic thesis
\usepackage[book]{moderndoc}       % Technical book
\usepackage[report]{moderndoc}     % Technical report
\usepackage[letter]{moderndoc}     % Formal letter
```

---

## Citation Style Options

Control bibliography and citation formatting.

| Option                  | Format       | Example       |
| ----------------------- | ------------ | ------------- |
| `citestyle=numeric`     | Numbered     | [1], [2], [3] |
| `citestyle=authoryear`  | Author-date  | (Smith, 2024) |
| `citestyle=authortitle` | Author-title | (Smith 2024a) |

**Usage:**

```latex
\usepackage[article, citestyle=numeric]{moderndoc}
\usepackage[thesis, citestyle=authoryear]{moderndoc}
```

**Citation commands:**

```latex
\cite{key}           % Standard citation
\parencite{key}      % Parenthetical: (Smith 2024)
\textcite{key}       % Textual: Smith (2024)
\citeauthor{key}     % Author only: Smith
\citeyear{key}       % Year only: 2024
\cite[p.~42]{key}    % With page: [1, p. 42]
```

---

## Language Options

Set document language for hyphenation, quotes, and localization.

| Option           | Language         | Quote Style         |
| ---------------- | ---------------- | ------------------- |
| `language=en-US` | American English | "double" 'single'   |
| `language=en-GB` | British English  | 'single' "double"   |
| `language=fr`    | French           | « guillemets »      |
| `language=de`    | German           | „Anführungszeichen" |

**Usage:**

```latex
\usepackage[article, language=en-US]{moderndoc}
\usepackage[thesis, language=fr]{moderndoc}
```

**Quote commands (language-aware):**

```latex
\q{quoted text}        % Context-sensitive quotes
\qq{nested quote}      % Nested quotes
\enquote{full form}    % Same as \q{}
```

---

## Font Options

Select font family combination.

### Option: `font=plex` (default)

IBM Plex font family (bundled with moderndoc).

| Role     | Font             | Features                        |
| -------- | ---------------- | ------------------------------- |
| Body     | IBM Plex Serif   | Old-style numbers, proportional |
| Headings | IBM Plex Sans    | Lining numbers                  |
| Code     | IBM Plex Mono    | Scaled 0.85                     |
| Math     | STIX Two Math    | Full Unicode math               |
| Japanese | IBM Plex Sans JP | CJK support                     |

### Option: `font=stix`

Traditional Times-like appearance.

| Role     | Font          |
| -------- | ------------- |
| Body     | STIX Two Text |
| Headings | IBM Plex Sans |
| Code     | IBM Plex Mono |
| Math     | STIX Two Math |

### Option: `font=palatino`

TeX Gyre fonts (Palatino/Helvetica clones).

| Role     | Font              |
| -------- | ----------------- |
| Body     | TeX Gyre Pagella  |
| Headings | TeX Gyre Heros    |
| Code     | TeX Gyre Cursor   |
| Math     | Latin Modern Math |

**Usage:**

```latex
\usepackage[article, font=plex]{moderndoc}
\usepackage[thesis, font=stix]{moderndoc}
\usepackage[book, font=palatino]{moderndoc}
```

---

## Feature Toggle Options

Enable or disable specific features.

### `draft=true|false` (default: false)

Draft mode adds visual aids for review.

**Enabled:**

- "DRAFT" watermark on all pages
- Line numbers in margins
- Overfull box markers

```latex
\usepackage[article, draft=true]{moderndoc}
```

### `minted=true|false` (default: true)

Code syntax highlighting via Pygments.

**Requirements when enabled:**

- Python installed
- Pygments package (`pip install Pygments`)
- `--shell-escape` compiler flag

```latex
\usepackage[article, minted=true]{moderndoc}   % Enable (default)
\usepackage[letter, minted=false]{moderndoc}   % Disable for letters
```

### `biblatex=true|false` (default: true)

Bibliography support via biblatex/biber.

```latex
\usepackage[article, biblatex=true]{moderndoc}  % Enable (default)
\usepackage[letter, biblatex=false]{moderndoc}  % Disable for letters
```

### `hyperlinks=true|false` (default: true)

PDF hyperlinks for cross-references, citations, URLs.

```latex
\usepackage[article, hyperlinks=true]{moderndoc}   % Enable (default)
\usepackage[book, hyperlinks=false]{moderndoc}     % Disable
```

### `print=true|false` (default: false)

Print-ready mode removes colored links.

```latex
\usepackage[thesis, print=true]{moderndoc}    % Black links for printing
```

### `makeindex=true|false` (default: false)

Enable index generation.

**When enabled, provides:**

```latex
\idx{term}       % Add to index
\term{concept}   % Format + add to index
\printindex      % Output index
```

```latex
\usepackage[book, makeindex=true]{moderndoc}
```

---

## Color Customization

Moderndoc defines semantic colors that can be redefined.

**Default colors:**

```latex
\definecolor{mdocprimary}{HTML}{2B579A}    % Primary (links, headings)
\definecolor{mdocaccent}{HTML}{C45911}     % Accent (emphasis)
\definecolor{mdocsecondary}{HTML}{3E8E41}  % Secondary (success)
\definecolor{mdocwarning}{HTML}{B8860B}    % Warning boxes
\definecolor{mdocerror}{HTML}{C41E3A}      % Error states
\definecolor{mdocgray}{HTML}{666666}       % Subtle text
```

**Override in preamble:**

```latex
\usepackage[article]{moderndoc}

% Custom brand colors
\definecolor{mdocprimary}{HTML}{1A73E8}    % Google Blue
\definecolor{mdocaccent}{HTML}{EA4335}     % Google Red
```

---

## Complete Options Example

All options combined:

```latex
\documentclass[11pt, a4paper, twoside, openright]{scrbook}

\usepackage[
  % Document type
  thesis,

  % Citations
  citestyle=authoryear,

  % Language
  language=en-US,

  % Typography
  font=plex,

  % Features
  draft=false,
  minted=true,
  biblatex=true,
  hyperlinks=true,
  print=false,
  makeindex=true,
]{moderndoc}

\title{Complete Example}
\author{Author Name}
\addbibresource{references.bib}

\begin{document}
\maketitle
% Document content...
\printbibliography
\printindex
\end{document}
```

---

## Option Combinations by Use Case

### Journal Submission

```latex
\usepackage[article, citestyle=numeric, print=true]{moderndoc}
```

### Conference Paper

```latex
\usepackage[paper, citestyle=numeric, minted=true]{moderndoc}
```

### PhD Thesis

```latex
\usepackage[thesis, citestyle=authoryear, draft=true]{moderndoc}
```

### Technical Book

```latex
\usepackage[book, citestyle=authortitle, makeindex=true]{moderndoc}
```

### Business Report

```latex
\usepackage[report, citestyle=numeric]{moderndoc}
```

### Formal Letter

```latex
\usepackage[letter, minted=false, biblatex=false]{moderndoc}
```
