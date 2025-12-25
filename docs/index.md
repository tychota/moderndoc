# ModernDoc

![ModernDoc Banner](assets/banner.png)

ModernDoc is a **batteries-included LuaLaTeX toolchain + typographic style** designed to help you produce **beautiful, consistent, archival-friendly PDFs**—fast.

It gives you:

- **Modern typography** out of the box (font pairing, spacing, microtypography)
- **KOMA-Script layouts** (robust headings, sensible page design)
- **Optional features that matter in real documents**:
  - Bibliographies with **biblatex + biber**
  - Code listings with **minted**
  - Tables with **tabularray**
  - Diagrams with **TikZ**
- **Agent-friendly conventions** (easy for AI tools to generate and edit reliably)

---

## Quick start

### 1) Install prerequisites

You need:

- TeX Live **2024+** (LuaLaTeX)
- Python **3** (for minted/Pygments)

Follow: **How-to → Install TeX Live**

### 2) Create your first document

Follow: **Tutorials → First document**

### 3) Build

The recommended build tool is `latexmk`:

```bash
latexmk -lualatex --shell-escape main.tex
```

Or with the repo Makefile (if you use the examples structure):

```bash
make article
```

---

## Choose a starting template

| What you are writing        | Recommended               |
| --------------------------- | ------------------------- |
| Blog post, doc, short paper | Article template          |
| Conference paper            | Two-column paper template |
| Technical report            | Report template           |
| Thesis                      | Thesis template           |
| Book                        | Book template             |
| Formal letter               | Letter template           |

Go to: **Reference → Package options** and **Tutorials → First document**.

---

## How ModernDoc is organized

ModernDoc is intentionally split into two layers:

1. **KOMA-Script class** (you choose this):

   - `scrartcl`, `scrreprt`, `scrbook`, `scrlttr2`

2. **ModernDoc package** (applies styling and utilities):

   - `\usepackage{moderndoc}` (recommended modern approach)

The docs show both patterns.

---

## Next steps

- Want to write with AI? → **Tutorials → Writing with AI**
- Want citations done correctly? → **How-to → Bibliography**
- Want tables/diagrams? → **How-to → Tables / Diagrams**
- Want the reasoning behind typography? → **Explanation → Typography rationale**
