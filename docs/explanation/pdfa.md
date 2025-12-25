# Explanation: PDF/A & metadata

ModernDoc targets long-lived, shareable PDFs.

---

## PDF/A basics

PDF/A is a family of ISO standards for archival PDFs. Key requirements:

- embed fonts
- avoid external dependencies
- include metadata
- constrain features that break future rendering

ModernDoc aims for **PDF/A-4** where possible.

---

## Document metadata in LaTeX

Use `\DocumentMetadata{...}` at the top:

```tex
\DocumentMetadata{
  pdfversion=2.0,
  pdfstandard=a-4,
  lang=en-US
}
```

---

## Practical tips for PDF/A-friendly output

- Prefer vector images (PDF/SVG→PDF) for diagrams
- Keep raster images in RGB
- Avoid transparency-heavy assets if validation matters
- Keep fonts consistent and embeddable

---

## Validating output (optional)

Use a validator such as veraPDF to check archival compliance. If validation fails, it’s usually due to:

- missing font embedding
- image color profiles / transparency
- metadata issues
