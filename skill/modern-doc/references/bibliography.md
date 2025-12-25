# Bibliography (biblatex + biber)

## Recommended defaults (matches moderndoc)

- **article / paper / report**: `numeric-comp` + `sorting=none`
- **thesis / book**: `authoryear-comp` + `sorting=nyt`
- **letter**: bibliography usually off

These choices produce clean citations and good-looking compressed numeric ranges.

## Minimal setup

### In the preamble

```tex
\usepackage[doctype=article, biblatex=true, citestyle=numeric]{moderndoc}
\addbibresource{references.bib}
```

### In the document

```tex
Cite like this: \textcite{bringhurst2004elements}.
Or parenthetical: \parencite{bringhurst2004elements}.

\printbibliography
```

## When adding new references (agent workflow)

1. Ask for one of: DOI / arXiv ID / ISBN / URL / exact title
2. Verify metadata via web search:

   - correct author list
   - correct year
   - DOI if exists

3. Create a bib entry and keep it consistent with the chosen style.
4. Run:

```bash
lualatex --shell-escape main.tex
biber main
lualatex --shell-escape main.tex
lualatex --shell-escape main.tex
```

## Common problems

### “Biber not found”

```bash
tlmgr install biber
```

### “control file version mismatch”

Update both:

```bash
tlmgr update --self
tlmgr update biblatex biber
```

Then clean and rebuild:

```bash
latexmk -C
latexmk -lualatex --shell-escape main.tex
```

### “Citation undefined”

- check key matches `.bib`
- run biber, then compile twice

## Quality tips

- Prefer DOI entries when available.
- For arXiv: include `eprint`, `eprinttype=arxiv`, and the arXiv ID.
- Keep `maxnames` small in citations (2–3), allow many in bibliography (`maxbibnames=99`).
