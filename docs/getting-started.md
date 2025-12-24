# Getting Started

This guide will help you set up **ModernDoc** and build your first document.

## Prerequisites

ModernDoc relies on a modern TeX environment. You will need:

1.  **TeX Live 2024** (or later) with `lualatex`.
2.  **Python 3** (for the installation script and Pygments code highlighting).

## Installation

The easiest way to install ModernDoc and all its LaTeX dependencies is via our one-liner install script:

```bash
curl -sSL https://raw.githubusercontent.com/tychota/moderndoc/main/scripts/install.sh | bash
```

This script will:
1.  Check for a working TeX Live installation.
2.  Install required Python packages (`Pygments`).
3.  Automatically download and install missing LaTeX packages via `tlmgr`.
4.  Install the `modern-doc.cls` and `modern-doc.sty` files into your local `TEXMF` directory.

### Using Templates (Optional)

If you want to use our pre-configured templates (highly recommended for new projects), clone the repository:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/tychota/moderndoc.git
    cd moderndoc
    ```

2.  **Verify Installation:**
    Check that `lualatex` can find the style file:
    ```bash
    kpsewhich modern-doc.sty
    ```

## Creating Your First Document

ModernDoc comes with several pre-configured templates in the `templates/` directory.

If you want to start from scratch, use the KOMA wrapper class:

```tex
\documentclass[article]{modern-doc}
```

### 1. Choose a Template

- `article.tex`: For generic articles and documentation.
- `report.tex`: For technical reports with executive summaries.
- `thesis.tex`: For academic dissertations (customizable margins).
- `book.tex`: For writing books.
- `letter.tex`: For formal correspondence.

### 2. Build the Document

You can compile documents using the provided `Makefile` or standard LaTeX tools.

**Using Make (Recommended):**

```bash
make article
# or
make all
```

**Using Latexmk:**

```bash
cd templates
latexmk -lualatex -shell-escape article.tex
```

!!! note "LuaTeX cache"
    LuaTeX font caches are stored in `output/.tex-cache` by default (configurable via `TEXMFCACHE`).

!!! note "Shell Escape"
    ModernDoc uses `minted` when enabled for code highlighting. If you turn on `minted`, you may need the `-shell-escape` flag during compilation.

## Using with AI Agents

ModernDoc is designed to be "agent-friendly". If you are using an AI coding agent:

**Claude Code / Cursor / Windsurf:**

1. Copy `skill/modern-doc/` to your project's `.claude/skills/` directory (or equivalent).
2. The agent will automatically use ModernDoc conventions when working with `.tex` files.
3. Ask the agent to "Generate a report about X using the modern-doc report template."

**Other Agents:**

1. Provide the contents of `skill/modern-doc/SKILL.md` as context.
2. The agent can use the documentation to create valid, compilable LaTeX code.
