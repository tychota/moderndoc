# =============================================================================
# Makefile for Modern LaTeX Templates
# =============================================================================
# Usage:
#   make article    - Build the article template
#   make paper      - Build the paper template
#   make thesis     - Build the thesis template
#   make book       - Build the book template
#   make report     - Build the report template
#   make letter     - Build the letter template
#   make minimal    - Build the minimal template
#   make all        - Build all templates
#   make clean      - Remove auxiliary files
#   make distclean  - Remove all generated files
# =============================================================================

# Directories
ROOT      := $(shell pwd)
TEXDIR    := $(ROOT)/tex/latex/modern-doc
TEMPLATEDIR := $(ROOT)/templates
BUILDDIR  := $(ROOT)/build
OUTPUTDIR := $(ROOT)/output

# Set TEXINPUTS to find class/package without relative paths
export TEXINPUTS := $(TEXDIR):$(TEMPLATEDIR):$(TEXINPUTS)
# Keep LuaTeX font cache under output/
export TEXMFCACHE := $(BUILDDIR)/.tex-cache

# latexmk with project latexmkrc
# -f forces completion even with errors (needed for multi-pass builds)
LATEXMK = latexmk -r $(ROOT)/latexmkrc -f

# Source files
TEMPLATES = article paper thesis book report letter minimal

# =============================================================================
# Default target
# =============================================================================
.PHONY: all
all: $(TEMPLATES)

# =============================================================================
# Generic build rule
# =============================================================================
define build_template
.PHONY: $(1)
$(1):
	@echo "Building $(1)..."
	@mkdir -p $(BUILDDIR) $(OUTPUTDIR) $(TEXMFCACHE)
	@cd $(TEMPLATEDIR) && $(LATEXMK) -outdir=$(BUILDDIR) $(1).tex
	@cp $(BUILDDIR)/$(1).pdf $(OUTPUTDIR)/
	@echo "Done: $(OUTPUTDIR)/$(1).pdf"
endef

$(foreach tmpl,$(TEMPLATES),$(eval $(call build_template,$(tmpl))))

# =============================================================================
# Watch mode (continuous compilation)
# =============================================================================
.PHONY: watch-%
watch-%:
	@echo "Watching $*..."
	@mkdir -p $(BUILDDIR) $(OUTPUTDIR) $(TEXMFCACHE)
	@cd $(TEMPLATEDIR) && $(LATEXMK) -outdir=$(BUILDDIR) -pvc $*.tex

# =============================================================================
# Clean targets
# =============================================================================
.PHONY: clean
clean:
	@echo "Cleaning auxiliary files..."
	@rm -rf $(BUILDDIR)
	@rm -rf $(TEMPLATEDIR)/_minted-*
	@rm -f $(TEMPLATEDIR)/*.synctex.gz
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
	@echo "  make article     - Build the article template"
	@echo "  make paper       - Build the paper template"
	@echo "  make thesis      - Build the thesis template"
	@echo "  make book        - Build the book template"
	@echo "  make report      - Build the report template"
	@echo "  make letter      - Build the letter template"
	@echo "  make minimal     - Build the minimal template"
	@echo "  make all         - Build all templates"
	@echo "  make watch-NAME  - Watch and rebuild NAME on changes"
	@echo "  make clean       - Remove auxiliary files (build/)"
	@echo "  make distclean   - Remove all generated files"
	@echo "  make help        - Show this help message"
