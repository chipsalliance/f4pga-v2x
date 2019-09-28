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
	@cd $(MAKEDIR)/tests && rm -f *.md
	@cd $(MAKEDIR)/tests && \
		for i in ../../tests/*; do \
			n=$$(basename $$i | sed -e's/^[0-9][0-9][0-9]-//'); \
			if [ ! -d $$i ]; then \
				continue; \
			fi; \
			if [ -e $$i/README.md ]; then \
				echo "Linking $$i/README.md"; \
				ln -s $$i/README.md $${n}.md; \
			else \
				echo "Missing $$i/README.md"; \
			fi; \
		done

links: tests-links
	@true

.PHONY: tests-links links

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile links
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
