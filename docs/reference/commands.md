# Reference: Environments & commands

This page lists the user-facing commands that ModernDoc provides (or standardizes).

---

## Semantic markup helpers

Prefer these over manual formatting:

| Command          | Meaning                                        |
| ---------------- | ---------------------------------------------- |
| `\foreign{...}`  | foreign words (italic)                         |
| `\term{...}`     | technical terms (emphasis; optionally indexed) |
| `\acronym{...}`  | acronyms (small caps if available)             |
| `\software{...}` | software names                                 |
| `\bookref{...}`  | book titles                                    |
| `\email{...}`    | email addresses                                |

---

## Quotes

### `paperquote`

```tex
\begin{paperquote}
Quoted text.
\end{paperquote}
```

### `chapterquote`

```tex
\begin{chapterquote}{Author}{Year}
A quote.
\end{chapterquote}
```

---

## Note boxes

### `notebox`

```tex
\begin{notebox}
Important note.
\end{notebox}
```

### `warningbox`

```tex
\begin{warningbox}
A warning.
\end{warningbox}
```

---

## Code

Inline:

```tex
Use \code{curl -sSL ...}.
```

Block:

```tex
\begin{codeblock}[python]
print("hello")
\end{codeblock}
```

---

## Abstract + keywords

Article/paper typically support:

```tex
\begin{abstract}
Text.
\begin{keywords}
k1, k2, k3
\end{keywords}
\end{abstract}
```

Thesis often uses:

```tex
\begin{thesisabstract}
Text.
\end{thesisabstract}
```
