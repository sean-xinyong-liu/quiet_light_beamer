# Quiet Light Beamer Theme build rules

BUILD_DIR      ?= build
LATEXMK        ?= latexmk
LATEXMK_FLAGS  ?= -xelatex -outdir=$(BUILD_DIR) -interaction=nonstopmode

SRCS := $(wildcard *.tex)
PDFS := $(SRCS:.tex=.pdf)

.PHONY: all clean diagnose help

all: $(PDFS)

%: %.tex
	@echo "Compiling target: $@"
	@mkdir -p $(BUILD_DIR)
	$(LATEXMK) $(LATEXMK_FLAGS) $<
	@cp $(BUILD_DIR)/$@.pdf ./$@.pdf
	@echo "Done. Output: $@.pdf"

%.pdf: %.tex
	@$(MAKE) $*

clean:
	@echo "Cleaning build directory..."
	@rm -rf $(BUILD_DIR)

diagnose:
	@echo "Scanning $(BUILD_DIR)/*.log for LaTeX errors..."
	@logs="$$(find "$(BUILD_DIR)" -name '*.log' -type f 2>/dev/null)"; \
	if [ -z "$$logs" ]; then \
		echo "Error: no log files found. Run 'make' first."; \
		exit 1; \
	fi; \
	grep -n -A 8 -E '^!|Error|Fatal' $$logs > .diags.tmp || true; \
	if [ -s .diags.tmp ]; then \
		echo "----------------------------------------"; \
		cat .diags.tmp; \
		echo "----------------------------------------"; \
		(pbcopy < .diags.tmp 2>/dev/null && echo "Error log copied to macOS clipboard.") || \
		(clip.exe < .diags.tmp 2>/dev/null && echo "Error log copied to Windows clipboard.") || \
		(xclip -selection clipboard < .diags.tmp 2>/dev/null && echo "Error log copied to Linux clipboard.") || \
		echo "Clipboard tool not found. Please copy the log above manually."; \
	else \
		echo "No standard LaTeX errors found in log files."; \
	fi; \
	rm -f .diags.tmp

help:
	@echo "Usage:"
	@echo "  make           Compile all .tex files in the directory"
	@echo "  make demo      Compile demo.tex"
	@echo "  make clean     Remove build files"
	@echo "  make diagnose  Extract common LaTeX errors from build logs"
