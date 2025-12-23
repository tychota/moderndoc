# Advanced Considerations

ModernDoc is not just a template; it is a carefully curated set of typographic choices designed to convey professionalism and readability.

## Typography & Design

### Why IBM Plex?

The default typeface for ModernDoc is **IBM Plex**.

> "IBM Plex is designed to capture the relationship between mankind and machine." — [IBM Design](https://www.ibm.com/plex/)

We chose IBM Plex for several reasons:

1.  **Versatility**: It includes a Serif (body), Sans (headings), Mono (code), and Sans JP (Japanese) that are perfectly balanced with each other.
2.  **Legibility**: Its "grotesque" roots and open counters make it highly readable on screens and in print.
3.  **Modernity**: It avoids the overused "Times New Roman" or "Arial" look, giving your documents a distinctive, contemporary character.
4.  **Open Source**: It is licensed under the SIL Open Font License (OFL), ensuring it remains free and accessible.

### Font Pairings

While Plex is the default, ModernDoc supports other "educated" pairings based on typographic research:

| Option (`font=`) | Pairing Name | Body Font | Heading Font | Vibe |
| :-- | :-- | :-- | :-- | :-- |
| `plex` (Default) | **Industrial Humanism** | IBM Plex Serif | IBM Plex Sans | Precise, engineered, warm. |
| `stix` | **Scientific Classic** | STIX Two Text | IBM Plex Sans | Traditional academic, math-heavy. |
| `palatino` | **Humanist Elegant** | TeX Gyre Pagella | TeX Gyre Heros | Classic, organic, approachable. |

### Microtypography

ModernDoc v3.0 enables professional `microtype` features optimized for LuaLaTeX:

- **Protrusion**: Punctuation hangs slightly into the margins (95% factor for subtlety). Includes the `basicmath` set for improved margins in technical documents.
- **Expansion**: Bringhurst-compliant glyph scaling (maximum 2% stretch/shrink) for better justification.
- **Tracking**: 5% letter-spacing for small caps only. Following the golden rule: *never letterspace lowercase text*.

!!! note "LuaLaTeX Limitation"
    The `kerning` and `spacing` (interword) features of microtype are **not available** in LuaLaTeX—they only work with pdfTeX. ModernDoc uses fontspec's `Kerning=On` instead.

## Typographic Rules

We enforce strict typographic rules based on Bringhurst's *The Elements of Typographic Style*:

### Line Length
- **Optimal**: 45-75 characters per line, with 66 being ideal
- **Implementation**: `textwidth=350pt` for IBM Plex at 11pt (~66 characters)
- **Two-column**: Each column targets ~45 characters

### Paragraph Penalties
- **Widow/Orphan Control**: Maximum penalties (`10000`) prevent single lines at page top/bottom
- **Hyphenation**: `\brokenpenalty=100` discourages page breaks after hyphenated lines
- **Consecutive Hyphens**: `\doublehyphendemerits=10000` strongly discourages multiple hyphenated lines in a row

### Line Spread
Adjusted per document type for optimal reading comfort:

| Profile | Line Spread | Effective Spacing |
|---------|-------------|-------------------|
| Article | 1.08 | ~134% leading |
| Paper | 1.04 | Tighter for two-column |
| Thesis | 1.25 | ~1.5 spacing |
| Book | 1.10 | Book-quality |

### Profile-Dependent Adjustments
- **Thesis/Book**: Stricter hyphenation control (`\brokenpenalty=500`), more flexibility for binding margins
- **Paper**: Higher tolerance for narrow columns (`\tolerance=300`)

## PDF/A-4 Archival Compliance

By default, ModernDoc produces **PDF/A-4** files. This is the latest ISO standard (ISO 19005-4:2020) for long-term preservation.

- **Self-Contained**: All fonts and color profiles are embedded.
- **Metadata**: XMP metadata is automatically generated.
- **Accessibility**: Tagged PDF structure is partially supported (and improving).

## Semantic Markup

ModernDoc encourages "semantic" writing over manual formatting.

Instead of `\textit{word}`, use:

- `\foreign{word}` for foreign terms.
- `\term{word}` for technical terms (automatically indexed).
- `\bookref{Title}` for book titles.
- `\software{Name}` for software names.
- `\acronym{NASA}` for acronyms (rendered in small caps).
- `\caps{Warning}` for letterspaced capitals.

This separates _meaning_ from _presentation_, allowing the style to be updated globally without changing your content.

## Number Utilities

ModernDoc provides utilities for controlling OpenType number styles:

```latex
\liningnums{2024}    % Lining figures (for tables, technical content)
\tabularnums{1,234}  % Tabular figures (for aligned columns)
\textnums{1984}      % Text/oldstyle figures (default in running text)
\properfrac{3}{4}    % OpenType fractions (¾)
```

## Tables

ModernDoc v3.0 uses **booktabs-style** tables by default, following the principle: *"Avoid vertical rules and use a small number of well-weighted horizontal rules."*

Three table environments are provided:

| Environment | Style | Best For |
|-------------|-------|----------|
| `mdtable` | Booktabs (minimal rules) | General use, publication quality |
| `gridtable` | Horizontal grid lines | Comparison tables, dense data |
| `numtable` | Booktabs + tabular figures | Financial data, statistics |
