# Tables (tabularray)

moderndoc provides three table environments built on **tabularray**:

- `mdtable` — booktabs-style, minimal rules (publication quality)
- `gridtable` — light grid lines (dense comparisons)
- `numtable` — numeric tables with tabular lining figures

## Why tabularray?

- Modern interface, cleaner than raw `tabular`
- Easier styling
- Good integration with booktabs and siunitx-style numeric alignment

## 1) mdtable (default, booktabs look)

```tex
\begin{table}[htbp]
\centering
\begin{mdtable}[
  caption={Readability scores},
  label={tab:readability}
]{colspec={l l r}}
Font Family & Screen & Score \\
IBM Plex    & 4K     & 9.8   \\
IBM Plex    & Mobile & 9.2   \\
Standard    & 4K     & 8.5   \\
\end{mdtable}
\end{table}
```

### Good uses

- academic papers
- reports
- any table where “clean + minimal” is desired

## 2) gridtable (comparison tables)

```tex
\begin{table}[htbp]
\centering
\begin{gridtable}[
  caption={Feature matrix},
  label={tab:features}
]{colspec={l c c c}}
Feature & Basic & Pro & Enterprise \\
PDF/A-4  & ✓     & ✓   & ✓          \\
Minted   & ✓     & ✓   & ✓          \\
Support  & —     & ✓   & ✓          \\
\end{gridtable}
\end{table}
```

### Good uses

- feature comparison
- dense categorical data

## 3) numtable (financial / statistics)

This env forces tabular lining figures for better column alignment.

```tex
\begin{table}[htbp]
\centering
\begin{numtable}[
  caption={Quarterly revenue},
  label={tab:revenue}
]{colspec={l r r}}
Quarter & Revenue & Growth \\
Q1      &  120000 &  0.05  \\
Q2      &  135000 &  0.12  \\
Q3      &  132000 & -0.02  \\
\end{numtable}
\end{table}
```

## Alignment tips

### Align decimals

If you want strict decimal alignment, consider using tabularray’s siunitx support. In a normal `tblr`, you can use `S` columns if siunitx is available.

Example:

```tex
\begin{table}[htbp]
\centering
\begin{tblr}[
  caption={Aligned decimals},
  label={tab:decimals}
]{colspec={l S[table-format=3.2] S[table-format=2.1]}}
Item & {Value} & {Rate} \\
A    & 123.45  &  1.2   \\
B    &   9.80  & 12.0   \\
\end{tblr}
\end{table}
```

## Table best practices

- Avoid vertical rules unless you _need_ them (readability).
- Keep headers short and consistent.
- Put units in headers, not cells (e.g., “Mass (kg)”).
- Don’t overuse bold; reserve for header row or key rows only.
