# Minimal makefile for Sphinx documentation
#

MAKEDIR := $(dir $(lastword $(MAKEFILE_LIST)))

# You can set these variables from the command line.
SPHINXOPTS      =
SPHINXBUILD     = [ -e env/bin/activate ] && . env/bin/activate; sphinx-build
SPHINXAUTOBUILD = [ -e env/bin/activate ] && . env/bin/activate; sphinx-autobuild
SPHINXPROJ      = SymbiFlowV2X
SOURCEDIR       = .
BUILDDIR        = _build
OSFLAG 				:=
UNAME_S := $(shell uname -s)
ifneq (, $(findstring Linux, $(UNAME_S)))
	OSFLAG := Linux
endif
ifeq ($(UNAME_S), Darwin)
	OSFLAG := MacOSX
endif
ifneq (, $(findstring Cygwin, $(UNAME_S)))
	OSFLAG := Linux
endif
ifneq (, $(findstring MINGW, $(UNAME_S)))
	OSFLAG := Linux
endif


# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

livehtml:
	@$(SPHINXAUTOBUILD) -b html --ignore \*.swp --ignore \*~ $(SPHINXOPTS) "$(SOURCEDIR)" "$(BUILDDIR)/html"

.PHONY: help livehtml Makefile


env/Miniconda3:
	mkdir env
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-$(OSFLAG)-x86_64.sh -O env/Miniconda3-latest-$(OSFLAG)-x86_64.sh
	chmod a+x env/Miniconda3-latest-$(OSFLAG)-x86_64.sh

env:
	rm -rf env
	make env/Miniconda3
	./env/Miniconda3-latest-$(OSFLAG)-x86_64.sh -p $(PWD)/env -b -f
	. env/bin/activate; conda config --system --add envs_dirs $(PWD)/env/envs
	. env/bin/activate; conda config --system --add pkgs_dirs $(PWD)/env/pkgs
	. env/bin/activate; conda env update --name base --file ./environment.yml

.PHONY: env

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
