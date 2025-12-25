![Modern LaTeX Templates](./docs/assets/banner.png)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE) [![Fonts: OFL](https://img.shields.io/badge/Fonts-OFL%201.1-orange.svg)](fonts/OFL-LICENSE.txt) [![LuaLaTeX](https://img.shields.io/badge/Engine-LuaLaTeX-green.svg)](https://www.luatex.org/) [![Docs](https://img.shields.io/badge/Docs-Available-green)](https://tychota.github.io/moderndoc/)

**moderndoc** is a batteries-included LuaLaTeX toolchain + typographic style package that helps you create beautiful, professional PDF documents quickly — even if you don't know LaTeX.

## What You Get

| Feature | Description |
|---------|-------------|
| **KOMA-Script Layouts** | Article, paper, report, thesis, book, letter |
| **Modern Fonts** | IBM Plex (serif, sans, mono) with sane fallbacks |
| **Bibliography** | Pre-configured biblatex + biber |
| **Code Listings** | Syntax highlighting via minted |
| **Tables** | Modern tables with tabularray |
| **Typography** | Optimal line length, leading, microtype, widow/orphan control |

## Quick Start

### 1. Install

```bash
curl -sSL https://raw.githubusercontent.com/tychota/moderndoc/main/scripts/install.sh | bash
```

### 2. Create a Document

```latex
\DocumentMetadata{pdfversion=2.0,pdfstandard=a-4,lang=en-US}

\documentclass[11pt,a4paper]{scrartcl}
\usepackage[doctype=article,font=plex]{moderndoc}

\title{Hello ModernDoc}
\author{You}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
A clean document in minutes.
\begin{keywords}
latex, typography, lua
\end{keywords}
\end{abstract}

\section{Introduction}
Try \acronym{NASA}, \term{microtype}, and a code block:

\begin{codeblock}[python]
print("hello")
\end{codeblock}

\end{document}
```

### 3. Build

```bash
latexmk -lualatex --shell-escape yourfile.tex
```

## Document Types

| Type | KOMA Class | Use Case |
|------|------------|----------|
| `article` | `scrartcl` | Journal articles, short papers |
| `paper` | `scrartcl` + twocolumn | Conference papers |
| `report` | `scrreprt` | Technical reports |
| `thesis` | `scrreprt` + twoside | Master's/PhD theses |
| `book` | `scrbook` | Books, manuals |
| `letter` | `scrlttr2` | Formal correspondence |

## Documentation

Full documentation: **[tychota.github.io/moderndoc](https://tychota.github.io/moderndoc/)**

- [Getting Started](https://tychota.github.io/moderndoc/getting-started/)
- [Template Reference](https://tychota.github.io/moderndoc/templates/)
- [Typography Guide](https://tychota.github.io/moderndoc/typography/)

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Missing packages | `tlmgr install <package>` |
| Minted errors | Compile with `--shell-escape` |
| Bibliography not appearing | Run `biber <jobname>` then compile twice |

## Using with AI Agents

Copy the skill folder to your agent's skills directory:

```
skill/modern-doc/ → ~/.claude/skills/
```

Then prompt:

> "Generate a two-page report using the moderndoc report template, with a numeric-comp bibliography."

## License

MIT License. Fonts are licensed under OFL 1.1.
