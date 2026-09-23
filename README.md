# 沈阳理工大学博士学位论文 LaTeX 模板

这是我面向沈阳理工大学学弟学妹整理的第一份公开版 LaTeX 学位论文模板，目前以博士学位论文为基础。

在论文写作过程中，我花了不少时间调整扉页、页眉、目录、图表和参考文献的格式。因此，我将自己使用并完成格式核对的工程整理成通用模板，去除个人论文内容，补充写作说明和排版示例，希望能让后来者少走一些弯路，把更多时间留给研究与写作。

模板保留沈阳理工大学的中文扉页骨架、英文扉页、独创性声明、版权使用授权书、学校页眉和页码等元素，并提供公式、三线表、双语图表题、算法、文献引用及附录示例。默认配置无需额外上传字体，可按下文在本地或 Overleaf 编译。

这是一次从个人使用走向共同完善的尝试。欢迎学弟学妹通过 Issues 反馈问题，也欢迎提交改进建议或 Pull Requests。希望这份模板能够成为一份持续积累的经验，让论文排版更轻松一些。

> 本项目为个人整理的非官方模板，目前主要面向博士学位论文；不代表学校官方发布或认证。提交前请以学校及所在学院当年的正式要求为准。默认便携字体与确认版 Word 的字形有所区别，详见下文。

## 快速开始

### Overleaf

1. 使用本项目的公开源码 ZIP 新建项目（保留目录结构）；或者把源码上传到现有空项目。
2. 将主文档设为 `main.tex`，编译器设为 **XeLaTeX**。使用 TeX Live 2023 或更新版本的完整环境。
3. 点击编译。`latexmkrc` 会让 latexmk 处理 BibTeX 与多轮交叉引用。
4. 编辑 `thesis-info.tex` 填写个人信息，在 `chapters/` 中逐章写作。

默认 `portablefonts` 模式不需要上传额外字体，不需要 shell escape，也不需要 Python 或任何外部图片。

### 本地

安装包含中文组件的完整 TeX Live 或 MacTeX，并确保 `xelatex`、`bibtex` 和 `latexmk` 可执行。Windows 使用 TeX Live 时还需让 latexmk 所需的 Perl 可用。

在项目目录运行：

```sh
latexmk -xelatex main.tex
```

也可在 macOS/Linux 执行 `sh build.sh`，在 Windows 执行 `build.cmd`。生成的文件是根目录的 `main.pdf`。

如果不用 latexmk，依次执行：

```sh
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

修改文献或交叉引用后应重新完成编译。清理中间文件运行 `latexmk -c`，它会保留最终 PDF。

## 两种字体模式

主文件第一条有效命令中的选项控制字体：

```latex
\documentclass[twoside,doctor,fontset=fandol,portablefonts]{syluthesis}
```

- `portablefonts`（默认）：固定使用 TeX 自带的 Fandol 与 TeX Gyre 字体，即使电脑安装了其他字体也不自动切换，便于不同平台复现。学校扉页结构、页眉、字号和排版参数保留，但字形及部分换行可能与确认版不同。
- `schoolfonts`：将上面的 `portablefonts` 替换为 `schoolfonts`，使用自己提供的确认版字体。需要根目录的 `simsun.ttc`、`SimHei.ttf`，以及 `fonts/cover/` 下的 `HYShuSongErKW.ttf` 和 `HYZhongHeiKW.ttf`。英文使用 Times New Roman，详见 [字体说明](fonts/README.md)。缺少字体会给出日志警告并回退；警告不是“完全一致”的保证。

两种模式的页眉均使用 TeX 随附的 Fandol 楷体，与整理前工程的页眉字体一致。公开源码包不包含自备字体文件；本地审核工程中保留的自备字体已由 `.gitignore` 排除。

## 文件导航

| 文件或目录 | 用途 |
| --- | --- |
| `main.tex` | 唯一主文档，控制章节顺序、字体模式和单双面选项 |
| `thesis-info.tex` | 题目、作者、导师、日期等个人信息 |
| `syluthesis.cls` | 学校排版设置，一般无需修改 |
| `sylu-fonts.tex` | 集中管理两种字体方案 |
| `cover-word.tex` | 中文扉页的固定位置与骨架 |
| `chapters/` | 摘要、正文示例、附录、致谢和科研成果 |
| `figures/workflow.tex` | 原创通用流程图，不含原论文图片 |
| `reference/references.bib` | 已标明为虚构的参考文献示例 |
| `gbt7714-2005-numerical.bst` | 沿用确认版的参考文献样式 |
| `latexmkrc`、`build.sh`、`build.cmd` | 编译配置与快捷入口 |
| `scripts/package.py` | 按文件白名单导出干净的公开源码 ZIP |
| `docs/USAGE.md` | 写作、引用、增删章节及常见问题 |
| `docs/VALIDATION.md` | 本次实际验证范围 |
| `THIRD_PARTY.md`、`license.txt` | 来源说明与原有许可文本 |

## 开始写论文

先完整编译示例，再修改个人信息，最后逐章替换内容。示例包含公式、符号解释、定理证明、流程图、三线表、双语图题表题、算法与交叉引用。附录和成果栏目可按需要删除。正文没有固定章节数量限制。

所有示例数据、成果和参考文献均为占位内容，不能作为真实研究材料提交。日期中的 `20XX` 和 `X` 也应逐项替换。

## 导出与公开发布

可选：安装 Python 3 后，在项目目录执行：

```sh
python3 scripts/package.py
```

生成 `dist/syluthesis-template.zip`。脚本只打包列明的模板文件，排除字体、编译产物和本地备份，适合上传 GitHub Release 或导入 Overleaf。新增章节或图片后如需纳入发布包，请同步修改脚本白名单。

GitHub 仓库应上传源码，不要强制加入 `.gitignore` 排除的自备字体、原论文或编译缓存。保留第三方来源说明和许可文本。首次使用建议先编译完整示例，再逐步替换为自己的论文内容。
