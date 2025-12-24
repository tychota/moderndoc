# LuaTeX and KOMA-Script Reference

## Table of Contents
- [LuaTeX Fundamentals](#luatex-fundamentals)
- [KOMA-Script Classes](#koma-script-classes)
- [Font Configuration](#font-configuration)
- [Spacing and Layout](#spacing-and-layout)
- [Headers and Footers](#headers-and-footers)
- [Paragraph and Line Control](#paragraph-and-line-control)
- [Essential Packages](#essential-packages)

---

## LuaTeX Fundamentals

### Why LuaTeX?

LuaTeX extends TeX with:
- Native Unicode support (UTF-8 input)
- OpenType font loading via fontspec
- Lua scripting for advanced manipulation
- DirectWrite font rendering (better quality)
- Modern PDF features (PDF 2.0, PDF/A-4)

### Compilation

```bash
# Basic
lualatex document.tex

# With shell-escape (required for minted)
lualatex --shell-escape document.tex

# Full compilation cycle
lualatex --shell-escape document.tex
biber document
lualatex --shell-escape document.tex
lualatex --shell-escape document.tex
```

### Unicode Input

```latex
% Direct Unicode in source (no inputenc needed)
\documentclass{scrartcl}
\usepackage{fontspec}

\begin{document}
Français: é, è, ê, ë, à, ç
Deutsch: ä, ö, ü, ß
日本語: 漢字、ひらがな、カタカナ
Greek: α, β, γ, δ, ε
Math: ∑, ∫, ∞, ≠, ≤, ≥
\end{document}
```

### Lua Scripting

```latex
% Inline Lua
\directlua{
  local sum = 0
  for i = 1, 10 do sum = sum + i end
  tex.print(sum)
}

% Lua function in document
\newcommand{\factorial}[1]{%
  \directlua{
    local function fact(n)
      if n <= 1 then return 1
      else return n * fact(n-1)
      end
    end
    tex.print(fact(#1))
  }%
}

\factorial{5}  % Outputs: 120
```

---

## KOMA-Script Classes

### Class Selection

| Class | Base | Use Case |
|-------|------|----------|
| `scrartcl` | article | Short documents, no chapters |
| `scrreprt` | report | Medium documents with chapters |
| `scrbook` | book | Long documents, two-sided |
| `scrlttr2` | letter | Formal correspondence |

### Class Options

```latex
\documentclass[
    11pt,              % Font size: 10pt, 11pt, 12pt
    a4paper,           % Paper: a4paper, letterpaper, a5paper
    twoside,           % Two-sided printing
    openright,         % Chapters start on right pages
    BCOR=10mm,         % Binding correction
    DIV=12,            % Page division factor (higher = larger text area)
    headings=normal,   % Heading size: small, normal, big
    numbers=noenddot,  % No dot after section numbers
    bibliography=totoc,% Add bibliography to TOC
    listof=totoc,      % Add lists to TOC
    index=totoc        % Add index to TOC
]{scrbook}
```

### DIV and BCOR

```latex
% DIV controls text area calculation
% Higher DIV = larger text area, smaller margins
\documentclass[DIV=10]{scrartcl}  % Wider margins
\documentclass[DIV=14]{scrartcl}  % Narrower margins

% BCOR adds binding correction to inner margin
\documentclass[BCOR=12mm, twoside]{scrbook}

% Recalculate after font changes
\recalctypearea
```

---

## Font Configuration

### fontspec Basics

```latex
\usepackage{fontspec}

% Main fonts
\setmainfont{IBM Plex Serif}[
    Path = fonts/Serif/,
    Extension = .otf,
    UprightFont = *-Regular,
    ItalicFont = *-Italic,
    BoldFont = *-Bold,
    BoldItalicFont = *-BoldItalic,
    Numbers = OldStyle,        % Old-style figures in text
    Ligatures = TeX            % Enable TeX ligatures
]

\setsansfont{IBM Plex Sans}[
    Path = fonts/Sans/,
    Extension = .otf,
    UprightFont = *-Regular,
    ItalicFont = *-Italic,
    BoldFont = *-Bold,
    BoldItalicFont = *-BoldItalic,
    Numbers = Lining           % Lining figures for headings
]

\setmonofont{IBM Plex Mono}[
    Path = fonts/Mono/,
    Extension = .otf,
    UprightFont = *-Regular,
    ItalicFont = *-Italic,
    BoldFont = *-Bold,
    BoldItalicFont = *-BoldItalic,
    Scale = 0.85               % Scale to match x-height
]
```

### Custom Font Families

```latex
% Define additional font families
\newfontfamily\headingfont{IBM Plex Sans}[
    Path = fonts/Sans/,
    Extension = .otf,
    UprightFont = *-Bold
]

\newfontfamily\quotefont{IBM Plex Serif}[
    Path = fonts/Serif/,
    Extension = .otf,
    UprightFont = *-Italic
]

% Usage
{\headingfont This is a heading}
{\quotefont This is a quote}
```

### Math Fonts

```latex
\usepackage{unicode-math}

\setmathfont{STIX Two Math}[
    Path = fonts/Math/,
    Extension = .otf
]

% Alternative: Latin Modern Math (bundled with TeX Live)
\setmathfont{Latin Modern Math}
```

### Japanese Support

```latex
\usepackage{luatexja}
\usepackage{luatexja-fontspec}

\setmainjfont{IBM Plex Sans JP}[
    Path = fonts/SansJP/,
    Extension = .otf,
    UprightFont = *-Regular,
    BoldFont = *-Bold,
    Scale = 0.95
]

% Fallback: Noto Sans JP
\setmainjfont{Noto Sans JP}
```

---

## Spacing and Layout

### Line Spacing

```latex
\usepackage{setspace}

% Global settings
\setstretch{1.08}        % Moderndoc article default
\onehalfspacing          % 1.5 line spacing
\doublespacing           % Double spacing

% Local override
\begin{singlespace}
  Single-spaced content
\end{singlespace}

\begin{spacing}{1.25}
  Custom spacing
\end{spacing}
```

### Paragraph Spacing

```latex
% KOMA-Script paragraph options
\KOMAoptions{
    parskip=half,        % Half line skip between paragraphs
    parskip=full         % Full line skip between paragraphs
}

% Or with manual settings
\setlength{\parindent}{0pt}      % No paragraph indent
\setlength{\parskip}{0.5\baselineskip}  % Space between paragraphs
```

### Microtype Enhancement

```latex
\usepackage[
    protrusion=true,     % Character protrusion into margins
    expansion=true,      % Font expansion for better justification
    tracking=true,       % Letter spacing adjustments
    final                % Enable in final documents
]{microtype}

% Enable protrusion for math punctuation
\UseMicrotypeSet[protrusion]{basicmath}

% Bringhurst-compliant settings
\microtypesetup{
    factor=950           % 95% protrusion (subtle effect)
}

% Small caps tracking (5%)
\SetTracking{encoding=*, shape=sc}{50}
```

> **LuaLaTeX Limitation**: The `kerning` and `spacing` (interword) features are **not available** in LuaLaTeX—they only work with pdfTeX. Use fontspec's `Kerning=On` instead.

### Page Geometry

```latex
\usepackage{geometry}

% Article margins
\geometry{
    a4paper,
    top=25mm,
    bottom=25mm,
    left=25mm,
    right=25mm
}

% Thesis with binding
\geometry{
    a4paper,
    top=25mm,
    bottom=30mm,
    inner=40mm,    % Larger for binding
    outer=25mm
}

% Show layout (debugging)
\usepackage{layout}
\layout  % In document body
```

---

## Headers and Footers

### scrlayer-scrpage

```latex
\usepackage{scrlayer-scrpage}

% Clear defaults
\clearpairofpagestyles

% Header configuration
\ihead{Left header}    % Inner header
\chead{Center header}  % Center header
\ohead{Right header}   % Outer header

% Footer configuration
\ifoot{Left footer}
\cfoot{\pagemark}      % Page number
\ofoot{Right footer}

% Activate
\pagestyle{scrheadings}
```

### Dynamic Headers

```latex
% Auto-updating marks
\automark[section]{chapter}  % Chapter in header, section in footer

% With formatting
\setkomafont{pageheadfoot}{\small\normalfont}
\setkomafont{pagenumber}{\normalfont}

% Conditional headers
\ihead{\ifthispageodd{\rightmark}{\leftmark}}
\ohead{\ifthispageodd{\leftmark}{\rightmark}}
```

### Custom Page Styles

```latex
% Define new page style
\newpairofpagestyles{thesis}{
    \clearpairofpagestyles
    \ihead{\headmark}
    \ohead{\pagemark}
    \ifoot{}
    \ofoot{}
}

% Chapter opening style
\newpairofpagestyles{chapteropening}{
    \clearpairofpagestyles
    \cfoot{\pagemark}
}

% Apply
\pagestyle{thesis}
\renewcommand*{\chapterpagestyle}{chapteropening}
```

---

## Paragraph and Line Control

### Widow and Orphan Control

```latex
% Prevent single lines at page breaks
\clubpenalty=10000       % No orphans (first line alone)
\widowpenalty=10000      % No widows (last line alone)
\displaywidowpenalty=10000

% Page break penalties
\brokenpenalty=100       % Discourage break after hyphenated line
\predisplaypenalty=10000 % Discourage break before display math
\postdisplaypenalty=0    % Allow break after display math

% Hyphenation control
\doublehyphendemerits=10000  % Discourage consecutive hyphenated lines
\finalhyphendemerits=5000    % Discourage hyphen on second-to-last line
```

### Hyphenation

```latex
% Language-specific patterns
\usepackage{polyglossia}
\setmainlanguage{english}
\setotherlanguage{french}

% Custom hyphenation
\hyphenation{mod-ern-doc}
\hyphenation{Lua-La-TeX}

% Disable hyphenation locally
\begin{hyphenrules}{nohyphenation}
  No hyphenation here
\end{hyphenrules}

% Suppress hyphenation for specific word
\mbox{unhyphenatable}
```

### Line Breaking

```latex
% Flexible glue for justified text
\tolerance=200           % How much badness allowed (default 200)
\emergencystretch=3em    % Extra stretch when needed

% Ragged right (no justification)
\raggedright

% Better ragged right
\usepackage{ragged2e}
\RaggedRight
```

---

## Essential Packages

### Typography

| Package | Purpose | Example |
|---------|---------|---------|
| `fontspec` | OpenType fonts | `\setmainfont{...}` |
| `microtype` | Micro-typography | Auto protrusion |
| `setspace` | Line spacing | `\setstretch{1.08}` |
| `lettrine` | Drop caps | `\lettrine{T}{his}` |
| `csquotes` | Smart quotes | `\enquote{text}` |

```latex
% csquotes setup
\usepackage[autostyle=true]{csquotes}
\MakeOuterQuote{"}  % "text" becomes proper quotes
```

### Structure

| Package | Purpose | Example |
|---------|---------|---------|
| `scrlayer-scrpage` | Headers/footers | See above |
| `tocbasic` | TOC control | Part of KOMA |
| `appendix` | Appendix handling | `\appendix` |
| `imakeidx` | Index generation | `\makeindex` |

```latex
% Index setup
\usepackage{imakeidx}
\makeindex[columns=2, title=Index]

% Usage
\index{term}
\index{term!subterm}
\index{term@\textbf{term}}

% Print index
\printindex
```

### Content

| Package | Purpose | Example |
|---------|---------|---------|
| `graphicx` | Images | `\includegraphics` |
| `tabularray` | Modern tables | `\begin{tblr}` |
| `caption` | Caption styling | `\captionsetup` |
| `subcaption` | Subfigures | `\subcaptionbox` |
| `float` | Float control | `[H]` placement |

```latex
% Caption setup
\usepackage{caption}
\captionsetup{
    font=small,
    labelfont=bf,
    format=hang,
    margin=1cm
}

% Subfigures
\usepackage{subcaption}
\begin{figure}
  \begin{subfigure}{0.48\textwidth}
    \includegraphics{fig-a}
    \caption{First}
  \end{subfigure}
  \hfill
  \begin{subfigure}{0.48\textwidth}
    \includegraphics{fig-b}
    \caption{Second}
  \end{subfigure}
  \caption{Both figures}
\end{figure}
```

### References

| Package | Purpose | Example |
|---------|---------|---------|
| `biblatex` | Bibliography | `\printbibliography` |
| `hyperref` | PDF links | Auto cross-refs |
| `cleveref` | Smart refs | `\cref{fig:x}` |
| `bookmark` | PDF bookmarks | Auto from TOC |

```latex
% cleveref setup
\usepackage{cleveref}
\crefname{figure}{Fig.}{Figs.}
\crefname{table}{Tab.}{Tabs.}
\crefname{equation}{Eq.}{Eqs.}

% Usage
\cref{fig:diagram}           % Fig. 1
\Cref{fig:diagram}           % Figure 1
\crefrange{fig:a}{fig:c}     % Figs. 1-3
\cref{fig:a,fig:b,tab:x}     % Fig. 1, 2 and Tab. 1
```

### Math

| Package | Purpose | Example |
|---------|---------|---------|
| `unicode-math` | Unicode math | Greek, symbols |
| `mathtools` | Enhanced math | `\coloneqq` |
| `amsthm` | Theorem envs | `\newtheorem` |
| `siunitx` | Units | `\SI{10}{\meter}` |

```latex
% Theorem environments
\usepackage{amsthm}
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}[theorem]{Lemma}

\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}

\theoremstyle{remark}
\newtheorem*{remark}{Remark}
```

### Code

| Package | Purpose | Example |
|---------|---------|---------|
| `minted` | Syntax highlight | `\begin{minted}` |
| `listings` | Code listings | `\begin{lstlisting}` |
| `algorithm2e` | Pseudocode | `\begin{algorithm}` |

```latex
% minted setup (requires Pygments)
\usepackage{minted}
\setminted{
    fontsize=\small,
    breaklines=true,
    frame=lines,
    framesep=2mm,
    baselinestretch=1.1
}

% Custom style
\usemintedstyle{friendly}
```

### Graphics

| Package | Purpose | Example |
|---------|---------|---------|
| `tikz` | Vector graphics | `\begin{tikzpicture}` |
| `pgfplots` | Plots/charts | `\begin{axis}` |
| `forest` | Trees | `\begin{forest}` |
| `circuitikz` | Circuits | Electrical diagrams |

```latex
% Common TikZ libraries
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
