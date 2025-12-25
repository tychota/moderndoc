# How-to: Code listings (minted)

Minted produces excellent code listings via Pygments.

---

## 1) Enable minted

```tex
\usepackage[doctype=article,minted=true]{moderndoc}
```

Build with:

```bash
latexmk -lualatex --shell-escape main.tex
```

> Security note: shell escape runs external tools. Only compile trusted sources with it enabled.

---

## 2) Inline code

```tex
Run \code{git status} to see changes.
```

---

## 3) Block code

```tex
\begin{codeblock}[python]
def hello():
    print("Hello, world!")
\end{codeblock}
```

---

## 4) Best practices

- Prefer short blocks
- Avoid full-page dumps
- Let minted break long lines (`breaklines=true`)

---

## Common problems

### “You must invoke LaTeX with -shell-escape”

Add `--shell-escape`.

### “pygmentize not found”

Install Pygments:

```bash
python3 -m pip install --user Pygments
```

### Workaround: disable minted

```tex
\usepackage[minted=false]{moderndoc}
```
