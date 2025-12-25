# Explanation: Typography rationale

ModernDoc’s typography is opinionated. The goal is simple:

> Make documents that look “professionally typeset” with minimal configuration.

---

## Typeface choices

### IBM Plex pairing

The IBM Plex family is used because it provides a coherent system:

- Serif for reading (body)
- Sans for structure (headings)
- Mono for code
- CJK companion fonts exist

This yields a consistent, modern voice while avoiding the “default LaTeX look”.

---

## Line length and margins

Readable text requires:

- a comfortable line length
- stable paragraph rhythm

ModernDoc relies on KOMA’s typearea calculation (`DIV=calc`) and doc-type presets so users don’t need to tune geometry manually.

For books/theses, `BCOR` is used to compensate for binding.

---

## Paragraph style

ModernDoc aims to avoid common “amateur” patterns:

- Do not use both large `\parskip` and deep indentation at the same time.
- Choose one paragraph style per document:
  - indented paragraphs (classic)
  - spaced paragraphs (modern docs/reports)

---

## Microtypography

Microtype improves perceived polish:

- protrusion (optical margin alignment)
- expansion (better justification)
- tracking for caps/small caps only

These features improve texture without obvious “effects”.

---

## Color

Colors are chosen to be:

- readable
- print-safe (optionally)
- colorblind-friendly palettes preferred

---

## Why KOMA-Script

KOMA provides:

- better heading controls than many legacy article classes
- sensible defaults for European page design
- robust mechanisms (`typearea`, `scrlayer-scrpage`) instead of ad-hoc hacks
