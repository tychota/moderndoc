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

ModernDoc enables `microtype` features by default:

- **Protrusion**: Punctuation hangs slightly into the margins to create visually straight edges.
- **Expansion**: Subtle adjustment of character widths to improve line breaking.
- **Tracking**: Adjusted letter-spacing for small caps.

## Typographic Rules

We enforce several strict typographic rules to ensure publication quality:

- **Widow/Orphan Control**: Penalties are set to maximum (`10000`) to prevent single lines of paragraphs from appearing at the top or bottom of a page.
- **Line Spread**: adjusted per document type (e.g., `1.08` for articles, `1.25` for theses) to ensure optimal reading comfort.
- **Margins**: Based on standard "canons of page construction" to provide breathing room without wasting space.

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

This separates _meaning_ from _presentation_, allowing the style to be updated globally without changing your content.
