# How-to: Tables (tabularray)

ModernDoc uses **tabularray** because it’s more expressive and easier to style than raw `tabular`.

---

## 1) A publication-quality table

```tex
\begin{table}[htbp]
\centering
\begin{mdtable}[caption={Readability scores},label={tab:readability}]{colspec={l l r}}
Font Family & Screen & Score \\
IBM Plex    & 4K     & 9.8   \\
IBM Plex    & Mobile & 9.2   \\
Standard    & 4K     & 8.5   \\
\end{mdtable}
\end{table}
```

---

## 2) A dense comparison table

Use grid lines only when it helps scanning.

```tex
\begin{table}[htbp]
\centering
\begin{gridtable}[caption={Feature matrix},label={tab:features}]{colspec={l c c}}
Feature & Basic & Pro \\
PDF/A-4  & ✓     & ✓   \\
Minted   & ✓     & ✓   \\
Support  & —     & ✓   \\
\end{gridtable}
\end{table}
```

---

## 3) Numeric tables

Use tabular/lining figures when column alignment matters:

```tex
\begin{table}[htbp]
\centering
\begin{numtable}[caption={Quarterly revenue},label={tab:revenue}]{colspec={l r r}}
Quarter & Revenue & Growth \\
Q1      & 120000  &  0.05  \\
Q2      & 135000  &  0.12  \\
Q3      & 132000  & -0.02  \\
\end{numtable}
\end{table}
```

---

## Best practices

- Avoid vertical rules unless absolutely necessary
- Put units in headers, not cells
- Keep headers short and consistent
