# =============================================================================
# latexmkrc — Configuration for latexmk
# =============================================================================
# Usage: latexmk -lualatex document.tex
# =============================================================================

# Use LuaLaTeX as the default compiler
$pdf_mode = 4;  # 4 = lualatex
$lualatex = 'lualatex --shell-escape %O %S';

# Use biber for bibliography
$biber = 'biber %O %S';
$bibtex_use = 2;

# Custom dependencies for minted
add_cus_dep('pytxcode', 'tex', 0, 'pythontex');
sub pythontex { return system("pythontex", $_[0]); }

# Clean minted cache directories
$clean_ext .= ' %R.pytxcode %R.nav %R.snm %R.vrb';
push @generated_exts, 'run.xml';
push @generated_exts, 'synctex.gz';

# Clean minted directories
$cleanup_mode = 2;
$cleanup_includes_generated = 1;

# Add minted output directory to clean list
push @generated_exts, '_minted-%R';

# Increase max passes for complex documents
$max_repeat = 5;

# Preview continuously (uncomment for live preview)
# $preview_continuous_mode = 1;

# PDF viewer (adjust for your system)
# $pdf_previewer = 'evince';           # Linux
# $pdf_previewer = 'open -a Preview';  # macOS
# $pdf_previewer = 'start';            # Windows

# Show output in terminal
$pdflatex = 'pdflatex --shell-escape %O %S';
$xelatex = 'xelatex --shell-escape %O %S';

# Glossary support (if using glossaries package)
add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
sub makeglo2gls {
    system("makeindex -s '$_[0].ist' -t '$_[0].glg' -o '$_[0].gls' '$_[0].glo'");
}

# Index support
$makeindex = 'makeindex %O -o %D %S';
