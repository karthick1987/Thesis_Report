%
% msvbeamer.cls
%
% This class defines the official MSV beamer presentation style
%

%----------------------------------------------------------------------
% Identify class
%
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{msvbeamer}%
    [2013/06/25 v0.06.1 %
    msvbeamer.cls MSV presentation class based on beamer.cls]

%----------------------------------------------------------------------
% Class options
%
\RequirePackage{kvoptions}%
\SetupKeyvalOptions{family=msvbeamer,prefix=msvbeamer@}%
% msvcommon.sty
\DeclareVoidOption{ngerman}{\PassOptionsToPackage{ngerman}{msvcommon}}%
\DeclareVoidOption{german}{\PassOptionsToPackage{german}{msvcommon}}%
\DeclareBoolOption[false]{cmyk}%
\DeclareComplementaryOption{rgb}{cmyk}%
\DeclareVoidOption{print}{\msvbeamer@cmyktrue}%
% msvbeamer.cls
\DeclareBoolOption{smooth}
\DeclareBoolOption{bold}
\DeclareBoolOption{colorblock}
\DeclareBoolOption{blocktitle}
\DeclareStringOption[TUMDarkerBlue]{basecolor}
% Default option -- this seems not to work anyway!
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{beamer}}%
\ProcessKeyvalOptions*\relax
% pass non-void options to packages

%----------------------------------------------------------------------
% Load base class beamer and required packages
%
\LoadClassWithOptions{beamer}
\RequirePackage{msvcommon}

%----------------------------------------------------------------------
% Fonts
%
\renewcommand\rmdefault{qtm}
\renewcommand\sfdefault{qhv}
\renewcommand\ttdefault{qcr}


%----------------------------------------------------------------------
% File encoding utf8x
%
\ifxetexorluatex
\else
  \RequirePackage{ucs}
  \RequirePackage[utf8x]{inputenc}
\fi

%----------------------------------------------------------------------
% Configure beamer templates
%
\beamertemplatenavigationsymbolsempty
\usetheme{default}
\usefonttheme{professionalfonts}
\setbeamerfont{footnote}{size=\tiny}
\setlength{\footnotesep}{0pt}
\ifmsvbeamer@bold
    \setbeamerfont{frametitle}{series=\bfseries}
    \setbeamerfont{title}{series=\bfseries}
    \setbeamerfont{block title}{size={},series={\bfseries}}%
\else
    \setbeamerfont{block title}{size={}}%
\fi
\ifmsvbeamer@smooth
    \newcommand{\msvbeamersep}{\hskip3pt~$\cdot$\hskip3pt}
    \setbeamertemplate{items}[circle]
    \setbeamertemplate{blocks}[rounded]
\else
    \newcommand{\msvbeamersep}{\hskip3pt--\hskip3pt}
    \setbeamertemplate{items}[triangle]
    \setbeamertemplate{blocks}[default]
\fi
\setbeamercolor{normal text}{fg=TUMBlack,bg=TUMWhite}
\setbeamercolor{alerted text}{fg=TUMBeamerRed,bg=TUMWhite}
\setbeamercolor{example text}{fg=TUMBeamerGreen,bg=TUMWhite}
\setbeamercolor{frametitle}{fg=\msvbeamer@basecolor,bg=TUMWhite}
\setbeamercolor{structure}{fg=\msvbeamer@basecolor,bg=TUMWhite}
\ifmsvbeamer@colorblock
    \setbeamercolor{block title}{fg=\msvbeamer@basecolor,bg=\msvbeamer@basecolor!7!TUMWhite}%
    \setbeamercolor{block body}{fg=TUMBlack,bg=\msvbeamer@basecolor!7!TUMWhite}%
    \setbeamercolor{block title example}{fg=TUMBeamerGreen,bg=\msvbeamer@basecolor!7!TUMWhite}%
    \setbeamercolor{block body example}{fg=TUMBlack,bg=\msvbeamer@basecolor!7!TUMWhite}%
    \setbeamercolor{block title alerted}{fg=TUMBeamerRed,bg=\msvbeamer@basecolor!7!TUMWhite}%
    \setbeamercolor{block body alerted}{fg=TUMBlack,bg=\msvbeamer@basecolor!7!TUMWhite}%
\else
    \setbeamercolor{block title}{fg=\msvbeamer@basecolor,bg=\msvbeamer@basecolor}%
    \setbeamercolor{block body}{fg=TUMBlack,bg=TUMWhite}%
    \setbeamercolor{block title example}{fg=TUMBeamerGreen,bg=TUMBeamerGreen}%
    \setbeamercolor{block body example}{fg=TUMBlack,bg=TUMWhite}%
    \setbeamercolor{block title alerted}{fg=TUMBeamerRed,bg=TUMBeamerRed}%
    \setbeamercolor{block body alerted}{fg=TUMBlack,bg=TUMWhite}%
\fi

