# Quiet Light Beamer Theme

基于 **Metropolis** 深度定制的 Beamer 模板。主打**极简、护眼、卡片式**设计，适用于学术报告与技术分享。

![Preview](demo.png)

## ✨ 特性 (Features)

* **🎨 护眼配色**：使用暖灰色 (`QLBg`) 作为背景，深灰色 (`QLFg`) 正文，紫色 (`QLPurple`) 作为主色调。
* **📏 极简标题栏**：背景透明融合，底部配有贯穿全屏的精细虚线。
* **🃏 卡片式设计**：代码块、表格、引用块均采用统一的圆角卡片 + 柔和阴影风格。
* **🦓 斑马纹表格**：摒弃传统实线网格，采用交替背景色（斑马纹）区分行，数据展示更清晰。
* **🖼 智能图片容器**：提供“拍立得风格”和“纯净风格”两种图片指令，自动适配布局。
* **🔤 预设字体**：内置 macOS 优化字体配置（宋体 Songti TC + Menlo），支持伪粗体。

## 🛠 依赖与编译 (Requirements)

由于使用了 `fontspec` 和 `ctex` 设置特定字体，**必须使用 XeLaTeX 编译**。

* **编译器**: `XeLaTeX`
* **系统**: 默认配置适配 **macOS** (依赖 `Songti TC` 和 `Menlo` 字体)。
    * *Windows/Linux 用户需在 `.sty` 文件中修改为系统已有字体。*

## 🚀 快速开始 (Quick Start)

1.  将 `quiet_light.sty` 放入项目目录。
2.  在 `.tex` 文件中引入：
    ```latex
    \documentclass[aspectratio=1610]{beamer}
    \usepackage{quiet_light}
    ```
3.  编译：
    ```bash
    xelatex demo.tex
    ```

## 📝 核心命令速查 (Cheat Sheet)

### 1. 表格 (Card Table)
自动包裹在白色圆角卡片中。**建议使用斑马纹替代实线边框**：
```latex
\begin{cardtable}{l X} 
    % 表头背景
    \rowcolor{QLBlue!15} 
    \textbf{特性} & \textbf{说明} \\
    
    % 内容行
    内容A & 详情A \\
    
    % 斑马纹背景 (隔行添加)
    \rowcolor{QLBg!50!white} 
    内容B & 详情B \\
\end{cardtable}
````

### 2\. 图片 (Images)

支持自动缩放与双重约束（宽/高），推荐指定 `height`。

  * **带白边 (拍立得风格)**:

    ```latex
    \shadowimage[height=5cm]{img.jpg}
    ```

  * **无白边 (纯净风格)**:

    ```latex
    \shadowimageplain[height=5cm]{img.png}

### 3\. 代码块 (Code Block)

带语法高亮和文件名的卡片。

```latex
% [语言]{标题}
\begin{codeblock}[python]{script.py}
def hello():
    print("Hello World")
\end{codeblock}
```

### 4\. 区块 (Blocks)

```latex
\begin{block}{标题} ... \end{block}        % 紫色 (默认)
\begin{alertblock}{标题} ... \end{alertblock}  % 红色 (警告)
\begin{exampleblock}{标题} ... \end{exampleblock} % 蓝色 (示例)
```

## 💡 排版建议

  * **多列布局**：包含图片时，建议使用 `\begin{columns}[T]` 确保顶部对齐。
  * **图片防溢出**：如果在某一页图片超出底边，请手动在命令中指定更小的高度参数，如 `[height=4cm]`。
* **内容过多**：如果单页内容稍多导致溢出，可使用 [shrink=n] 参数（n 为缩小百分比）自动缩放：
    ```latex
    % 整体缩小 10% (即按 90% 比例显示)
    \begin{frame}[shrink=10]{标题} 
    ... 
    \end{frame}
    ```