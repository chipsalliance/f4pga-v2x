# Minimal makefile for Sphinx documentation
#

MAKEDIR := $(dir $(lastword $(MAKEFILE_LIST)))

# You can set these variables from the command line.
SPHINXOPTS      =
SPHINXBUILD     = [ -e venv/bin/activate ] && source venv/bin/activate; sphinx-build
SPHINXAUTOBUILD = [ -e venv/bin/activate ] && source venv/bin/activate; sphinx-autobuild
SPHINXPROJ      = SymbiFlowV2X
SOURCEDIR       = .
BUILDDIR        = _build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

livehtml:
	@$(SPHINXAUTOBUILD) -b html --ignore \*.swp --ignore \*~ $(SPHINXOPTS) "$(SOURCEDIR)" "$(BUILDDIR)/html"

.PHONY: help livehtml Makefile

venv:
	rm -rf venv
	virtualenv --python=python3 venv
	source venv/bin/activate; pip install -r requirements.txt

.PHONY: venv

# Update fuzzer / minitest markdown links.
tests-links:
	@mkdir -p $(MAKEDIR)/tests
	@cd $(MAKEDIR)/tests && find -name '*.md' -delete && find -type d -empty -delete
	@cd $(MAKEDIR)/tests && \
		for I in $$(cd ../../tests/ ; find -name '*.md' | sort); do \
			F=$$(dirname $$I); D=$$(dirname $$F); N=$$(basename $$F); \
			S=../../tests/$$I; O=$$D/$$N.md; \
			if [ ! -d $$D ]; then \
				mkdir -p $$D; \
			fi; \
			ln -sf $$(realpath $$S --relative-to=$$D) $$O; \
		done
	@cd $(MAKEDIR)/tests && \
		for I in $$(cd ../../tests/ ; find -name '*.svg' -o -name '*.png' | sort); do \
			F=$$(dirname $$I); D=$$(dirname $$F); N=$$(basename $$I); \
			S=../../tests/$$I; O=$$D/$$N; \
			ln -sf $$(realpath $$S --relative-to=$$D) $$O; \
		done

links: tests-links
	@true

.PHONY: tests-links links

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile links
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
