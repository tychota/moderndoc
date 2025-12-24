![Modern LaTeX Templates](./docs/assets/banner.png)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE) [![Fonts: OFL](https://img.shields.io/badge/Fonts-OFL%201.1-orange.svg)](fonts/OFL-LICENSE.txt) [![LuaLaTeX](https://img.shields.io/badge/Engine-LuaLaTeX-green.svg)](https://www.luatex.org/) [![Docs](https://img.shields.io/badge/Docs-Available-green)](https://tychota.github.io/moderndoc/)

**Beautiful, modern LaTeX documents for the 21st century.**

ModernDoc transforms the powerful but complex LaTeX system into an accessible, "batteries-included" toolchain for creating professional articles, reports, books, and theses.

## Why ModernDoc?

- **✨ Modern Aesthetics**: Ships with **IBM Plex**, a typeface designed for the intersection of mankind and machine.
- **🏛️ Archival Quality**: Outputs **PDF/A-4** (ISO 19005-4:2020) by default for long-term preservation.
- **🚀 Zero Config**: Pre-configured settings for bibliography, code highlighting, and typography.
- **🤖 Agent Ready**: Includes `modern-doc.skill` for AI agents to generate documents autonomously.

## Quick Start

1. **Install the class/package**:
    ```bash
    curl -sSL https://raw.githubusercontent.com/tychota/moderndoc/main/scripts/install.sh | bash
    ```

2. **Clone for templates** (optional):
    ```bash
    git clone https://github.com/tychota/moderndoc.git
    cd moderndoc
    ```

3. **Build a template**:
    ```bash
    make article
    ```

4. **Use the class**:
    ```tex
    \documentclass[article]{modern-doc}
    ```

## Documentation

Full documentation is available at our **[documentation site](https://tychota.github.io/moderndoc/)**.

- [Getting Started](https://tychota.github.io/moderndoc/getting-started/)
- [Advanced Usage](https://tychota.github.io/moderndoc/advanced/)

## License

MIT License. Fonts are OFL 1.1.
