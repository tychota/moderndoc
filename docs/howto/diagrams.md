# How-to: Diagrams (TikZ)

TikZ gives you:

- vector output
- consistent fonts/colors
- stable PDF/A pipelines

ModernDoc does not load TikZ automatically (keeps builds faster). Add it when needed.

---

## 1) Enable TikZ

```tex
\usepackage{tikz}
\usetikzlibrary{arrows.meta,positioning,shapes.geometric,calc,fit,backgrounds}
```

---

## 2) Recommended house styles

```tex
\tikzset{
  mdoc box/.style={
    rectangle,
    draw=mdocBlue,
    fill=mdocBlue!10,
    minimum width=2.8cm,
    minimum height=0.9cm,
    text centered,
    font=\sffamily\small
  },
  mdoc rounded/.style={mdoc box, rounded corners=3pt},
  mdoc decision/.style={
    diamond,
    draw=mdocOrange,
    fill=mdocOrange!10,
    minimum width=2.2cm,
    aspect=2,
    text centered,
    font=\sffamily\small
  },
  mdoc arrow/.style={->,>=Stealth,thick,draw=mdocBlue}
}
```

---

## 3) Flowchart example

```tex
\begin{figure}[htbp]
\centering
\begin{tikzpicture}[node distance=1.4cm]
\node[mdoc rounded] (start) {Start};
\node[mdoc decision, below=of start] (cond) {Condition?};
\node[mdoc box, below left=of cond] (yes) {Action A};
\node[mdoc box, below right=of cond] (no) {Action B};
\node[mdoc rounded, below=2cm of cond] (end) {End};

\draw[mdoc arrow] (start) -- (cond);
\draw[mdoc arrow] (cond) -- node[left,font=\small] {Yes} (yes);
\draw[mdoc arrow] (cond) -- node[right,font=\small] {No} (no);
\draw[mdoc arrow] (yes) |- (end);
\draw[mdoc arrow] (no) |- (end);
\end{tikzpicture}
\caption{Decision flow}
\end{figure}
```

---

## Mermaid → TikZ

If you prototype in Mermaid first, see: **Reference → Mermaid conversion** (if you add that page) or your internal skill reference.
