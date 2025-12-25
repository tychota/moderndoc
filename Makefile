# =============================================================================
# Makefile for Modern LaTeX Templates
# =============================================================================
# Usage:
#   make article    - Build the article example
#   make paper      - Build the paper example
#   make thesis     - Build the thesis example
#   make book       - Build the book example
#   make report     - Build the report example
#   make letter     - Build the letter example
#   make minimal    - Build the minimal example
#   make all        - Build all examples
#   make clean      - Remove auxiliary files
#   make distclean  - Remove all generated files
# =============================================================================

# Directories
ROOT      := $(shell pwd)
TEXDIR    := $(ROOT)/tex/latex/modern-doc
EXAMPLEDIR := $(ROOT)/examples
BUILDDIR  := $(ROOT)/build
OUTPUTDIR := $(ROOT)/output

# Set TEXINPUTS to find class/package without relative paths
# Include TEXDIR for class/sty and subdirs of EXAMPLEDIR
export TEXINPUTS := $(TEXDIR):$(EXAMPLEDIR)//:$(TEXINPUTS)
# Keep LuaTeX font cache under build/
export TEXMFCACHE := $(BUILDDIR)/.tex-cache

# latexmk with project latexmkrc
# -f forces completion even with errors (needed for multi-pass builds)
LATEXMK = latexmk -r $(ROOT)/latexmkrc -f

# Example names
EXAMPLES = article paper thesis book report letter minimal

# =============================================================================
# Default target
# =============================================================================
.PHONY: all
all: $(EXAMPLES)

# =============================================================================
# Generic build rule
# =============================================================================
define build_example
.PHONY: $(1)
$(1):
	@echo "Building $(1) example..."
	@mkdir -p $(BUILDDIR) $(OUTPUTDIR) $(TEXMFCACHE)
	@cd $(EXAMPLEDIR)/$(1) && $(LATEXMK) -outdir=$(BUILDDIR) $(1).tex
	@cp $(BUILDDIR)/$(1).pdf $(OUTPUTDIR)/
	@echo "Done: $(OUTPUTDIR)/$(1).pdf"
endef

$(foreach ex,$(EXAMPLES),$(eval $(call build_example,$(ex))))

# =============================================================================
# Watch mode (continuous compilation)
# =============================================================================
.PHONY: watch-%
watch-%:
	@echo "Watching $*..."
	@mkdir -p $(BUILDDIR) $(OUTPUTDIR) $(TEXMFCACHE)
	@cd $(EXAMPLEDIR)/$* && $(LATEXMK) -outdir=$(BUILDDIR) -pvc $*.tex

# =============================================================================
# Clean targets
# =============================================================================
.PHONY: clean
clean:
	@echo "Cleaning auxiliary files..."
	@rm -rf $(BUILDDIR)
	@find $(EXAMPLEDIR) -name "_minted-*" -type d -exec rm -rf {} +
	@find $(EXAMPLEDIR) -name "*.synctex.gz" -type f -delete
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
	@echo "  make article     - Build the article example"
	@echo "  make paper       - Build the paper example"
	@echo "  make thesis      - Build the thesis example"
	@echo "  make book        - Build the book example"
	@echo "  make report      - Build the report example"
	@echo "  make letter      - Build the letter example"
	@echo "  make minimal     - Build the minimal example"
	@echo "  make all         - Build all examples"
	@echo "  make watch-NAME  - Watch and rebuild NAME on changes"
	@echo "  make clean       - Remove auxiliary files (build/)"
	@echo "  make distclean   - Remove all generated files"
	@echo "  make help        - Show this help message"