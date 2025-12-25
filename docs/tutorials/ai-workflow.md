# Tutorial: Writing with AI (reliably)

ModernDoc is designed to be “agent-friendly”: predictable structure, stable macros, consistent styling.

This tutorial shows a workflow that avoids the two biggest AI failure modes:

1. broken LaTeX that doesn’t compile
2. invented citations / incorrect bibliography data

---

## 1) Use a structured prompt

When asking an AI tool, specify:

- doctype (article/report/thesis/…)
- language (en-US, en-GB, …)
- whether you need citations / code / tables / diagrams
- the output format you want (single-file vs multi-file)

Example prompt:

> Create a 6–8 page report using ModernDoc, with an executive summary, 3 chapters, and a conclusion.  
> Use biblatex with numeric citations, include 2 tables (tabularray) and 1 TikZ flowchart.  
> Output: multi-file project with `main.tex`, `preamble.tex`, and `content/*.tex`.

---

## 2) Prefer semantic markup over manual styling

Instead of telling the AI “make this italic”, prefer:

- `\foreign{...}` for foreign words
- `\term{...}` for technical terms
- `\software{...}` for software names
- `\acronym{...}` for acronyms

This keeps your writing meaningful and lets style evolve globally.

---

## 3) Make citations verifiable

Bad: “cite a paper about X” (AI may hallucinate).  
Good: provide DOI/arXiv/URL/title.

Workflow:

1. You provide DOI/arXiv/URL/title
2. AI creates a bib entry
3. You compile and verify

If you don’t have metadata, ask AI to:

- propose candidate sources
- then you confirm one (or you provide the URL)

---

## 4) Edit in small diffs

Ask for changes in **patch-sized steps**:

- “rewrite this paragraph”
- “add one figure”
- “fix this compilation error”

Avoid: “rewrite the entire document and improve everything” unless you’re ready to review a large diff.

---

## 5) Compile early, compile often

Most LaTeX errors are easiest to fix close to the change that caused them.

Recommended build command:

```bash
latexmk -lualatex --shell-escape -interaction=nonstopmode -file-line-error main.tex
```

---

## 6) Debugging with logs

If compilation fails, give the AI:

- the **first 40–80 lines around the first real error** in the `.log`

The first error is the root cause. Everything after is usually cascading.

Go to: **Troubleshooting**
