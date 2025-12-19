# =============================================================================
# Makefile for Modern LaTeX Templates
# =============================================================================
# Usage:
#   make article    - Build the article template
#   make paper      - Build the paper template
#   make thesis     - Build the thesis template
#   make book       - Build the book template
#   make all        - Build all templates
#   make clean      - Remove auxiliary files
#   make distclean  - Remove all generated files
# =============================================================================

# LaTeX compiler
LATEX = lualatex
LATEXFLAGS = --shell-escape --interaction=nonstopmode

# BibTeX processor
BIBER = biber

# Source files
TEMPLATES = article paper thesis book

# Directories
TEMPLATEDIR = templates
OUTPUTDIR = output

# =============================================================================
# Default target
# =============================================================================
.PHONY: all
all: $(TEMPLATES)

# =============================================================================
# Individual template targets
# =============================================================================
.PHONY: article
article:
	@echo "Building article..."
	@mkdir -p $(OUTPUTDIR)
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) article.tex
	@cd $(TEMPLATEDIR) && $(BIBER) article
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) article.tex
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) article.tex
	@mv $(TEMPLATEDIR)/article.pdf $(OUTPUTDIR)/
	@echo "Done: $(OUTPUTDIR)/article.pdf"

.PHONY: paper
paper:
	@echo "Building paper..."
	@mkdir -p $(OUTPUTDIR)
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) paper.tex
	@cd $(TEMPLATEDIR) && $(BIBER) paper
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) paper.tex
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) paper.tex
	@mv $(TEMPLATEDIR)/paper.pdf $(OUTPUTDIR)/
	@echo "Done: $(OUTPUTDIR)/paper.pdf"

.PHONY: thesis
thesis:
	@echo "Building thesis..."
	@mkdir -p $(OUTPUTDIR)
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) thesis.tex
	@cd $(TEMPLATEDIR) && $(BIBER) thesis
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) thesis.tex
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) thesis.tex
	@mv $(TEMPLATEDIR)/thesis.pdf $(OUTPUTDIR)/
	@echo "Done: $(OUTPUTDIR)/thesis.pdf"

.PHONY: book
book:
	@echo "Building book..."
	@mkdir -p $(OUTPUTDIR)
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) book.tex
	@cd $(TEMPLATEDIR) && $(BIBER) book
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) book.tex
	@cd $(TEMPLATEDIR) && $(LATEX) $(LATEXFLAGS) book.tex
	@mv $(TEMPLATEDIR)/book.pdf $(OUTPUTDIR)/
	@echo "Done: $(OUTPUTDIR)/book.pdf"

# =============================================================================
# Clean targets
# =============================================================================
.PHONY: clean
clean:
	@echo "Cleaning auxiliary files..."
	@cd $(TEMPLATEDIR) && rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz *.nav *.snm *.vrb
	@cd $(TEMPLATEDIR) && rm -rf _minted-*
	@echo "Done."

.PHONY: distclean
distclean: clean
	@echo "Removing all generated files..."
	@rm -rf $(OUTPUTDIR)
	@echo "Done."

# =============================================================================
# Help
# =============================================================================
.PHONY: help
help:
	@echo "Modern LaTeX Templates - Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make article    - Build the article template"
	@echo "  make paper      - Build the paper template"
	@echo "  make thesis     - Build the thesis template"
	@echo "  make book       - Build the book template"
	@echo "  make all        - Build all templates"
	@echo "  make clean      - Remove auxiliary files"
	@echo "  make distclean  - Remove all generated files"
	@echo "  make help       - Show this help message"
