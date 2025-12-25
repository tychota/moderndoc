# Reference: Build system

ModernDoc supports both:

- direct `latexmk` usage
- Makefile wrappers (optional convenience)

---

## Recommended build command

```bash
latexmk -lualatex --shell-escape main.tex
```

Useful debugging flags:

```bash
latexmk -lualatex --shell-escape -interaction=nonstopmode -file-line-error main.tex
```

---

## Watch mode

```bash
latexmk -lualatex --shell-escape -pvc main.tex
```

---

## Cleaning

```bash
latexmk -C
rm -rf _minted-*
```

---

## latexmkrc (typical)

- set LuaLaTeX as the engine
- enable biber
- set `build/` as output directory
- keep LuaTeX caches in build

---

## Makefile (typical)

A Makefile is helpful if you ship multiple example documents:

- `make article`
- `make thesis`
- `make watch-article`
