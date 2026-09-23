%%
%% syluthesis.cls
%% LaTeX thesis template for Shenyang Ligong University doctoral dissertation.
%% Adapted from the public hhuthesis project structure for local thesis use.
%%
\NeedsTeXFormat{LaTeX2e}[2020/10/01]
\ProvidesClass{syluthesis}[2026/09/23 v1.1 Shenyang Ligong University doctoral thesis class]

% portablefonts is deterministic and needs no private font files.
\newif\ifsylu@schoolfonts
\sylu@schoolfontsfalse
\DeclareOption{portablefonts}{\sylu@schoolfontsfalse}
\DeclareOption{schoolfonts}{\sylu@schoolfontstrue}
\newif\ifsylu@twoside
\sylu@twosidetrue
\DeclareOption{oneside}{\sylu@twosidefalse}
\DeclareOption{twoside}{\sylu@twosidetrue}
\DeclareOption{doctor}{}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
\RequirePackage{iftex}
\ifXeTeX\else
  \ClassError{syluthesis}{XeLaTeX is required}{Select XeLaTeX as the compiler.}
\fi


\ifsylu@twoside
  \LoadClass[zihao=-4,a4paper,twoside,openany,UTF8,space=auto]{ctexbook}
\else
  \LoadClass[zihao=-4,a4paper,oneside,openany,UTF8,space=auto]{ctexbook}
\fi

% Do not force pages to have identical bottom baselines; otherwise LaTeX may
% enlarge the stretchable vertical glue around headings and displayed equations.
\raggedbottom

\RequirePackage{amsmath,amssymb,amsfonts,bm}
\RequirePackage{amsthm}
\RequirePackage{fontspec}
\RequirePackage{newunicodechar}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{titletoc}
\RequirePackage{caption}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{makecell}
\RequirePackage{multirow}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{enumitem}
\RequirePackage[numbers,square,comma,super,sort&compress]{natbib}
\RequirePackage{hyperref}

% Page layout from the 2026 SYLU formatting document and the checked final DOCX.
\geometry{
  paper=a4paper,
  top=30mm,
  bottom=25mm,
  left=25mm,
  right=25mm,
  headheight=14pt,
  headsep=2.5mm,
  footskip=7mm
}

% Centralized, portable font configuration.
\input{sylu-fonts.tex}
\SetSymbolFont{operators}{normal}{OT1}{ptm}{m}{n}
\SetSymbolFont{operators}{bold}{OT1}{ptm}{b}{n}

