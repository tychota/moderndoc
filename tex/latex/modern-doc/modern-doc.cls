% =============================================================================
% modern-doc.cls - ModernDoc v4 (KOMA wrapper)
% =============================================================================
\NeedsTeXFormat{LaTeX2e}[2022/06/01]
\ProvidesClass{modern-doc}[2025/12/24 v4.0 ModernDoc class (KOMA-Script wrapper)]

% ---- Defaults ----
\newcommand*\mdoc@baseclass{scrartcl}
\newcommand*\mdoc@classdefaults{a4paper}
\newcommand*\mdoc@classuseropts{}
\newcommand*\mdoc@pkgopts{doctype=article}
\def\mdoc@citestyle{citestyle}
\def\mdocfromclass{1}

% ---- Document type selectors ----
\DeclareOption{article}{%
  \renewcommand*\mdoc@baseclass{scrartcl}%
  \renewcommand*\mdoc@classdefaults{a4paper,11pt}%
  \renewcommand*\mdoc@pkgopts{doctype=article}%
}
\DeclareOption{paper}{%
  \renewcommand*\mdoc@baseclass{scrartcl}%
  % Two-column defaults: start with a reasonable DIV (can be overridden)
  \renewcommand*\mdoc@classdefaults{a4paper,10pt,twocolumn}%
  \renewcommand*\mdoc@pkgopts{doctype=paper}%
}
\DeclareOption{report}{%
  \renewcommand*\mdoc@baseclass{scrreprt}%
  \renewcommand*\mdoc@classdefaults{a4paper,11pt}%
  \renewcommand*\mdoc@pkgopts{doctype=report}%
}
\DeclareOption{thesis}{%
  \renewcommand*\mdoc@baseclass{scrreprt}%
  \renewcommand*\mdoc@classdefaults{a4paper,12pt,twoside}%
  \renewcommand*\mdoc@pkgopts{doctype=thesis}%
}
\DeclareOption{book}{%
  \renewcommand*\mdoc@baseclass{scrbook}%
  \renewcommand*\mdoc@classdefaults{a4paper,11pt,twoside,open=right}%
  \renewcommand*\mdoc@pkgopts{doctype=book}%
}
\DeclareOption{letter}{%
  \renewcommand*\mdoc@baseclass{scrlttr2}%
  \renewcommand*\mdoc@classdefaults{a4paper,11pt}%
  \renewcommand*\mdoc@pkgopts{doctype=letter}%
}

% ---- Feature options forwarded to the package (modern-doc.sty) ----
\DeclareOption{draft}{%
  \g@addto@macro\mdoc@classuseropts{,draft}%
  \g@addto@macro\mdoc@pkgopts{,draft}%
}
\DeclareOption{print}{\g@addto@macro\mdoc@pkgopts{,print}}
\DeclareOption{screen}{\g@addto@macro\mdoc@pkgopts{,print=false}}

\DeclareOption{minted}{\g@addto@macro\mdoc@pkgopts{,minted=true}}

\DeclareOption{biblatex}{\g@addto@macro\mdoc@pkgopts{,biblatex=true}}
\DeclareOption{nobiblatex}{\g@addto@macro\mdoc@pkgopts{,biblatex=false}}

\DeclareOption{hyperlinks}{\g@addto@macro\mdoc@pkgopts{,hyperlinks=true}}
\DeclareOption{nohyperlinks}{\g@addto@macro\mdoc@pkgopts{,hyperlinks=false}}

\DeclareOption{makeindex}{\g@addto@macro\mdoc@pkgopts{,makeindex=true}}
\DeclareOption{nomakeindex}{\g@addto@macro\mdoc@pkgopts{,makeindex=false}}

% ---- Anything else is assumed to be a KOMA option ----
\DeclareOption*{%
  \edef\mdoc@opt{\CurrentOption}%
  \expandafter\mdoc@maybe@citestyle\mdoc@opt=\@nil
}

\def\mdoc@maybe@citestyle#1=#2\@nil{%
  \def\mdoc@key{#1}%
  \def\mdoc@val{#2}%
  \ifx\mdoc@key\mdoc@citestyle
    \ifx\mdoc@val\@nil
      \g@addto@macro\mdoc@classuseropts{,\CurrentOption}%
    \else
      \g@addto@macro\mdoc@pkgopts{,citestyle=#2}%
    \fi
  \else
    \g@addto@macro\mdoc@classuseropts{,\CurrentOption}%
  \fi
}

\ProcessOptions\relax

% Pass merged options to the selected KOMA base class, then load it.
\edef\mdoc@allclassopts{\mdoc@classdefaults\mdoc@classuseropts}
\PassOptionsToClass{\mdoc@allclassopts}{\mdoc@baseclass}
\LoadClass{\mdoc@baseclass}

% Load the styling package.
\RequirePackage[\mdoc@pkgopts]{modern-doc}