%----------------------------------------------------------------------
% Define some MSV headline and footline templates
%
% headline templates:
%   no              nothing
%   fancy           msv logo left, tum logo right, line
%   fancynoline     msv logo left, tum logo right, no line
%
% footline templates:
%   no              nothing
%   minimal         frame number, no line
%   tum             tum foot, no line
%   tumline         tum foot with line
%   tummsv          tum -- msv foot, no line
%   tummsvline      tum -- msv foot, line
%   fancy           date, author, frame foot, line
%   fancyempty      empty foot, line
%   tummsvlogos     msv logo left, tum logo right, no line
%
\defbeamertemplate*{headline}{no}{}
\defbeamertemplate*{footline}{no}{}
\defbeamertemplate*{footline}{minimal}{%
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[wd=1.0\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \insertframenumber%
        \end{beamercolorbox}%
    }%
    \vskip 0pt%
}
\defbeamertemplate*{footline}{tum}{%
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm]{structure}%
            \relax% do nothing
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.90\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \TUMname%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \insertframenumber%
        \end{beamercolorbox}%
    }%
    \vskip 0pt%
}
\defbeamertemplate*{footline}{msv}{%
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm]{structure}%
            \relax% do nothing
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.90\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \TUMname\msvbeamersep\MSVname%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \insertframenumber%
        \end{beamercolorbox}%
    }%
    \vskip 0pt%
}
\defbeamertemplate*{footline}{tumline}{%
    \leavevmode%
    {\usebeamercolor[fg]{structure}\hrule height 0.5pt}%
    \vskip 1pt%
    \hbox{%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm]{structure}%
            \relax% do nothing
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.90\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \TUMname%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \insertframenumber%
        \end{beamercolorbox}%
    }%
    \vskip 0pt%
}
\defbeamertemplate*{footline}{msvline}{%
    \leavevmode%
    {\usebeamercolor[fg]{structure}\hrule height 0.5pt}%
    \vskip 1pt%
    \hbox{%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm]{structure}%
            \relax% do nothing
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.90\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \TUMname\msvbeamersep\MSVname%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \insertframenumber%
        \end{beamercolorbox}%
    }%
    \vskip 0pt%
}
\defbeamertemplate*{headline}{fancy}{%
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[wd=.5\paperwidth,ht=5mm,dp=1mm]{structure}%
            \hskip 2pt%
            \MSVlogo{height=4.5mm,color=TUMBlue}%
            \hskip 2pt%
            \textcolor{TUMBlue}{\fontsize{4.5pt}{4.5pt}\selectfont\MSVname}%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.5\paperwidth,ht=5mm,dp=1mm,right]{structure}%
            \textcolor{TUMBlue}{\fontsize{4.5pt}{4.5pt}\selectfont\TUMname}%
            \hskip 2pt%
            \TUMlogo{height=4.5mm,color=TUMBlue}%
            \hskip 2pt\mbox{}%
        \end{beamercolorbox}%
    }%
    {\usebeamercolor[fg]{structure}\hrule height 0.5pt}%
    \vskip 0.5pt%
    \vskip 0pt%
}
\defbeamertemplate*{footline}{fancy}{%
    \leavevmode%
    {\usebeamercolor[fg]{structure}\hrule height 0.5pt}%
    \vskip 1pt%
    \hbox{%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm]{structure}%
            \relax% do nothing
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.90\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \insertshortdate\msvbeamersep%
            \insertshortauthor\msvbeamersep%
            \insertshorttitle%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \insertframenumber%
        \end{beamercolorbox}%
    }%
    \vskip 0pt%
}
\defbeamertemplate*{headline}{fancynoline}{%
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[wd=.5\paperwidth,ht=5mm,dp=1mm]{structure}%
            \hskip 2pt%
            \MSVlogo{height=4.5mm,color=TUMBlue}%
            \hskip 2pt%
            \textcolor{TUMBlue}{\fontsize{4.5pt}{4.5pt}\selectfont\MSVname}%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.5\paperwidth,ht=5mm,dp=1mm,right]{structure}%
            \textcolor{TUMBlue}{\fontsize{4.5pt}{4.5pt}\selectfont\TUMname}%
            \hskip 2pt%
            \TUMlogo{height=4.5mm,color=TUMBlue}%
            \hskip 2pt\mbox{}%
        \end{beamercolorbox}%
    }%
    \vskip 0pt%
}
\defbeamertemplate*{footline}{fancyempty}{%
    \leavevmode%
    {\usebeamercolor[fg]{structure}\hrule height 0.5pt}%
    \vskip 1pt%
    \hbox{%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm]{structure}%
            \relax% do nothing
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.90\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \phantom{%
                \insertshortdate\msvbeamersep%
                \insertshortauthor\msvbeamersep%
                \insertshorttitle%
            }%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.05\paperwidth,ht=2mm,dp=1mm,center]{structure}%
            \phantom{\insertframenumber}%
        \end{beamercolorbox}%
    }%
    \vskip 0pt%
}
\defbeamertemplate*{footline}{tummsvlogos}{%
    \leavevmode%
    \hbox{%
        \begin{beamercolorbox}[wd=.5\paperwidth,ht=2mm,dp=1mm]{structure}%
            \hskip 2pt%
            \MSVlogo{height=4.5mm,color=TUMBlue}%
            \hskip 2pt%
            \textcolor{TUMBlue}{\fontsize{4.5pt}{4.5pt}\selectfont\MSVname}%
        \end{beamercolorbox}%
        \begin{beamercolorbox}[wd=.5\paperwidth,ht=2mm,dp=1mm,right]{structure}%
            \textcolor{TUMBlue}{\fontsize{4.5pt}{4.5pt}\selectfont\TUMname}%
            \hskip 2pt%
            \TUMlogo{height=4.5mm,color=TUMBlue}%
            \hskip 2pt\mbox{}%
        \end{beamercolorbox}%
    }%
    \vskip 0pt%
}

