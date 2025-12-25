# LuaTeX + KOMA-Script Reference (for moderndoc)

## Why LuaLaTeX

- Native UTF‑8 input (no `inputenc`)
- OpenType fonts via `fontspec`
- Modern PDF features (PDF 2.0, PDF/A via `\DocumentMetadata`)

## Standard build cycle

```bash
latexmk -lualatex --shell-escape main.tex
```

If bibliography is used, latexmk will run biber automatically (if configured / detected). Manual cycle:

```bash
lualatex --shell-escape main.tex
biber main
lualatex --shell-escape main.tex
lualatex --shell-escape main.tex
```

## KOMA classes (which to use)

- `scrartcl` → article / paper
- `scrreprt` → report
- `scrbook` → thesis / book
- `scrlttr2` → letter

**moderndoc rule:** doctype must match class intent. Example:

```tex
\documentclass{scrbook}
\usepackage[doctype=book]{moderndoc}
```

## Typearea knobs (DIV, BCOR)

- `DIV=calc` lets KOMA compute a reasonable type area.
- `BCOR=<len>` adds binding correction (useful for thesis/book).

Example:

```tex
\usepackage[doctype=thesis,bcor=10mm,div=calc]{moderndoc}
```

After changing layout knobs, KOMA uses:

```tex
\recalctypearea
```

## Two-column papers

Use:

```tex
\documentclass[twocolumn]{scrartcl}
\usepackage[doctype=paper]{moderndoc}
```

And set `colsep` if needed:

```tex
\usepackage[doctype=paper,colsep=6mm]{moderndoc}
```

## PDF/A-4

Put metadata at the top of the document:

```tex
\DocumentMetadata{
  pdfversion=2.0,
  pdfstandard=a-4,
  lang=en-US,
}
```

## Fonts

moderndoc supports:

- `font=plex` (default)
- `font=stix`
- `font=palatino`
- `font=libertinus`

Math fonts:

- default for plex is STIX Two Math (reliable)
- optional `mathfont=plex` if IBM Plex Math is present

Japanese:

- default `cjk=haranoaji` (TeX Live)
- `cjk=plexjp` or `cjk=noto` alternatives
