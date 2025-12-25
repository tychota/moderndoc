# Install & Troubleshooting

## Quick doctor checklist

Run these and paste output when debugging:

```bash
lualatex --version
latexmk --version
biber --version
kpsewhich moderndoc.sty
```

If minted is enabled, also:

```bash
latexminted --version || true
pygmentize -V || true
```

## Common install issues

### TeX Live missing

**Symptom:** `lualatex: command not found`

Install TeX Live 2024+ (or equivalent distribution). Then verify `tlmgr` and `lualatex` exist.

### moderndoc not found

**Symptom:** `File 'moderndoc.sty' not found`

Check:

```bash
kpsewhich -var-value=TEXMFHOME
kpsewhich moderndoc.sty
```

If not found, install to: `$TEXMFHOME/tex/latex/moderndoc/moderndoc.sty` Then run:

```bash
mktexlsr "$(kpsewhich -var-value=TEXMFHOME)"
```

## Minted issues

### Missing shell escape

**Symptom:** minted complains about shell escape.

Fix:

```bash
latexmk -lualatex --shell-escape main.tex
```

### Missing pygmentize / helper

Fix options:

1. install Pygments:

```bash
python3 -m pip install --user Pygments
```

2. disable minted:

```tex
\usepackage[minted=false]{moderndoc}
```

## Bibliography issues

### Biber missing

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

## Font issues (fontspec)

### Font cannot be found

Options:

- install the TeX Live font package (preferred)
- install system fonts
- switch font option: `font=libertinus` or `font=stix`

Japanese fonts:

- default `cjk=haranoaji` expects HaranoAji fonts (TeX Live)
- fallback `cjk=noto` uses Noto fonts if installed

## Debug workflow (best practice)

1. Clean:

```bash
latexmk -C
rm -rf _minted-*
```

2. Rebuild with file/line errors:

```bash
latexmk -lualatex --shell-escape -interaction=nonstopmode -file-line-error main.tex
```

3. Read the first error in `build/main.log`.
