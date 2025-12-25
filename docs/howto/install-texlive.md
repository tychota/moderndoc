# How-to: Install TeX Live (LuaLaTeX)

ModernDoc requires:

- TeX Live **2024+**
- **LuaLaTeX** (`lualatex`)
- recommended: `latexmk`, `biber`

---

## 1) Verify what you have

```bash
tlmgr --version
lualatex --version
latexmk --version
biber --version
```

If any command is missing, install TeX Live properly (below).

---

## 2) macOS

### Option A: MacTeX (full)

- Best if you want everything included.
- Large download.

After install:

```bash
sudo tlmgr update --self
```

### Option B: BasicTeX (small)

Install BasicTeX, then add what you need:

```bash
sudo tlmgr update --self
sudo tlmgr install collection-luatex latexmk biber
```

---

## 3) Linux (recommended approach)

### Best practice: TeX Live upstream installer

Distro packages are often older. For ModernDoc, TeX Live 2024+ matters.

If you use distro packages anyway, ensure they provide:

- lualatex
- biber
- latexmk
- modern packages (fontspec, unicode-math, etc.)

---

## 4) Windows

Install TeX Live (or a TeX distribution that includes LuaLaTeX and biber). Then verify commands work in PowerShell.

---

## 5) Install ModernDoc package files

### If you ship `moderndoc.sty` / `modern-doc.sty`

Install into your local TEXMF:

```bash
TEXMFHOME="$(kpsewhich -var-value=TEXMFHOME)"
mkdir -p "$TEXMFHOME/tex/latex/moderndoc"
cp moderndoc.sty "$TEXMFHOME/tex/latex/moderndoc/"
mktexlsr "$TEXMFHOME"
kpsewhich moderndoc.sty
```

If you’re using `modern-doc.sty`, use that path instead.

---

## 6) Minted prerequisites (optional but common)

Minted requires shell escape:

```bash
latexmk -lualatex --shell-escape main.tex
```

And a working Python environment.

Check:

```bash
python3 --version
pygmentize -V || true
```

If pygmentize is missing:

```bash
python3 -m pip install --user Pygments
```

---

## 7) Final verification

Run:

```bash
cat > test.tex <<'EOF'
\documentclass{scrartcl}
\usepackage[doctype=article]{moderndoc}
\begin{document}
Hello ModernDoc.
\end{document}
EOF

latexmk -lualatex --shell-escape test.tex
```

If this builds, you’re ready.
