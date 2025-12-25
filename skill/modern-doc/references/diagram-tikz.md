# Diagrams (TikZ)

moderndoc does **not** load TikZ automatically (keeps builds fast and avoids heavy deps). When you need diagrams, add in your preamble:

```tex
\usepackage{tikz}
\usetikzlibrary{
  arrows.meta,
  positioning,
  shapes.geometric,
  calc,
  fit,
  backgrounds,
  decorations.pathreplacing
}
```

## House styles (recommended)

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
  mdoc rounded/.style={
    mdoc box,
    rounded corners=3pt
  },
  mdoc decision/.style={
    diamond,
    draw=mdocOrange,
    fill=mdocOrange!10,
    minimum width=2.2cm,
    aspect=2,
    text centered,
    font=\sffamily\small
  },
  mdoc arrow/.style={
    ->,
    >=Stealth,
    thick,
    draw=mdocBlue
  },
  mdoc dashed/.style={
    mdoc arrow,
    dashed
  }
}
```

## Flowchart example

```tex
\begin{figure}[htbp]
\centering
\begin{tikzpicture}[node distance=1.4cm]
\node[mdoc rounded] (start) {Start};
\node[mdoc decision, below=of start] (cond) {Condition?};
\node[mdoc box, below left=of cond] (yes) {Action A};
\node[mdoc box, below right=of cond] (no) {Action B};
\node[mdoc rounded, below=2.0cm of cond] (end) {End};

\draw[mdoc arrow] (start) -- (cond);
\draw[mdoc arrow] (cond) -- node[left,font=\small] {Yes} (yes);
\draw[mdoc arrow] (cond) -- node[right,font=\small] {No} (no);
\draw[mdoc arrow] (yes) |- (end);
\draw[mdoc arrow] (no) |- (end);
\end{tikzpicture}
\caption{Decision flow}
\end{figure}
```

## Where to store diagrams

- For small diagrams: inline in the chapter file
- For larger ones: put in `figures/diagrams/*.tikz` and include:

  ```tex
  \input{figures/diagrams/workflow.tikz}
  ```

## When converting Mermaid → TikZ

Use `references/mermaid.md` for:

- shape mapping table
- arrow mapping table
- conversion examples
- “render Mermaid first” workflow