% Chinese punctuation must keep a uniform full-width Songti face while
% inheriting the surrounding font size.  Use \sylusong instead of \songti so
% that punctuation follows the uploaded simsun.ttc file on Overleaf.
\DeclareRobustCommand{\sylu@cnpunct}[1]{%
  \ifmmode
    \text{{\sylusong\char"#1}}%
  \else
    {{\sylusong\char"#1}}%
  \fi}
\newunicodechar{，}{\sylu@cnpunct{FF0C}}
\newunicodechar{。}{\sylu@cnpunct{3002}}
\newunicodechar{、}{\sylu@cnpunct{3001}}
\newunicodechar{；}{\sylu@cnpunct{FF1B}}
\newunicodechar{：}{\sylu@cnpunct{FF1A}}
\newunicodechar{？}{\sylu@cnpunct{FF1F}}
\newunicodechar{！}{\sylu@cnpunct{FF01}}
\newunicodechar{（}{\sylu@cnpunct{FF08}}
\newunicodechar{）}{\sylu@cnpunct{FF09}}
\newunicodechar{“}{\sylu@cnpunct{201C}}
\newunicodechar{”}{\sylu@cnpunct{201D}}
\newunicodechar{‘}{\sylu@cnpunct{2018}}
\newunicodechar{’}{\sylu@cnpunct{2019}}
\newunicodechar{《}{\sylu@cnpunct{300A}}
\newunicodechar{》}{\sylu@cnpunct{300B}}
\newunicodechar{〈}{\sylu@cnpunct{3008}}
\newunicodechar{〉}{\sylu@cnpunct{3009}}
\newunicodechar{【}{\sylu@cnpunct{3010}}
\newunicodechar{】}{\sylu@cnpunct{3011}}
\newunicodechar{〔}{\sylu@cnpunct{3014}}
\newunicodechar{〕}{\sylu@cnpunct{3015}}
\newunicodechar{「}{\sylu@cnpunct{300C}}
\newunicodechar{」}{\sylu@cnpunct{300D}}
\newunicodechar{『}{\sylu@cnpunct{300E}}
\newunicodechar{』}{\sylu@cnpunct{300F}}
\newunicodechar{—}{\sylu@cnpunct{2014}}
\newunicodechar{…}{\sylu@cnpunct{2026}}
\newunicodechar{·}{\sylu@cnpunct{00B7}}

% Chinese--Latin mixed text line breaking.
% Keep no fixed visual gap between CJK and Latin text, but insert a
% zero-width stretchable glue so XeTeX can break lines at CJK/Latin
% boundaries and avoid overfull lines in paragraphs with acronyms,
% percentages, and similar mixed tokens.
\xeCJKsetup{
  CJKecglue={\hskip 0pt plus 0.08em},
  PunctStyle=quanjiao,
  CheckSingle=true
}
\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip=0pt plus 1pt
\pretolerance=100
\tolerance=2000
\emergencystretch=1.5em

\makeatletter
% Keep ordinary digits in math mode visually consistent with the thesis
% Roman font.  This is a safety net for numeric values that must remain inside
% mathematical expressions.
\newcommand{\sylu@mathdigit@zero}{\text{\rmfamily 0}}
\newcommand{\sylu@mathdigit@one}{\text{\rmfamily 1}}
\newcommand{\sylu@mathdigit@two}{\text{\rmfamily 2}}
\newcommand{\sylu@mathdigit@three}{\text{\rmfamily 3}}
\newcommand{\sylu@mathdigit@four}{\text{\rmfamily 4}}
\newcommand{\sylu@mathdigit@five}{\text{\rmfamily 5}}
\newcommand{\sylu@mathdigit@six}{\text{\rmfamily 6}}
\newcommand{\sylu@mathdigit@seven}{\text{\rmfamily 7}}
\newcommand{\sylu@mathdigit@eight}{\text{\rmfamily 8}}
\newcommand{\sylu@mathdigit@nine}{\text{\rmfamily 9}}
\newcommand{\sylu@set@mathdigitcodes}{%
  \mathcode`0="8000 \mathcode`1="8000 \mathcode`2="8000 \mathcode`3="8000 \mathcode`4="8000
  \mathcode`5="8000 \mathcode`6="8000 \mathcode`7="8000 \mathcode`8="8000 \mathcode`9="8000
}
\begingroup
\catcode`0=\active
\catcode`1=\active
\catcode`2=\active
\catcode`3=\active
\catcode`4=\active
\catcode`5=\active
\catcode`6=\active
\catcode`7=\active
\catcode`8=\active
\catcode`9=\active
\gdef\sylu@define@mathdigits{%
  \def0{\sylu@mathdigit@zero}\def1{\sylu@mathdigit@one}\def2{\sylu@mathdigit@two}\def3{\sylu@mathdigit@three}\def4{\sylu@mathdigit@four}%
  \def5{\sylu@mathdigit@five}\def6{\sylu@mathdigit@six}\def7{\sylu@mathdigit@seven}\def8{\sylu@mathdigit@eight}\def9{\sylu@mathdigit@nine}%
}
\endgroup
\AtBeginDocument{\songti\rmfamily\sylu@set@mathdigitcodes\sylu@define@mathdigits}
% The school-mandated body layout is enabled only while typesetting numbered
% numbered chapters.  A dedicated flag is used instead of \if@mainmatter because
% this class deliberately keeps \if@mainmatter true in the back matter.
\newif\ifsylu@corechapters
\sylu@corechaptersfalse

% Body text: small four, compact default line spacing, first-line indent two
% Chinese chars.  numbered chapters override only the normal-text baseline below.
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{17bp}%
  \abovedisplayskip 1.5bp \@plus1bp \@minus1bp
  \abovedisplayshortskip 1.5bp \@plus1bp \@minus1bp
  \belowdisplayskip \abovedisplayskip
  \belowdisplayshortskip \abovedisplayshortskip}
\normalsize
\newskip\sylu@defaultbodybaselineskip
\sylu@defaultbodybaselineskip=\baselineskip
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

% Thesis metadata.
\newcommand\sylu@classification{}
\newcommand\sylu@securitylevel{公开}
\newcommand\sylu@udc{}
\newcommand\sylu@studentnumber{}
\newcommand\sylu@title{论文题目}
\newcommand\sylu@entitle{English Thesis Title}
\newcommand\sylu@author{作者姓名}
\newcommand\sylu@authorpinyin{Author Name}
\newcommand\sylu@supervisor{指导教师姓名}
\newcommand\sylu@supervisortitle{教授}
\newcommand\sylu@supervisoren{Professor Supervisor Name}
\newcommand\sylu@cosupervisor{}
\newcommand\sylu@tutorgroup{}
\newcommand\sylu@degree{博士}
\newcommand\sylu@degreecategory{工学}
\newcommand\sylu@discipline{学科名称}
\newcommand\sylu@specialprogram{}
\newcommand\sylu@submitdate{年\quad 月}
\newcommand\sylu@defensedate{年\quad 月}
\newcommand\sylu@awarddate{年\quad 月}
\newcommand\sylu@reviewer{}
\newcommand\sylu@chairman{}
\newcommand\sylu@date{年\quad 月}
\newcommand\sylu@englishdate{Month Year}
\newcommand\sylu@englishmajor{Your Discipline}

\newcommand\classification[1]{\gdef\sylu@classification{#1}}
\newcommand\securitylevel[1]{\gdef\sylu@securitylevel{#1}}
\newcommand\udc[1]{\gdef\sylu@udc{#1}}
\newcommand\studentnumber[1]{\gdef\sylu@studentnumber{#1}}
\renewcommand\title[1]{\gdef\sylu@title{#1}}
\newcommand\entitle[1]{\gdef\sylu@entitle{#1}}
\renewcommand\author[1]{\gdef\sylu@author{#1}}
\newcommand\authorpinyin[1]{\gdef\sylu@authorpinyin{#1}}
\newcommand\supervisor[1]{\gdef\sylu@supervisor{#1}}
\newcommand\supervisortitle[1]{\gdef\sylu@supervisortitle{#1}}
\newcommand\supervisoren[1]{\gdef\sylu@supervisoren{#1}}
\newcommand\cosupervisor[1]{\gdef\sylu@cosupervisor{#1}}
\newcommand\tutorgroup[1]{\gdef\sylu@tutorgroup{#1}}
\newcommand\degree[1]{\gdef\sylu@degree{#1}}
\newcommand\degreecategory[1]{\gdef\sylu@degreecategory{#1}}
\newcommand\discipline[1]{\gdef\sylu@discipline{#1}}
\newcommand\specialprogram[1]{\gdef\sylu@specialprogram{#1}}
\newcommand\submitdate[1]{\gdef\sylu@submitdate{#1}}
\newcommand\defensedate[1]{\gdef\sylu@defensedate{#1}}
\newcommand\awarddate[1]{\gdef\sylu@awarddate{#1}}
\newcommand\reviewer[1]{\gdef\sylu@reviewer{#1}}
\newcommand\chairman[1]{\gdef\sylu@chairman{#1}}
\renewcommand\date[1]{\gdef\sylu@date{#1}}
\newcommand\englishdate[1]{\gdef\sylu@englishdate{#1}}
\newcommand\englishmajor[1]{\gdef\sylu@englishmajor{#1}}

% Chapter and section formats.  In numbered numbered chapters, the school Word
% paragraph spacing is converted to output geometry rather than copied as raw
% CTeX skips.  The small asymmetric compensations below account for the
% different ascender/descender metrics of each heading size, producing balanced
% adjacent-baseline distances while retaining the mandated internal line space.
% 第一级（章）：二号黑体，居中，段前/段后各 1 行，单倍行距。
% 第二级（条）：三号黑体，居左，段前/段后各 0.5 行，单倍行距。
% 第三级（款）：四号黑体，居左，段前/段后各 0.5 行，单倍行距。
% 第四级（项）：小四号黑体，居左，段前/段后 0 行，固定 21 磅行距。
\newcommand{\sylu@ifcorechapter}[2]{%
  \ifsylu@corechapters
    \ifnum\c@chapter>0 %
      #1
    \else #2\fi
  \else #2\fi}
\newcommand{\sylu@headingheiti}{\rmfamily\heiti}
\newcommand{\sylu@chaptertitlefont}{\centering\sylu@headingheiti\zihao{2}\linespread{1}\selectfont}
\newcommand{\sylu@sectiontitlefont}{\raggedright\sylu@headingheiti\zihao{3}\linespread{1}\selectfont}
\newcommand{\sylu@subsectiontitlefont}{\raggedright\sylu@headingheiti\zihao{4}\linespread{1}\selectfont}
\newcommand{\sylu@subsubsectiontitlefont}{\raggedright\sylu@headingheiti\zihao{-4}\setlength{\baselineskip}{21bp}\selectfont}
\newcommand{\sylu@chaptertitlebeforeskip}{\sylu@ifcorechapter{12bp}{17bp}}
\newcommand{\sylu@chaptertitleafterskip}{\sylu@ifcorechapter{18bp}{17bp}}
\newcommand{\sylu@sectiontitlebeforeskip}{\sylu@ifcorechapter{8bp}{8.5bp}}
\newcommand{\sylu@sectiontitleafterskip}{\sylu@ifcorechapter{6bp}{8.5bp}}
\newcommand{\sylu@subsectiontitlebeforeskip}{\sylu@ifcorechapter{9.5bp}{8.5bp}}
\newcommand{\sylu@subsectiontitleafterskip}{\sylu@ifcorechapter{4bp}{8.5bp}}

\ctexset{
  chapter = {
    name = {第\hspace{0.35\ccwd},\hspace{0.35\ccwd}章},
    number = \arabic{chapter},
    aftername = \quad,
    format = {\sylu@chaptertitlefont},
    beforeskip = \sylu@chaptertitlebeforeskip,
    afterskip = \sylu@chaptertitleafterskip,
    fixskip = true,
    pagestyle = {sylu@headings}
  },
  section = {
    aftername = \quad,
    format = {\sylu@sectiontitlefont},
    beforeskip = \sylu@sectiontitlebeforeskip,
    afterskip = \sylu@sectiontitleafterskip,
    fixskip = true
  },
  subsection = {
    aftername = \quad,
    format = {\sylu@subsectiontitlefont},
    beforeskip = \sylu@subsectiontitlebeforeskip,
    afterskip = \sylu@subsectiontitleafterskip,
    fixskip = true
  },
  subsubsection = {
    aftername = \quad,
    format = {\sylu@subsubsectiontitlefont},
    beforeskip = 0bp,
    afterskip = 0bp,
    fixskip = true
  }
}

\newif\ifsylu@appendix
\renewcommand{\chaptermark}[1]{%
  \ifsylu@appendix
    \markboth{附录\quad\thechapter\quad #1}{}%
  \else
    \markboth{第\hspace{0.2\ccwd}\thechapter\hspace{0.2\ccwd}章\quad #1}{}%
  \fi}

% Header and footer: Kaiti 5 pt header, page number centered at bottom.
\fancypagestyle{sylu@empty}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}}

\fancypagestyle{sylu@headings}{%
  \fancyhf{}%
  \fancyhead[L]{\rmfamily\sylukai\zihao{5} 沈阳理工大学博士学位论文}%
  \fancyhead[R]{\rmfamily\sylukai\zihao{5} \leftmark}%
  \fancyfoot[C]{\rmfamily\zihao{-4}\if@mainmatter\mbox{-\ \thepage\ -}\else\thepage\fi}%
  \renewcommand{\headrulewidth}{0.5pt}%
  \renewcommand{\footrulewidth}{0pt}}

\renewcommand{\headrule}{%
  \ifdim\headrulewidth>0pt
    \hrule\@height\headrulewidth \@width\headwidth
    \vskip-\headrulewidth
  \fi}

\pagestyle{sylu@headings}
% Track the physical PDF page separately from the printed page number.  Blank
% verso pages are deliberately excluded from the printed page counter, so the
% parity of \c@page alone cannot reliably identify a recto page afterwards.
\newcount\sylu@physicalpage
\sylu@physicalpage=\z@
\AddToHook{shipout/after}{\global\advance\sylu@physicalpage\@ne}

% Start the next item on a recto page in two-sided mode.  When a blank verso is
% needed, give it the empty page style and an empty PDF page label, then cancel
% its page-counter increment.
% Thus, for example, a contents page following page V is numbered VI even when
% an unnumbered blank page lies between them.
\renewcommand{\cleardoublepage}{%
  \clearpage
  \ifsylu@twoside
    \ifodd\sylu@physicalpage
      \begingroup
        \thispagestyle{sylu@empty}%
        \thispdfpagelabel{}%
        \addtocounter{page}{-1}%
        \hbox{}\newpage
        \if@twocolumn\hbox{}\newpage\fi
      \endgroup
    \fi
  \fi}

\renewcommand{\frontmatter}{%
  \cleardoublepage
  \global\sylu@corechaptersfalse
  \sylu@restorecorelayout
  \@mainmatterfalse
  \pagenumbering{Roman}
  \pagestyle{sylu@headings}}

\renewcommand{\mainmatter}{%
  \clearpage
  \sylu@restorecorelayout
  \global\sylu@corechapterstrue
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{sylu@headings}}

\renewcommand{\backmatter}{%
  \clearpage
  \global\sylu@corechaptersfalse
  \sylu@restorecorelayout
  \@mainmattertrue
  \pagestyle{sylu@headings}}

% Cover and title pages.
\newcommand{\sylu@rightsinglepage}{\cleardoublepage\thispagestyle{sylu@empty}}
\newcommand{\sylu@ifempty}[3]{\if\relax\detokenize{#1}\relax #2\else #3\fi}
% Chinese title page: school Word template, 2026-09-23.
% Fonts and absolute page coordinates are isolated from the thesis body.
\input{cover-word.tex}

\newcommand{\makeenglishtitle}{%
  \sylu@rightsinglepage
  {\rmfamily
    {\noindent\bfseries\fontsize{15bp}{20bp}\selectfont A Dissertation in \sylu@englishmajor\par}
    \vspace*{68bp}
  \begin{center}
    {\bfseries\fontsize{22bp}{27bp}\selectfont\sylu@entitle\par}
    \vspace{58bp}
    {\fontsize{16bp}{22bp}\selectfont By \sylu@authorpinyin\par}
    \vspace{52bp}
    {\fontsize{16bp}{22bp}\selectfont Supervisor:\quad \begin{tabular}[t]{@{}c@{}}\sylu@supervisoren\end{tabular}\par}
    \vfill
    {\bfseries\fontsize{16bp}{20bp}\selectfont Shenyang Ligong University\par}
    \vspace{2bp}
    {\bfseries\fontsize{16bp}{20bp}\selectfont\sylu@englishdate\par}
  \end{center}}
  \clearpage}

\newcommand{\makedeclaration}{%
  \sylu@rightsinglepage
  {\centering\heiti\fontsize{22bp}{22bp}\selectfont 独创性声明\par}
  \vspace{12bp}
  {\songti\rmfamily\fontsize{14bp}{24.5bp}\selectfont\setlength{\parindent}{28bp}
  本人声明，所呈交的学位论文是在导师的指导下完成的。论文中取得的研究成果除加以标注和致谢的地方外，不包含其他人已经发表或撰写过的研究成果，也不包括本人为获得其他学位而使用过的材料。与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表示谢意。\par}
  \vspace{5bp}
  {\songti\rmfamily\fontsize{14bp}{21bp}\selectfont
  \hspace*{0.50\textwidth}学位论文作者签名：\par
  \vspace{5bp}
  \hspace*{0.50\textwidth}日\quad\quad 期：\par}
  \vspace{24bp}
  {\centering\heiti\fontsize{22bp}{33bp}\selectfont 学位论文版权使用授权书\par}
  \vspace{12bp}
  {\songti\rmfamily\fontsize{14bp}{24.5bp}\selectfont\setlength{\parindent}{28bp}
  本学位论文作者和指导教师完全了解沈阳理工大学有关保留、使用学位论文的规定：即学校有权保留并向国家有关部门或机构送交论文的复印件和磁盘，允许论文被查阅和借阅。本人同意沈阳理工大学可以将学位论文的全部或部分内容编入有关数据库进行检索、交流。\par}
  \vspace{0.5\baselineskip}
  {\songti\rmfamily\fontsize{14bp}{17.5bp}\selectfont\setlength{\parindent}{28bp}
  作者和导师同意网上交流的时间为作者获得学位后：\par
  \vspace{0.5\baselineskip}
  半年$\square$\quad 一年$\square$\quad 一年半$\square$\quad 两年$\square$\par
  \vspace{12bp}
  \noindent\begin{tabular}{@{}>{\raggedright\arraybackslash}p{231bp}@{}>{\raggedright\arraybackslash}p{180bp}@{}}
    学位论文作者签名： & 指导教师签名： \\[45bp]
    签字日期： & 签字日期：
  \end{tabular}\par}
  \clearpage}

\newcommand{\makesylutitle}{%
  \makecover
  \makeenglishtitle
  \makedeclaration}

% Front-matter titles.
\newcommand{\sylu@setfrontmark}[1]{\markboth{#1}{}}
\newcommand{\sylu@frontheading}[1]{%
  \par\vspace*{8bp}%
  {\centering\sylu@headingheiti\zihao{2}\linespread{1}\selectfont #1\par}%
  \vspace{12bp}}
% The eight principal unnumbered headings specified by the school Word
% template use no paragraph space before, one Word line (12 bp) after, and
% 1.5-line spacing within the heading.  Keep this separate from the legacy
% front-heading path for other optional unnumbered sections.
\newcommand{\sylu@specialfrontheading}[1]{%
  % Suppress TeX's context-dependent page-top interline glue, then apply only
  % the structural line-box correction measured for the 1.5-line heading.
  % This correction is not Word paragraph-before spacing, which remains zero.
  \par\nointerlineskip\vspace*{5.6bp}%
  {\centering\sylu@headingheiti\zihao{2}\linespread{1.5}\selectfont #1\par}%
  \vspace{12bp}}
\NewDocumentCommand{\sylu@abstracttitle}{o m}{%
  \IfNoValueTF{#1}{\def\sylu@abstractmark{#2}}{\def\sylu@abstractmark{#1}}%
  \cleardoublepage
  \phantomsection
  \sylu@setfrontmark{\sylu@abstractmark}
  \sylu@specialfrontheading{#2}}
\newcommand{\sylu@majorclear}{%
  \if@mainmatter\clearpage\else\cleardoublepage\fi}
\newcommand{\sylu@printmajortitle}[1]{%
  \phantomsection
  \sylu@setfrontmark{#1}
  \sylu@frontheading{#1}}
\newcommand{\sylu@majortitle}[1]{%
  \sylu@majorclear
  \sylu@printmajortitle{#1}}
\newcommand{\sylu@rectomajortitle}[1]{%
  \cleardoublepage
  \sylu@printmajortitle{#1}}
\newcommand{\sylu@printspecialmajortitle}[1]{%
  \phantomsection
  \sylu@setfrontmark{#1}
  \sylu@specialfrontheading{#1}}
\newcommand{\sylu@specialmajortitle}[1]{%
  \sylu@majorclear
  \sylu@printspecialmajortitle{#1}}
\newcommand{\sylu@rectospecialmajortitle}[1]{%
  \cleardoublepage
  \sylu@printspecialmajortitle{#1}}

\let\abstract\relax
\let\endabstract\relax
\NewDocumentEnvironment{abstract}{}{%
  \sylu@abstracttitle[摘要]{摘\quad 要}
}{}
\NewDocumentEnvironment{enabstract}{}{%
  \sylu@abstracttitle{Abstract}
}{}
\newcommand{\keywords}[1]{\par\vspace{\baselineskip}\noindent{\heiti 关键词：}#1\par}
\newcommand{\enkeywords}[1]{\par\vspace{\baselineskip}\noindent{\bfseries Keywords: }#1\par}

% Contents and lists.
\renewcommand{\contentsname}{目\quad 录}
\renewcommand{\listfigurename}{插图目录}
\renewcommand{\listtablename}{插表目录}

\renewcommand{\@dotsep}{1.0}
\newcommand*\sylu@tocnumberline[1]{#1\hspace{1\ccwd}}

% Chapter-level entries in the table of contents.
% Chinese characters use Heiti size 4; Arabic numerals and page numbers use
% Times New Roman size 4. Use \syluhei explicitly to keep CJK chapter titles
% in the uploaded Heiti font.
\newcommand*\sylu@tocchapterfont{\rmfamily\syluhei\zihao{4}\selectfont}
\newcommand*\sylu@tocchapterpagenumfont{\rmfamily\zihao{-4}\selectfont}
\newcommand*\sylu@tocchapternumberline[1]{%
  {\rmfamily\syluhei\zihao{4}\selectfont #1}\hspace{1\ccwd}}

\renewcommand*\l@chapter[2]{%
  {\let\numberline\sylu@tocchapternumberline
   \sylu@tocchapterfont
   \@dottedtocline{0}{0pt}{0pt}{#1}{{\sylu@tocchapterpagenumfont #2}}}}

\renewcommand*\l@section[2]{%
  {\let\numberline\sylu@tocnumberline\songti\rmfamily\fontsize{12bp}{20bp}\selectfont\@dottedtocline{1}{1\ccwd}{0pt}{#1}{#2}}}
\renewcommand*\l@subsection[2]{%
  {\let\numberline\sylu@tocnumberline\songti\rmfamily\fontsize{12bp}{20bp}\selectfont\@dottedtocline{2}{2\ccwd}{0pt}{#1}{#2}}}
\newcommand*\sylu@fignumberline[1]{图#1\hspace{1\ccwd}}
\newcommand*\sylu@tabnumberline[1]{表#1\hspace{1\ccwd}}
\renewcommand*\l@figure[2]{%
  {\let\numberline\sylu@fignumberline\songti\rmfamily\fontsize{12bp}{20bp}\selectfont\@dottedtocline{1}{0pt}{0pt}{#1}{#2}}}
\renewcommand*\l@table[2]{%
  {\let\numberline\sylu@tabnumberline\songti\rmfamily\fontsize{12bp}{20bp}\selectfont\@dottedtocline{1}{0pt}{0pt}{#1}{#2}}}

\renewcommand{\tableofcontents}{%
  \sylu@rectospecialmajortitle{\contentsname}
  {\setlength{\parskip}{0pt}\@starttoc{toc}}}
\renewcommand{\listoffigures}{%
  \sylu@rectospecialmajortitle{\listfigurename}
  {\setlength{\parskip}{0pt}\let\addvspace\@gobble\@starttoc{lof}}}
\renewcommand{\listoftables}{%
  \sylu@rectospecialmajortitle{\listtablename}
  {\setlength{\parskip}{0pt}\let\addvspace\@gobble\@starttoc{lot}}}

% Figures, tables and equations.
% Table body font.  The thesis body is small-four (\zihao{-4});
% table contents are required to be five-size (\zihao{5}).
% The flag below makes the setting apply to real table bodies only,
% so tabular/tabularx used on the cover and title pages is not affected.
\newif\ifsylu@intablebody
\newcommand{\sylu@tablefont}{\songti\rmfamily\zihao{5}\setlength{\baselineskip}{12bp}\selectfont}
\newcommand{\sylu@tablebodysetup}{%
  \sylu@tablefont
  \renewcommand{\arraystretch}{1.0}%
  \setlength{\tabcolsep}{3pt}%
  \renewcommand{\tabularxcolumn}[1]{>{\centering\arraybackslash}m{##1}}%
  \renewcommand\cellalign{cc}%
  \renewcommand\theadalign{cc}%
  \renewcommand\cellset{\sylu@tablefont\renewcommand{\arraystretch}{1.0}}% for makecell
}
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}
\renewcommand{\fnum@figure}{图\thefigure}
\renewcommand{\fnum@table}{表\thetable}
\DeclareCaptionLabelSeparator{syluspace}{\space}
\DeclareCaptionFont{sylufont}{\songti\rmfamily\zihao{5}\linespread{1}\selectfont}
\captionsetup{
  font=sylufont,
  labelfont=sylufont,
  textfont=sylufont,
  labelsep=syluspace,
  justification=centering,
  singlelinecheck=false,
  skip=2bp
}
\captionsetup[figure]{position=bottom}
\captionsetup[table]{position=top}
\renewcommand{\topfraction}{0.95}
\renewcommand{\bottomfraction}{0.90}
\renewcommand{\textfraction}{0.05}
\renewcommand{\floatpagefraction}{0.80}
\setcounter{topnumber}{5}
\setcounter{bottomnumber}{4}
\setcounter{totalnumber}{7}
\setlength{\floatsep}{8.5bp plus 1bp minus 1bp}
\setlength{\textfloatsep}{8.5bp plus 1bp minus 1bp}
\setlength{\intextsep}{8.5bp plus 1bp minus 1bp}
\setlength{\abovecaptionskip}{2bp}
\setlength{\belowcaptionskip}{0bp}

% Preserve the pre-existing layout outside numbered chapters.  The three float
% skips below are the distances between the complete float (including its
% caption) and surrounding text.  Caption-to-image/table spacing remains 2 bp.
\newskip\sylu@defaulttextfloatsep
\newskip\sylu@defaultintextsep
\newskip\sylu@defaultdbltextfloatsep
\sylu@defaulttextfloatsep=\textfloatsep
\sylu@defaultintextsep=\intextsep
\sylu@defaultdbltextfloatsep=\dbltextfloatsep

\newcommand{\sylu@applycorelayout}{%
  \global\baselineskip=21bp
  \global\textfloatsep=6bp
  \global\intextsep=6bp
  \global\dbltextfloatsep=6bp
  \ctexset{
    section/fixskip = false,
    subsection/fixskip = false,
    subsubsection/fixskip = false}}

\newcommand{\sylu@restorecorelayout}{%
  \global\baselineskip=\sylu@defaultbodybaselineskip
  \global\textfloatsep=\sylu@defaulttextfloatsep
  \global\intextsep=\sylu@defaultintextsep
  \global\dbltextfloatsep=\sylu@defaultdbltextfloatsep
  \ctexset{
    section/fixskip = true,
    subsection/fixskip = true,
    subsubsection/fixskip = true}}

\newcommand{\sylu@endcorechapters}{%
  \global\sylu@corechaptersfalse
  \sylu@restorecorelayout}

\newcommand{\sylu@leavecorechapters}{%
  \ifsylu@corechapters
    % Flush deferred body floats while the 6 bp spacing is still active.
    \clearpage
    \sylu@endcorechapters
  \fi}

% Apply the same body layout to every numbered chapter.
\apptocmd{\@chapter}{%
  \sylu@ifcorechapter{\sylu@applycorelayout}{}}{}{\ClassWarning{syluthesis}{Unable to install the numbered chapter body layout}}
\AddToHook{cmd/normalsize/after}{%
  \sylu@ifcorechapter{\setlength{\baselineskip}{21bp}}{}}
\pretocmd{\appendix}{\sylu@leavecorechapters\global\sylu@appendixtrue}{}{\ClassWarning{syluthesis}{Unable to install the appendix layout boundary}}
\AddToHook{env/thebibliography/before}{\sylu@leavecorechapters}

% Float initialization resets paragraph alignment; center AFTER that reset.
\apptocmd{\@floatboxreset}{%
  \ifdefstring{\@captype}{table}{\centering}{}%
}{}{\ClassError{syluthesis}{Cannot install centered table layout}{Check the float package configuration.}}
\AtBeginEnvironment{table}{\sylu@intablebodytrue\sylu@tablebodysetup}
\AtBeginEnvironment{table*}{\sylu@intablebodytrue\sylu@tablebodysetup}
\AtEndEnvironment{table*}{\sylu@intablebodyfalse}
\AtEndEnvironment{table}{\sylu@intablebodyfalse}
\AtBeginEnvironment{longtable}{%
  \sylu@tablebodysetup
  \sylu@ifcorechapter{\setlength{\LTpre}{6bp}\setlength{\LTpost}{6bp}}{}}
\AtBeginEnvironment{tabular}{\ifsylu@intablebody\sylu@tablebodysetup\fi}
\AtBeginEnvironment{tabularx}{\ifsylu@intablebody\sylu@tablebodysetup\fi}
\AtBeginEnvironment{array}{\ifsylu@intablebody\sylu@tablefont\fi}
\newcommand{\sylu@algorithmfont}{\songti\rmfamily\zihao{5}\linespread{1}\selectfont}
\AtBeginEnvironment{algorithm}{\sylu@algorithmfont}
\AtBeginEnvironment{algorithmic}{\sylu@algorithmfont\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}\setlength{\topsep}{0pt}}
\AtBeginDocument{%
  \@ifpackageloaded{algorithm}{%
    \floatname{algorithm}{算法}%
    \renewcommand{\thealgorithm}{\thechapter.\arabic{algorithm}}%
    \@addtoreset{algorithm}{chapter}%
    \captionsetup[algorithm]{%
      font=sylufont,
      labelfont=sylufont,
      textfont=sylufont,
      labelsep=syluspace,
      justification=raggedright,
      singlelinecheck=false,
      position=top,
      skip=2bp
    }%
  }{}%
}

\renewcommand{\thefigure}{\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\thechapter.\arabic{table}}
\renewcommand{\theequation}{\thechapter.\arabic{equation}}
\@addtoreset{figure}{chapter}
\@addtoreset{table}{chapter}
\@addtoreset{equation}{chapter}
\renewcommand{\tagform@}[1]{\maketag@@@{{\sylusong（}{\rmfamily #1}{\sylusong ）}}}

\NewDocumentCommand{\sylufigcaption}{O{}mm}{%
  \caption[#2]{#2\\{\rmfamily\zihao{5}\linespread{1}\selectfont Fig.\thefigure\space #3}}%
  \if\relax\detokenize{#1}\relax\else\label{#1}\fi}
\NewDocumentCommand{\sylutabcaption}{O{}mm}{%
  \caption[#2]{#2\\{\rmfamily\zihao{5}\linespread{1}\selectfont Table \thetable\space #3}}%
  \if\relax\detokenize{#1}\relax\else\label{#1}\fi}

\setlength{\heavyrulewidth}{1.5pt}
\setlength{\lightrulewidth}{0.75pt}
\setlength{\cmidrulewidth}{0.75pt}
\renewcommand{\arraystretch}{1.0}

\newenvironment{formulaexplain}{%
  \par\vspace{0.5\baselineskip}\noindent 式中：%
  \begin{description}[leftmargin=3.5em,labelwidth=3em,labelsep=0.5em,style=nextline,itemsep=0pt,parsep=0pt,topsep=0pt]
}{%
  \end{description}}
\DeclareRobustCommand{\eqref}[1]{\mbox{(\ref{#1})}\nobreak\hspace{-0.12em}\ignorespaces}
\newcommand{\eqrefcn}[1]{式\eqref{#1}}
\newcommand{\figrefcn}[1]{图\ref{#1}}
\newcommand{\tabrefcn}[1]{表\ref{#1}}

% Theorems and lists.
\theoremstyle{plain}
\newtheorem{theorem}{定理}[chapter]
\newtheorem{lemma}[theorem]{引理}
\theoremstyle{definition}
\newtheorem{definition}{定义}[chapter]
\newtheorem{example}{例}[chapter]
\theoremstyle{remark}
\newtheorem{remark}{注}
\renewcommand{\proofname}{证明}

\setlist[enumerate]{topsep=0pt,itemsep=0pt,parsep=0pt,leftmargin=2em}
\setlist[itemize]{topsep=0pt,itemsep=0pt,parsep=0pt,leftmargin=2em}

% Back matter.
\renewcommand{\bibname}{参考文献}
\renewenvironment{thebibliography}[1]{%
  \clearpage
  \phantomsection
  \sylu@setfrontmark{\bibname}
  \addcontentsline{toc}{chapter}{\bibname}
  \sylu@specialfrontheading{\bibname}
  \songti\rmfamily\zihao{-4}
  \list{\@biblabel{\@arabic\c@enumiv}}{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \setlength{\labelsep}{0.5em}
    \setlength{\topsep}{4bp}
    \setlength{\partopsep}{0pt}
    \setlength{\itemsep}{0pt}
    \setlength{\parsep}{0pt}
    \usecounter{enumiv}
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
}{\endlist}

\newenvironment{acknowledgement}{%
  \sylu@specialmajortitle{致谢}
  \addcontentsline{toc}{chapter}{致谢}
}{}
\newenvironment{publications}{%
  \sylu@specialmajortitle{攻读博士学位期间主要科研成果}
  \addcontentsline{toc}{chapter}{攻读博士学位期间主要科研成果}
}{}

\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=black,
  bookmarksnumbered=true,
  plainpages=false,
  hypertexnames=false,
  pdfstartview=FitH
}

\makeatother


% Convenience helpers for bilingual captions and back matter.
\makeatletter
\providecommand{\bicaption}[2]{}
\renewcommand{\bicaption}[2]{%
  \def\sylu@figurecap{figure}%
  \def\sylu@tablecap{table}%
  \ifx\@captype\sylu@figurecap
    \caption[#1]{#1\\{\rmfamily\zihao{5}\linespread{1}\selectfont Fig.\thefigure\space #2}}%
  \else\ifx\@captype\sylu@tablecap
    \caption[#1]{#1\\{\rmfamily\zihao{5}\linespread{1}\selectfont Table \thetable\space #2}}%
  \else
    \caption{#1\\{\rmfamily\zihao{5}\linespread{1}\selectfont #2}}%
  \fi\fi}
\providecommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}}
\providecommand{\upcite}[1]{\textsuperscript{\cite{#1}}}
\newenvironment{resume}{%
  \sylu@specialmajortitle{攻读博士学位期间主要科研成果}
  \addcontentsline{toc}{chapter}{攻读博士学位期间主要科研成果}
}{}
\newcommand{\resumeitem}[1]{\par\vspace{0.5\baselineskip}{\heiti #1}\par}
\newcommand{\researchitem}[1]{\par\vspace{0.5\baselineskip}{\heiti #1}\par}
\newenvironment{projects}{\begin{enumerate}[label=\arabic*.,leftmargin=2em]}{\end{enumerate}}
\newenvironment{honours}{\begin{enumerate}[label=\arabic*.,leftmargin=2em]}{\end{enumerate}}
\makeatother

% Add small spaces around equation references.
% % This version directly uses \ref and avoids corrupting the label argument.
% \makeatletter
% \renewcommand{\eqref}[1]{%
%   \ifmmode
%     \textup{(\ref{#1})}%
%   \else
%     \nobreak\hspace{0.08em}%
%     \textup{(\ref{#1})}%
%     \nobreak\hspace{0.08em}%
%   \fi
% }
% \makeatother
% Add small spaces around \ref and \eqref in Chinese text.
% Keep equation references independent from the redefined \ref to avoid nested spacing.
\makeatletter

\let\sylu@orig@ref\ref

\newcommand{\sylu@spaced@ref}[1]{%
  \ifmmode
    \sylu@orig@ref{#1}%
  \else
    \nobreak\hspace{0.08em}%
    \sylu@orig@ref{#1}%
    \nobreak\hspace{0.08em}%
  \fi
}

\newcommand{\sylu@spaced@refstar}[1]{%
  \ifmmode
    \sylu@orig@ref*{#1}%
  \else
    \nobreak\hspace{0.08em}%
    \sylu@orig@ref*{#1}%
    \nobreak\hspace{0.08em}%
  \fi
}

\renewcommand{\ref}{%
  \@ifstar{\sylu@spaced@refstar}{\sylu@spaced@ref}%
}

\newcommand{\sylu@eqrefmark}[1]{%
  {\sylusong（}{\rmfamily\sylu@orig@ref{#1}}{\sylusong ）}%
}

\renewcommand{\eqref}[1]{%
  \ifmmode
    \textup{\sylu@eqrefmark{#1}}%
  \else
    \nobreak\hspace{0.08em}%
    \mbox{\sylu@eqrefmark{#1}}%
    \nobreak\hspace{-0.37em}%
  \fi
  \ignorespaces
}

\makeatother
\endinput