%----------------------------------------------------------------------
% Define msvblock environment
%
\definecolor{msvbeamer@block@titlecolor}{named}{TUMBlack}
\definecolor{msvbeamer@block@textcolor}{named}{TUMBlack}
\definecolor{msvbeamer@block@rulecolor}{named}{TUMBlack}
\definecolor{msvbeamer@block@bgcolor}{named}{TUMWhite}
\newlength{\msvbeamer@block@rule}\setlength{\msvbeamer@block@rule}{1pt}
\newlength{\msvbeamer@block@sep}\setlength{\msvbeamer@block@sep}{7pt}
\newlength{\msvbeamer@block@titlesep}\setlength{\msvbeamer@block@titlesep}{0pt}
\newlength{\msvbeamer@block@textwidth}
\newsavebox{\msvbeamer@block@content}
\newenvironment{msvbeamer@block}[1]{%
    \setlength{\fboxrule}{\msvbeamer@block@rule}%
    \setlength{\fboxsep}{\msvbeamer@block@sep}%
    \setlength{\msvbeamer@block@textwidth}{\textwidth}%
    \addtolength{\msvbeamer@block@textwidth}{-2\msvbeamer@block@rule}%
    \addtolength{\msvbeamer@block@textwidth}{-2\msvbeamer@block@sep}%
    \begin{lrbox}{\msvbeamer@block@content}%
        \hbox\bgroup\begin{minipage}{\msvbeamer@block@textwidth}\begin{flushleft}%
        \vskip 0pt%
        \isempty{#1}%
        \ifempty
        \vskip 0pt%
        \else%
            {\usebeamerfont*{block title}\color{msvbeamer@block@titlecolor}#1}\vskip\msvbeamer@block@titlesep%
        \fi%
        \color{msvbeamer@block@textcolor}%
}{%
    %\vskip -4pt \vskip 4pt%
    \end{flushleft}\end{minipage}\egroup\end{lrbox}%
    % draw the whole thing
    \ifmsvbeamer@colorblock
        \colorbox{msvbeamer@block@bgcolor}{\usebox{\msvbeamer@block@content}}%
    \else
        \fcolorbox{msvbeamer@block@rulecolor}{msvbeamer@block@bgcolor}{\usebox{\msvbeamer@block@content}}%
    \fi
}
\renewenvironment{block}[1]{%
    \usebeamercolor{block title}
    \definecolor{msvbeamer@block@titlecolor}{named}{fg}%
    \definecolor{msvbeamer@block@rulecolor}{named}{bg}%
    \usebeamercolor{block body}
    \definecolor{msvbeamer@block@textcolor}{named}{fg}%
    \definecolor{msvbeamer@block@bgcolor}{named}{bg}%
    \begin{msvbeamer@block}{#1}%
}{%
    \end{msvbeamer@block}%
}%
\renewenvironment{exampleblock}[1]{%
    \usebeamercolor{block title example}
    \definecolor{msvbeamer@block@titlecolor}{named}{fg}%
    \definecolor{msvbeamer@block@rulecolor}{named}{bg}%
    \usebeamercolor{block body example}
    \definecolor{msvbeamer@block@textcolor}{named}{fg}%
    \definecolor{msvbeamer@block@bgcolor}{named}{bg}%
    \begin{msvbeamer@block}{#1}%
}{%
    \end{msvbeamer@block}%
}%
\renewenvironment{alertblock}[1]{%
    \usebeamercolor{block title alerted}
    \definecolor{msvbeamer@block@titlecolor}{named}{fg}%
    \definecolor{msvbeamer@block@rulecolor}{named}{bg}%
    \usebeamercolor{block body alerted}
    \definecolor{msvbeamer@block@textcolor}{named}{fg}%
    \definecolor{msvbeamer@block@bgcolor}{named}{bg}%
    \begin{msvbeamer@block}{#1}%
}{%
    \end{msvbeamer@block}%
}%

