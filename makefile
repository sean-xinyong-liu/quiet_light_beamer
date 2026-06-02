# ==========================================
#   智能多目标 Makefile
# ==========================================

# 1. 配置
BUILD_DIR   := build
# 自动扫描当前目录下所有的 .tex 文件
SRCS        := $(wildcard *.tex)
# 定义所有对应的 .pdf 目标 (用于 make all)
PDFS        := $(SRCS:.tex=.pdf)

# 编译参数 (使用 xelatex 支持中文/Beamer)
LATEX_FLAGS := -xelatex -outdir=$(BUILD_DIR) -interaction=nonstopmode -shell-escape

# ==========================================
#   构建规则
# ==========================================

.PHONY: all clean help diagnose

# 目标 1: 输入 'make' 默认编译目录下所有 .tex 文件
all: $(PDFS)

# 目标 2: 通用模式规则 (核心功能)
# 允许输入 'make a' (只要 a.tex 存在)
# % 匹配文件名 (不带后缀)
%: %.tex
	@echo "Compiling target: $@"
	@mkdir -p $(BUILD_DIR)
	latexmk $(LATEX_FLAGS) $<
	@cp $(BUILD_DIR)/$@.pdf ./$@.pdf
	@echo "Done. Output: $@.pdf"

# 这是一个辅助规则，用于支持 make all 时的 .pdf 依赖
%.pdf: %.tex
	@$(MAKE) $*

# 清理规则
clean:
	@echo "Cleaning build directory..."
	rm -rf $(BUILD_DIR)
# 	rm -f *.pdf

# 帮助信息
help:
	@echo "Usage:"
	@echo "  make          : Compile all .tex files in directory"
	@echo "  make filename : Compile filename.tex (e.g., 'make a')"
	@echo "  make clean    : Remove build files and PDFs"

diagnose:
	@echo "🔍 Scanning build/*.log for LaTeX errors..."
	@# 1. 检查日志文件是否存在
	@if [ ! -f build/*.log ]; then \
		echo "❌ Error: build/*.log not found. Please run 'make' first."; \
		exit 1; \
	fi
	@# 2. 提取错误信息到临时文件 (使用单引号避免 zsh 报错)
	@# 匹配规则：以 ! 开头的行、包含 Error 或 Fatal 的行，并显示后 8 行上下文
	@grep -n -A 8 -E '^!|Error|Fatal' build/*.log > .diags.tmp || true
	@# 3. 判断是否捕获到内容
	@if [ -s .diags.tmp ]; then \
		echo "----------------------------------------"; \
		cat .diags.tmp; \
		echo "----------------------------------------"; \
		(pbcopy < .diags.tmp 2>/dev/null && echo "📋 \033[1;32mError log copied to macOS clipboard!\033[0m") || \
		(clip.exe < .diags.tmp 2>/dev/null && echo "📋 \033[1;32mError log copied to Windows clipboard!\033[0m") || \
		(xclip -selection clipboard < .diags.tmp 2>/dev/null && echo "📋 \033[1;32mError log copied to Linux clipboard!\033[0m") || \
		echo "⚠️  Clipboard tool not found. Please manually copy the above."; \
		echo "👉 Please paste the content to Gemini now."; \
	else \
		echo "✅ No standard LaTeX errors (starts with '!') found in log."; \
		echo "If build failed, check for missing files or run 'make clean'."; \
	fi
	@rm -f .diags.tmp