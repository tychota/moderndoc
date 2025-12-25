# moderndoc package options

Use:

```tex
\usepackage[<key=value>, ...]{moderndoc}
```

## Core keys

### doctype

One of:

- `article`, `paper`, `report`, `thesis`, `book`, `letter`

### language

- `en-US`, `en-GB`, `fr`, `de`

### font

- `plex` (default)
- `stix`
- `palatino`
- `libertinus`

### mathfont

- `auto` (default)
- `stix`
- `lmodern`
- `libertinus`
- `plex`

### cjk (Japanese strategy)

- `auto` (default → `haranoaji`)
- `haranoaji` (TeX Live)
- `plexjp`
- `noto`

### citestyle

- `auto` (default: numeric for article/paper/report; authoryear for thesis/book; none for letter)
- `numeric`
- `authoryear`
- `authortitle`
- `none` (disables biblatex usage expectation; still can be enabled manually)

### minted / biblatex / hyperlinks / makeindex

Booleans:

- `minted=true|false`
- `biblatex=true|false`
- `hyperlinks=true|false`
- `makeindex=true|false`

### print / draft

- `print=true` hides link styling (good for print)
- `draft=true` enables watermark (and optional drafting aids)

### Layout knobs

- `div=calc|<number>` (KOMA typearea)
- `bcor=<len>` binding correction
- `colsep=<len>` for doctype=paper

### Paragraph style

- `parstyle=indent` (default for article/paper/book/thesis)
- `parstyle=skip` (default for report/letter)
- `parskip=<len>` (only relevant when parstyle=skip)
- `parindent=<len>` (only relevant when parstyle=indent)

### smallcaps behavior

- `smallcaps=auto` (default)
- `smallcaps=real`
- `smallcaps=caps` (letterspaced caps fallback)
- `smallcaps=none`

### bookmarkdepth / linkcolor

- `bookmarkdepth=3`
- `linkcolor=mdocBlue`

### minted styles

- `mintedstyle-screen=friendly`
- `mintedstyle-print=bw`

## Example presets

### Journal-like article (numeric compressed)

```tex
\usepackage[doctype=article,citestyle=numeric,print=true]{moderndoc}
```

### Thesis (authoryear + binding correction)

```tex
\usepackage[doctype=thesis,citestyle=authoryear,bcor=10mm]{moderndoc}
```

### Two-column paper

```tex
\documentclass[twocolumn]{scrartcl}
\usepackage[doctype=paper,colsep=6mm]{moderndoc}
```

### Letter

```tex
\usepackage[doctype=letter,minted=false,biblatex=false]{moderndoc}
```
