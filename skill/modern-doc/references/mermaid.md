# Mermaid to TikZ Conversion

## Overview

TikZ is the preferred method for diagrams in modern-doc documents. It provides consistent styling, vector output, and full integration with document colors and fonts. For complex diagrams or rapid prototyping, pre-render Mermaid to images first, then convert to TikZ.

## Table of Contents
- [TikZ Diagram Patterns](#tikz-diagram-patterns)
- [Conversion Reference](#conversion-reference)
- [Pre-rendering for Prototyping](#pre-rendering-for-prototyping)
- [Specialized Diagram Packages](#specialized-diagram-packages)

---

## TikZ Diagram Patterns

### Setup

Load TikZ with required libraries in preamble:

```latex
\usepackage{tikz}
\usetikzlibrary{
    arrows.meta,          % Modern arrow tips
    positioning,          % Relative positioning
    shapes.geometric,     % Diamond, ellipse, etc.
    shapes.multipart,     % Multi-section nodes (UML)
    calc,                 % Coordinate calculations
    fit,                  % Bounding boxes
    backgrounds,          % Background layers
    decorations.pathreplacing  % Braces, waves
}
```

### Moderndoc Style Integration

Define reusable styles using modern-doc colors:

```latex
\tikzset{
    % Node styles
    mdoc box/.style={
        rectangle,
        draw=mdocprimary,
        fill=mdocprimary!10,
        minimum width=2.5cm,
        minimum height=0.8cm,
        text centered,
        font=\sffamily\small
    },
    mdoc rounded/.style={
        mdoc box,
        rounded corners=3pt
    },
    mdoc decision/.style={
        diamond,
        draw=mdocaccent,
        fill=mdocaccent!10,
        minimum width=2cm,
        aspect=2,
        text centered,
        font=\sffamily\small
    },
    % Arrow styles
    mdoc arrow/.style={
        ->,
        >=Stealth,
        thick,
        mdocprimary
    },
    mdoc dashed/.style={
        mdoc arrow,
        dashed
    }
}
```

### Flowchart

```latex
\begin{figure}[htbp]
\centering
\begin{tikzpicture}[node distance=1.5cm]

\node[mdoc rounded] (start) {Start};
\node[mdoc decision, below=of start] (decide) {Condition?};
\node[mdoc box, below left=of decide] (yes) {Action A};
\node[mdoc box, below right=of decide] (no) {Action B};
\node[mdoc rounded, below=2cm of decide] (end) {End};

\draw[mdoc arrow] (start) -- (decide);
\draw[mdoc arrow] (decide) -- node[left] {Yes} (yes);
\draw[mdoc arrow] (decide) -- node[right] {No} (no);
\draw[mdoc arrow] (yes) |- (end);
\draw[mdoc arrow] (no) |- (end);

\end{tikzpicture}
\caption{Decision flowchart}
\end{figure}
```

### Sequence Diagram

```latex
\begin{figure}[htbp]
\centering
\begin{tikzpicture}
    % Participants
    \node[mdoc box] (client) at (0,0) {Client};
    \node[mdoc box] (server) at (4,0) {Server};
    \node[mdoc box] (db) at (8,0) {Database};

    % Lifelines
    \foreach \n in {client, server, db} {
        \draw[gray!50, thick] (\n.south) -- ++(0,-5);
    }

    % Messages (y positions)
    \def\ya{-1} \def\yb{-2} \def\yc{-3} \def\yd{-4}

    \draw[mdoc arrow] ($(client.south)+(0,\ya)$)
        -- node[above, font=\small] {Request}
        ($(server.south)+(0,\ya)$);
    \draw[mdoc arrow] ($(server.south)+(0,\yb)$)
        -- node[above, font=\small] {Query}
        ($(db.south)+(0,\yb)$);
    \draw[mdoc dashed] ($(db.south)+(0,\yc)$)
        -- node[above, font=\small] {Result}
        ($(server.south)+(0,\yc)$);
    \draw[mdoc dashed] ($(server.south)+(0,\yd)$)
        -- node[above, font=\small] {Response}
        ($(client.south)+(0,\yd)$);
\end{tikzpicture}
\caption{Request-response sequence}
\end{figure}
```

### Class Diagram (UML)

```latex
\begin{figure}[htbp]
\centering
\begin{tikzpicture}[
    uml class/.style={
        rectangle split,
        rectangle split parts=3,
        draw=mdocprimary,
        fill=white,
        minimum width=3.5cm,
        font=\ttfamily\small
    }
]

\node[uml class] (animal) {
    \textbf{Animal}
    \nodepart{second}
    +name: String\\
    +age: Int
    \nodepart{third}
    +eat(): void\\
    +sleep(): void
};

\node[uml class, below left=2cm and -0.5cm of animal] (dog) {
    \textbf{Dog}
    \nodepart{second}
    +breed: String
    \nodepart{third}
    +bark(): void
};

\node[uml class, below right=2cm and -0.5cm of animal] (cat) {
    \textbf{Cat}
    \nodepart{second}
    +indoor: Bool
    \nodepart{third}
    +meow(): void
};

% Inheritance arrows (hollow triangle)
\draw[-{Triangle[open]}, thick] (dog.north) -- ++(0,0.5) -| (animal.south);
\draw[-{Triangle[open]}, thick] (cat.north) -- ++(0,0.5) -| (animal.south);

\end{tikzpicture}
\caption{Class hierarchy}
\end{figure}
```

### State Machine

```latex
\begin{figure}[htbp]
\centering
\begin{tikzpicture}[
    state/.style={
        circle,
        draw=mdocprimary,
        fill=mdocprimary!10,
        minimum size=1.2cm,
        font=\sffamily\small
    },
    initial/.style={state, fill=mdocsecondary!20, draw=mdocsecondary},
    final/.style={state, double, double distance=2pt}
]

\node[initial] (idle) {Idle};
\node[state, right=3cm of idle] (running) {Running};
\node[state, below=2cm of running] (paused) {Paused};
\node[final, left=3cm of paused] (done) {Done};

\draw[mdoc arrow] (idle) -- node[above] {start} (running);
\draw[mdoc arrow] (running) -- node[right] {pause} (paused);
\draw[mdoc arrow] (paused) -- node[below] {stop} (done);
\draw[mdoc arrow] (paused.north west) -- node[left] {resume} (running.south);
\draw[mdoc arrow] (running) to[bend right=30] node[above] {complete} (done);

\end{tikzpicture}
\caption{State machine diagram}
\end{figure}
```

### Entity-Relationship Diagram

```latex
\begin{figure}[htbp]
\centering
\begin{tikzpicture}[
    entity/.style={rectangle, draw=mdocprimary, fill=mdocprimary!10,
                   minimum width=2cm, minimum height=1cm},
    relationship/.style={diamond, draw=mdocaccent, fill=mdocaccent!10,
                        minimum width=1.5cm, aspect=2},
    attribute/.style={ellipse, draw=mdocgray, minimum width=1.5cm}
]

\node[entity] (user) {User};
\node[entity, right=4cm of user] (order) {Order};
\node[relationship, right=1.5cm of user] (places) {places};

\draw[thick] (user) -- (places);
\draw[thick] (places) -- (order);

% Cardinality
\node[above=0.1cm of places, font=\small] {1};
\node[below=0.1cm of places, font=\small] {N};

\end{tikzpicture}
\caption{User-Order relationship}
\end{figure}
```

---

## Conversion Reference

### Mermaid to TikZ Node Shapes

| Mermaid | TikZ Style |
|---------|------------|
| `[Text]` | `rectangle` |
| `(Text)` | `rectangle, rounded corners` |
| `{Text}` | `diamond` |
| `[[Text]]` | `rectangle, double` |
| `[(Text)]` | `cylinder, shape border rotate=90` |
| `((Text))` | `circle` |
| `>Text]` | `signal, signal to=east` |

### Mermaid to TikZ Arrows

| Mermaid | TikZ |
|---------|------|
| `-->` | `->, >=Stealth` |
| `---` | `-` (line only) |
| `-.->` | `->, dashed` |
| `==>` | `->, double` |
| `--o` | `-o` |
| `--x` | `-|` (perpendicular) |
| `<-->` | `<->, >=Stealth` |

### Graph Direction Mapping

| Mermaid | TikZ Positioning |
|---------|------------------|
| `TD` (top-down) | `below=of` |
| `LR` (left-right) | `right=of` |
| `BT` (bottom-up) | `above=of` |
| `RL` (right-left) | `left=of` |

---

## Pre-rendering for Prototyping

Use pre-rendered images to prototype diagrams quickly, then convert to TikZ for final output.

### Mermaid CLI Setup

```bash
npm install -g @mermaid-js/mermaid-cli
```

### Render to Image

```bash
# Create diagram
cat > diagram.mmd << 'EOF'
graph TD
    A[Start] --> B{Decision}
    B -->|Yes| C[Process]
    B -->|No| D[End]
EOF

# Render (PDF best for LaTeX)
mmdc -i diagram.mmd -o figures/diagram.pdf --pdfFit

# High-res PNG alternative
mmdc -i diagram.mmd -o figures/diagram.png -s 3
```

### Include While Prototyping

```latex
% Temporary image inclusion
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.7\textwidth]{figures/diagram.pdf}
  \caption{Workflow (to convert to TikZ)}
\end{figure}
```

### Batch Conversion

```bash
#!/bin/bash
for mmd in diagrams/*.mmd; do
  mmdc -i "$mmd" -o "figures/$(basename "$mmd" .mmd).pdf" --pdfFit
done
```

---

## Specialized Diagram Packages

### pgf-umlsd (Sequence Diagrams)

```latex
\usepackage{pgf-umlsd}

\begin{sequencediagram}
  \newthread{c}{Client}
  \newinst{s}{Server}
  \newinst{d}{Database}

  \begin{call}{c}{request()}{s}{response}
    \begin{call}{s}{query()}{d}{result}
    \end{call}
  \end{call}
\end{sequencediagram}
```

### tikz-uml (Full UML)

```latex
\usepackage{tikz-uml}

\begin{tikzpicture}
  \umlclass{Animal}{
    +name : String
  }{
    +eat() : void
  }

  \umlclass[below left=2cm of Animal]{Dog}{}{
    +bark() : void
  }

  \umlinherit{Dog}{Animal}
\end{tikzpicture}
```

### forest (Tree Diagrams)

```latex
\usepackage{forest}

\begin{forest}
  for tree={
    draw=mdocprimary,
    fill=mdocprimary!10,
    rounded corners,
    minimum width=2cm,
    minimum height=0.6cm,
    s sep=1cm
  }
  [Root
    [Child 1
      [Leaf A]
      [Leaf B]
    ]
    [Child 2
      [Leaf C]
    ]
  ]
\end{forest}
```

### pgfplots (Charts and Graphs)

```latex
\usepackage{pgfplots}
\pgfplotsset{compat=1.18}

\begin{tikzpicture}
\begin{axis}[
    xlabel={X axis},
    ylabel={Y axis},
    grid=major,
    width=0.8\textwidth,
    height=6cm
]
\addplot[mdocprimary, thick, mark=*] coordinates {
    (0,0) (1,2) (2,3) (3,5) (4,4)
};
\end{axis}
\end{tikzpicture}
```
