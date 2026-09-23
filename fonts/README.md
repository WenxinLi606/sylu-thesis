# 字体说明

默认 `portablefonts` 完全依靠 TeX 发行版字体；本目录没有字体也能编译。

## 确认版字体模式

在 `main.tex` 中把 `portablefonts` 改成 `schoolfonts`，并由使用者自行准备：

| 相对工程根目录的路径 | 用途 |
| --- | --- |
| `simsun.ttc` | 正文宋体，使用字体集合的默认首个字体 |
| `SimHei.ttf` | 正文及标题黑体 |
| `fonts/cover/HYShuSongErKW.ttf` | 中文扉页汉仪书宋二 |
| `fonts/cover/HYZhongHeiKW.ttf` | 中文扉页汉仪中黑 |
| `fonts/latin/times.ttf` | Times New Roman 常规 |
| `fonts/latin/timesbd.ttf` | Times New Roman 粗体 |
| `fonts/latin/timesi.ttf` | Times New Roman 斜体 |
| `fonts/latin/timesbi.ttf` | Times New Roman 粗斜体 |

四份 Times New Roman 文件应成套提供，大小写和上述文件名保持一致。如果没有本地 `times.ttf`，模板尝试已安装的 Times New Roman；仍不可用时采用 TeX Gyre Termes，并写入警告。文件改名不会改变其内部字体内容，请确保实际文件对应表中的字重。

本地审核工程可能保留四份已有的中文字体，公开包与 Git 默认均排除这些字体。没有核实这些文件的公开再分发授权，因此它们不作为模板的公开依赖。使用者应自行取得所需字体及适用授权。

两种模式均保留扉页坐标、字号和页眉布局。但不同字体具有不同的字形、字宽和字体度量；仅仅能编译不意味着与 Word 完全一致。填写自己的长题目、多个导师或长项目名称后，仍需检查扉页是否超出字段边界。当前扉页标题沿用固定单行布局，不会自动缩小或换行；需要更长题目时应结合学校要求调整 `cover-word.tex`。

页眉采用 TeX 发行版自带的 `FandolKai-Regular.otf`，无需重复上传根目录下的同名字体。字体来源和权利说明见项目根目录 `THIRD_PARTY.md`。
