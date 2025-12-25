# How-to: Bibliography (biblatex + biber)

ModernDoc uses **biblatex** with **biber**, which is the modern, flexible approach.

---

## 1) Enable biblatex

In your preamble:

```tex
\usepackage[doctype=article,biblatex=true,citestyle=numeric]{moderndoc}
\addbibresource{references.bib}
```

---

## 2) Cite in text

```tex
\textcite{bringhurst2004elements} argues typography exists to honor content.
Parenthetical: \parencite{bringhurst2004elements}.
```

At the end:

```tex
\printbibliography
```

---

## 3) Build

```bash
latexmk -lualatex --shell-escape main.tex
```

If doing it manually:

```bash
lualatex --shell-escape main.tex
biber main
lualatex --shell-escape main.tex
lualatex --shell-escape main.tex
```

---

## 4) Recommended citation styles

### Numeric (clean + compact)

Recommended for papers/reports:

- `numeric-comp` (compress ranges like [1–3])

### Author-year (theses/books)

Recommended for long-form:

- `authoryear-comp`

---

## 5) Don’t hallucinate bibliography data (AI-safe rule)

If using AI to generate `.bib`, always provide at least one of:

- DOI
- arXiv ID
- ISBN
- publisher URL

Then verify the metadata before you ship.

---

## Common problems

### Citation undefined

- check key matches `.bib`
- run biber and compile twice

### Biber not found

```bash
tlmgr install biber
```

### Version mismatch

```bash
tlmgr update --self
tlmgr update biblatex biber
latexmk -C
latexmk -lualatex --shell-escape main.tex
```
