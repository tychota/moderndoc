# Reference: Package options

ModernDoc can be used in two ways:

## Recommended (simple): KOMA class + package

```tex
\documentclass{scrartcl}
\usepackage[doctype=article]{moderndoc}
```

---

## Options overview

### Core

| Option | Meaning |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
| `doctype=article | paper | report | thesis | book | letter` | selects layout preset |
| `language=en-US | en-GB | fr | de` | sets language |  |  |
| `font=plex | stix | palatino | libertinus` | font pairing |  |  |
| `minted=true | false` | code highlighting |  |  |  |  |
| `biblatex=true | false` | bibliography support |  |  |  |  |
| `citestyle=numeric | authoryear | authortitle` | bibliography style |  |  |  |
| `hyperlinks=true | false` | PDF links |  |  |  |  |
| `print=true | false` | hide link styling |  |  |  |  |
| `draft=true | false` | draft watermark / aids |  |  |  |  |

### Layout knobs

| Option                      | Meaning                |               |
| --------------------------- | ---------------------- | ------------- |
| `div=calc                   | <n>`                   | KOMA typearea |
| `bcor=<len>`                | binding correction     |               |
| `bookmarkdepth=<n>`         | PDF outline depth      |               |
| `mintedstyle-screen=<name>` | minted theme           |               |
| `mintedstyle-print=<name>`  | minted theme for print |               |

---

## Example: thesis with author-year citations

```tex
\documentclass[12pt,a4paper,twoside,open=right]{scrbook}
\usepackage[
  doctype=thesis,
  bcor=10mm,
  citestyle=authoryear,
  biblatex=true
]{moderndoc}
```
