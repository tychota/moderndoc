# =============================================================================
# latexmkrc — Configuration for latexmk
# =============================================================================
# Usage:
#   latexmk -r latexmkrc document.tex
#   Or via Makefile: make article
# =============================================================================

# Use LuaLaTeX as the default compiler
$pdf_mode = 4;  # 4 = lualatex
$lualatex = 'lualatex --shell-escape --interaction=nonstopmode %O %S';

# Use biber for bibliography
$bibtex_use = 2;

# Increase max passes for complex documents
$max_repeat = 5;

# =============================================================================
# Output directory handling
# =============================================================================
# Ensure auxiliary files go to outdir but sources are found
$emulate_aux = 1;
$aux_dir = $out_dir;

# =============================================================================
# Minted / Pygments support
# =============================================================================
# Custom dependencies for pythontex
add_cus_dep('pytxcode', 'tex', 0, 'pythontex');
sub pythontex { return system("pythontex", $_[0]); }

# Track minted directories for cleanup
$clean_ext .= ' %R.pytxcode %R.nav %R.snm %R.vrb';
push @generated_exts, 'run.xml';
push @generated_exts, 'synctex.gz';

# =============================================================================
# Glossary support
# =============================================================================
add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
sub makeglo2gls {
    my ($base) = @_;
    my $dir = $aux_dir ? "$aux_dir/" : "";
    system("makeindex -s '${dir}${base}.ist' -t '${dir}${base}.glg' -o '${dir}${base}.gls' '${dir}${base}.glo'");
}

# =============================================================================
# Index support
# =============================================================================
$makeindex = 'makeindex %O -o %D %S';

# =============================================================================
# Cleanup settings
# =============================================================================
$cleanup_mode = 2;
$cleanup_includes_generated = 1;

# Clean minted cache directories
push @generated_exts, '_minted-%R';

# =============================================================================
# Preview settings (uncomment to enable)
# =============================================================================
# $preview_continuous_mode = 1;

# PDF viewer (adjust for your system)
# $pdf_previewer = 'open -a Preview %S';  # macOS
# $pdf_previewer = 'evince %S';           # Linux
# $pdf_previewer = 'start %S';            # Windows
