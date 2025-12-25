# Troubleshooting

When something breaks, collect these first:

```bash
lualatex --version
latexmk --version
biber --version
kpsewhich moderndoc.sty
```

If minted is enabled:

```bash
pygmentize -V || true
```

---

## 1) “File `X.sty` not found”

Install missing packages:

```bash
tlmgr install X
```

If you’re missing ModernDoc itself:

- confirm it is installed under `TEXMFHOME`
- run `mktexlsr`

---

## 2) “fontspec error: cannot-use-pdftex”

You compiled with pdfLaTeX.

Use LuaLaTeX:

```bash
latexmk -lualatex --shell-escape main.tex
```

---

## 3) Minted errors

### Shell escape missing

```bash
latexmk -lualatex --shell-escape main.tex
```

### Pygments missing

```bash
python3 -m pip install --user Pygments
```

### Disable minted

```tex
\usepackage[minted=false]{moderndoc}
```

---

## 4) Bibliography not appearing

Checklist:

- `\addbibresource{references.bib}` exists
- `\printbibliography` exists
- biber runs successfully

Manual cycle:

```bash
lualatex --shell-escape main.tex
biber main
lualatex --shell-escape main.tex
lualatex --shell-escape main.tex
```

---

## 5) Debugging technique that works

Rebuild with file/line error reporting:

```bash
latexmk -lualatex --shell-escape -interaction=nonstopmode -file-line-error main.tex
```

Then open `main.log` and fix the **first real error**. Everything after that is usually cascading.
