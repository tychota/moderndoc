# Code listings (minted)

## When to use minted

Use minted when code readability matters. It produces better output than most alternatives.

## Requirements

- Compile with **shell escape**:

```bash
latexmk -lualatex --shell-escape main.tex
```

- TeX Live minted v3 may bundle its helper; otherwise you may need:

  - `pygmentize -V` (Pygments) or the minted helper binary.

## Patterns (moderndoc)

Inline:

```tex
Use \code{git status} to check changes.
```

Block:

```tex
\begin{codeblock}[python]
def hello():
    print("Hello")
\end{codeblock}
```

## Common fixes

### “You must invoke LaTeX with -shell-escape”

Add `--shell-escape` to lualatex/latexmk.

### “pygmentize not found” / minted helper missing

1. Try installing Pygments:

```bash
python3 -m pip install --user Pygments
```

2. Or disable minted:

```tex
\usepackage[minted=false]{moderndoc}
```

## Best practices

- Prefer short blocks; avoid full-page dumps.
- Use `autogobble=true` so copy-pasted code indents cleanly.
- For long lines: keep `breaklines=true` enabled.
