# Quiet Light Beamer Theme

基于 **Metropolis** 定制的 Beamer 模板。目标是提供一套安静、护眼、卡片式的演示文稿样式，适用于学术报告、课程讲义与技术分享。

[打开示例 PDF](demo.pdf)

## 特性

- **护眼配色**：暖灰背景 `QLBg`、深灰正文 `QLFg`，用紫色 `QLPurple` 建立主题识别。
- **极简标题栏**：浅背景融合页面，使用贯穿全屏的细虚线分隔标题区。
- **统一卡片系统**：普通卡片、Beamer blocks、代码块、表格和图片容器复用同一套圆角与阴影。
- **中文友好**：默认使用 XeLaTeX/LuaLaTeX，并预设 macOS 的 `Songti TC` 与 `Menlo`。
- **可配置字体**：可通过包选项替换字体，或关闭内置字体配置以接入自己的导言区。
- **兼容原有命令**：保留 `cardtable`、`codeblock`、`\shadowimage`、`\shadowimageplain` 等核心接口。

## 依赖

- LaTeX 发行版：TeX Live、MacTeX 或 MiKTeX
- 编译器：推荐 `XeLaTeX`
- 主题依赖：`metropolis`
- 常用宏包：`ctex`、`fontspec`、`tcolorbox`、`tabularx`、`tikz`

默认字体配置面向 macOS：

- CJK：`Songti TC`
- Monospace：`Menlo`

Windows/Linux 用户建议在载入包时指定本机字体。

## 快速开始

```latex
\documentclass[aspectratio=169]{beamer}
\usepackage{quiet_light}

\title{Quiet Light Demo}
\author{Your Name}
\date{\today}

\begin{document}
\maketitle

\begin{frame}{Hello}
  这是一页 Quiet Light 风格的幻灯片。
\end{frame}

\end{document}
```

编译：

```bash
make demo
```

或直接运行：

```bash
latexmk -xelatex -outdir=build -interaction=nonstopmode demo.tex
```

## 字体配置

默认配置：

```latex
\usepackage{quiet_light}
```

指定跨平台字体：

```latex
\usepackage[
  cjkmainfont={Noto Serif CJK SC},
  cjksansfont={Noto Serif CJK SC},
  cjkmonofont={Noto Sans Mono CJK SC},
  monofont={JetBrains Mono},
  fakebold=2.0
]{quiet_light}
```

如果你希望完全自己管理字体与中文支持：

```latex
\usepackage[fonts=false]{quiet_light}
```

`nofonts` 是 `fonts=false` 的简写：

```latex
\usepackage[nofonts]{quiet_light}
```

## 核心命令

### 卡片

```latex
\begin{quietcard}
  任意内容都可以放进一个基础卡片。
\end{quietcard}
```

可以直接传入 `tcolorbox` 选项：

```latex
\begin{quietcard}[colback=white]
  自定义背景的卡片。
\end{quietcard}
```

### 表格

```latex
\begin{cardtable}{l X}
  \rowcolor{QLBlue!15}
  \textbf{特性} & \textbf{说明} \\
  护眼配色 & 使用暖灰背景替代纯白。 \\
  \rowcolor{QLBg!50!white}
  卡片设计 & 使用统一圆角与柔和阴影。 \\
\end{cardtable}
```

`cardtable` 也支持追加 `tcolorbox` 选项：

```latex
\begin{cardtable}[colback=QLBg!20!white]{l X}
  A & B \\
\end{cardtable}
```

### 代码块

包含代码的 frame 需要加 `[fragile]`：

```latex
\begin{frame}[fragile]{Code}
  \begin{codeblock}[python]{script.py}
def hello():
    print("Hello World")
  \end{codeblock}
\end{frame}
```

如果不需要标题，可以传空标题：

```latex
\begin{codeblock}[python]{}
print("Quiet Light")
\end{codeblock}
```

### 图片

带白边：

```latex
\shadowimage[height=5cm]{figures/m.jpg}
```

无白边：

```latex
\shadowimageplain[height=5cm]{figures/m.png}
```

别名：

```latex
\qlimage{figures/m.png}
\qlimageframed{figures/m.jpg}
```

### Blocks

```latex
\begin{block}{标题}
  普通说明。
\end{block}

\begin{alertblock}{警告}
  重要提示。
\end{alertblock}

\begin{exampleblock}{示例}
  示例内容。
\end{exampleblock}
```

## 排版建议

- 多列布局建议使用 `\begin{columns}[T]` 保持顶部对齐。
- 图片过高时优先指定 `height`，例如 `\shadowimage[height=4cm]{...}`。
- 单页内容过多时可以临时使用 `\begin{frame}[shrink=10]{标题}`，但更推荐拆页。
- 代码页必须使用 `[fragile]`。

## 构建命令

```bash
make        # 编译目录下所有 .tex 文件
make demo   # 只编译 demo.tex
make clean  # 删除 build 目录
make help   # 查看帮助
```
