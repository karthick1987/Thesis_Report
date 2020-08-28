% Documentation: see template_thesis.tex
% TODO:
%
% - variable toc depth?
% - check compatibility with packages fancyhdr, tocstyle, ... ?
% - date on cover/title pages
% - underfull vboxes when twoside...
%

%
% msvreport.cls
%
% This class defines the official MSV report and thesis style
%

%----------------------------------------------------------------------
% Identify class
%
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{msvreport}%
    [2019/05/09 v0.08.0 %
    msvreport.cls MSV report and thesis class]

%----------------------------------------------------------------------
% Key-Value Options
%
\RequirePackage{kvoptions}%

% a4paper as default (instead of US letterpaper format)
% use same margins for letterpaper (which is similar to a4)
% disable flag banner for formats other than a4paper and letterpaper
\newlength\msvreport@tumlogosize
\setlength\msvreport@tumlogosize{10mm}
\newlength\msvreport@msvlogosize
\setlength\msvreport@msvlogosize{12mm}
\newlength\msvreport@msvlogofontsize
\setlength\msvreport@msvlogofontsize{11pt}
\newlength\msvreport@msvlogobaselineskip
\setlength\msvreport@msvlogobaselineskip{12pt}
\newlength\msvreport@headrulewidth
\setlength\msvreport@headrulewidth{0pt}
\newlength\msvreport@sectionnumsep
\setlength\msvreport@sectionnumsep{2.5mm}

\newif\ifmsvreport@msvlayout
\newif\ifmsvreport@smalltitlefonts

%----------------------------------------------------------------------
% Class options
%
\SetupKeyvalOptions{family=msvreport,prefix=msvreport@}%

\DeclareOption{a4paper}
   {
    \msvreport@msvlayouttrue
    \msvreport@smalltitlefontsfalse
    \PassOptionsToClass{\CurrentOption}{report}
    }
\DeclareOption{a5paper}
   {
    \setlength\msvreport@tumlogosize{8mm}
    \setlength\msvreport@msvlogosize{9mm}
    \setlength\msvreport@msvlogofontsize{8pt}
    \setlength\msvreport@msvlogobaselineskip{9pt}
    \msvreport@smalltitlefontstrue
    \msvreport@msvlayoutfalse
    }
\DeclareOption{b5paper}
   {
    \setlength\msvreport@tumlogosize{8mm}
    \setlength\msvreport@msvlogosize{9mm}
    \setlength\msvreport@msvlogofontsize{8pt}
    \setlength\msvreport@msvlogobaselineskip{9pt}
    \msvreport@smalltitlefontstrue
    \msvreport@msvlayoutfalse
    }

\DeclareOption{letterpaper}
   {
    \msvreport@smalltitlefontsfalse
    \msvreport@msvlayouttrue
    }

\DeclareOption{legalpaper}
   {
    \msvreport@smalltitlefontsfalse
    \msvreport@msvlayoutfalse
    }
\DeclareOption{executivepaper}
   {
    \msvreport@smalltitlefontsfalse
    \msvreport@msvlayoutfalse
    }
\DeclareOption{landscape}
   {
    \setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}
    \msvreport@smalltitlefontsfalse
    \msvreport@msvlayoutfalse
    \PassOptionsToClass{\CurrentOption}{report}
    }

\DeclareOption{openright}{\PassOptionsToClass{\CurrentOption}{report}}
\ExecuteOptions{a4paper,openright}
\newcommand\msvreport@ptsize{1}
\DeclareOption{10pt}{\renewcommand\msvreport@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\msvreport@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\msvreport@ptsize{2}}
\ExecuteOptions{11pt} % make 11pt standard text size

% msvcommon.sty
\PassOptionsToPackage{cmyk}{msvcommon}
\PassOptionsToPackage{hires}{msvcommon}

% msvreport.cls
\DeclareStringOption[color]{titlestyle}%
\DeclareStringOption[none]{coverstyle}%
\DeclareStringOption[none]{copyright}
\DeclareBoolOption[true]{rmheads}
\DeclareBoolOption[true]{widetext}
\DeclareComplementaryOption{narrowtext}{widetext}%
\DeclareComplementaryOption{sfheads}{rmheads}%
\DeclareBoolOption{bluechapters}
\DeclareComplementaryOption{bwchapters}{bluechapters}
\DeclareStringOption[0]{showbinding}% undocumented option
\DeclareBoolOption{eilogo}
\DeclareBoolOption{msvlogo}
\DeclareBoolOption{headrule}
\DeclareBoolOption{chapterprefix}

% Process options
\DeclareOption*{}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions*\relax
\ProcessKeyvalOptions*\relax
%----------------------------------------------------------------------
% Load base class report and required packages
%1
\LoadClass[%
	1\csname msvreport@ptsize \endcsname pt
]{report}
\RequirePackage{geometry}  % Layout
\RequirePackage{ifthen}    % \ifthenelse command
\RequirePackage{etoolbox}  % for \ifstrequal
\RequirePackage{msvcommon} % TUM Colors, Logos, MSV Commands
\RequirePackage{nextpage}  % used to remove page style
                           % at empty pages before chapters
\RequirePackage{graphicx}  % include graphics
\RequirePackage{calc}
\RequirePackage{tikz}
\usetikzlibrary{calc,external} % external: prohibit externalization
                               % of tikz-hlines in header/footer
                               % TODO: better implementation of hlines...
\RequirePackage{titlesec}  % Formatting of the section headings

\ifanypdf
  \RequirePackage{microtype}
\fi

%----------------------------------------------------------------------
% Page geometry
%
% only change a4/letter paper size
% use settings from report class for other paper sizes
%
% a4: 210 x 297 mm
%
% assume binding offset of 5mm (titlepage is different)
%
\linespread{1.1}
\ifmsvreport@msvlayout
    \geometry{%
                    heightrounded,
                    marginparsep=7mm,
                    marginparwidth=28mm,
                    headsep=10mm,
                    headheight=7mm,
                    footskip=10mm
            }
    \if@twoside
        \geometry{%
                    bindingoffset=5mm,
                    hmarginratio=5:8,
                    vmarginratio=4:5,
                    heightrounded }
    \else
        \geometry{%
                    bindingoffset=0mm,
                    hmarginratio=1:1,
                    vmarginratio=4:5,
                    heightrounded }
    \fi

    \isequal{\@ptsize}{0} % 10pt
    \ifequal
        \ifmsvreport@widetext
            \geometry{ textwidth=122mm,
                       textheight=198mm }
        \else
            \geometry{ textwidth=112mm,
                       textheight=182mm }
        \fi
    \fi

    \isequal{\@ptsize}{1} % 11pt
    \ifequal
        \ifmsvreport@widetext
            \geometry{ textwidth=130mm,
                       textheight=195mm }
        \else
            \geometry{ textwidth=120mm,
                       textheight=195mm }
        \fi
    \fi

    \isequal{\@ptsize}{2} % 12pt
    \ifequal
        \ifmsvreport@widetext
            \geometry{ textwidth=144mm,
                       textheight=234mm }
        \else
            \geometry{ textwidth=136mm,
                       textheight=220mm }
        \fi
    \fi
\fi

%----------------------------------------------------------------------
% Page styles
%
% If two-side layout: if page before new chapter does not contain text,
%                     leave blank (no header and footer)
\ifthenelse{\boolean{@twoside}}{%
\renewcommand{\cleardoublepage}{\cleartooddpage[\thispagestyle{empty}]}%
}{%
\renewcommand{\cleardoublepage}{\clearpage}%
}

% headers and footers

\ifmsvreport@headrule
	\setlength{\msvreport@headrulewidth}{1pt}
\else
	\setlength{\msvreport@headrulewidth}{0pt}
\fi


\if@twoside
    \newcommand\ps@report{%
         \newlength\raiseamount
         \setlength\raiseamount{\maxdepth - 1pt}
        \def\@oddhead{\vrule width \hsize height \msvreport@headrulewidth \raise\raiseamount\llap{\small\msvreport@headerfamily\rightmark}}
        \def\@evenhead{\raise\raiseamount\rlap{\small\msvreport@headerfamily\leftmark}\vrule width \hsize height \msvreport@headrulewidth}
        \def\@evenfoot{\msvreport@headsfamily\small\thepage\hfil}
        \def\@oddfoot{\hfil\msvreport@headsfamily\small\thepage}%
        \let\@mkboth\markboth
        \def\chaptermark##1{%
            \markboth {{%\MakeUppercase{%
            \ifnum \c@secnumdepth >\m@ne
                \@chapapp\ \thechapter.\ \,%
            \fi
        ##1}}{}}%
        \def\sectionmark##1{%
            \markright {{%\MakeUppercase{%
            \ifnum \c@secnumdepth >\z@
                \thesection\ \,%
            \fi
        ##1}}}%
    }
\else
    \newcommand\ps@report{%
        % \let\@oddfoot\@empty
        \newlength\raiseamount
        \setlength\raiseamount{\maxdepth - 1pt}
        \def\@oddhead{\vrule width \hsize height \msvreport@headrulewidth \raise\raiseamount\llap{\hbox to \hsize{\hfil\small\msvreport@headerfamily\rightmark\hfil}}}
        \def\@oddfoot{\hfil\msvreport@headsfamily\small\thepage\hfil}%
        \let\@mkboth\markboth
        \def\chaptermark##1{%
            \markright {{%\MakeUppercase{%
            \ifnum \c@secnumdepth >\m@ne
                \@chapapp\ \thechapter.\ \,%
            \fi
        ##1}}}%
    }
\fi
% special layout for opening pages of new chapters
\newcommand\ps@reportchapter{
    \renewcommand\@oddhead{}%
    \renewcommand\@evenhead{}%
    \if@twoside
    \fi
    \renewcommand\@evenfoot{}%
}
% empty headers and footers at title page
\newcommand\ps@reporttitle{
    \renewcommand\@oddhead{}%
    \renewcommand\@evenhead{}%
    \renewcommand\@oddfoot{}%
    \renewcommand\@evenfoot{}%
}

%----------------------------------------------------------------------
% Font style
%
%   only sets font sizes and chooses roman or sans-serif for headings
%
\ifanypdf
    \DeclareMicrotypeSet{roman}{ family = {rm*} }
    \UseMicrotypeSet{roman}
\fi
\newcommand\msvreport@headsfamily{\sffamily}
\newcommand\msvreport@headerfamily{\sffamily\itshape}
\ifmsvreport@rmheads
    \renewcommand\msvreport@headsfamily{\rmfamily}
    \renewcommand\msvreport@headerfamily{\rmfamily\itshape}
\fi
\newcommand\msvreport@chapterfont{\msvreport@headsfamily\Huge}
\newcommand\msvreport@sectionfont{\msvreport@headsfamily\bfseries}
\newcommand\msvreport@subsectionfont{\msvreport@headsfamily\normalsize}
\newcommand\msvreport@subsubsectionfont{\msvreport@headsfamily\normalsize}
\newcommand\msvreport@paragraphfont{\itshape\normalsize}
\newcommand\msvreport@subparagraphfont{\itshape\normalsize}

%----------------------------------------------------------------------
% Define Front and Mainmatter

\RequirePackage{tocbibind}

\newif\if@mainmatter \@mainmattertrue

\newcommand\frontmatter{%
    \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}}
\newcommand\mainmatter{%
    \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}}

%----------------------------------------------------------------------
% Chapter and Section styles
%
%   styles are copied from standard report.cls and then modified
%
\newcommand\msvreport@chaptercolor{\color{black}}
\ifmsvreport@bluechapters
    \renewcommand\msvreport@chaptercolor{\color{TUMDarkerBlue}}
\fi
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{reportchapter}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}

\ifmsvreport@chapterprefix
	\def\@makechapterhead#1{%
	    \vspace*{20\p@}%
		{%
			\parindent \z@ \raggedright \normalfont
			\ifnum \c@secnumdepth >\m@ne
                \msvreport@chapterfont \large{\color{black!50}\@chapapp\space \thechapter}
                \msvreport@chaptercolor
				\par\nobreak
	            % \vskip 20\p@
			\fi
			\interlinepenalty\@M
			\msvreport@chapterfont #1\par\nobreak
			\vskip 40\p@
		}%
	}
\else
	\def\@makechapterhead#1{%
	    \vspace*{20\p@}%
		{%
			\parindent \z@ \raggedleft \normalfont
			\ifnum \c@secnumdepth >\m@ne
				\interlinepenalty\@M
				\msvreport@chapterfont #1\rlap{\hskip5mm
				\begin{minipage}[b][0pt][b]{\textwidth}
				\fontsize{80}{20}\selectfont\color{black!30}\thechapter
				\end{minipage}
				}\par\nobreak
                % \vskip 20\p@
			\else
				\interlinepenalty\@M
				\msvreport@chapterfont #1\par\nobreak
			\fi
			\vskip 40\p@
		}%
	}
\fi

\def\@schapter#1{%
                 \@mkboth{#1}{#1}%
                 \if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
    \vspace*{20\p@}%
    {%
    \parindent \z@ \raggedright
    % \parindent \z@ \raggedleft % TODO: Unnumbered chapter headings left-aligned?
        \normalfont
        \interlinepenalty\@M
        \msvreport@chapterfont #1\par\nobreak
        \vskip 40\p@
    }%
}

\titleformat{\section}
    {\msvreport@sectionfont}
    {\llap{\thesection\hskip\msvreport@sectionnumsep}}{0pt}{}{}
\titleformat{\subsection}
    {\msvreport@subsectionfont}
    {\llap{\thesubsection\hskip\msvreport@sectionnumsep}}{0pt}{}{}
\titleformat{\subsubsection}
    {\msvreport@subsubsectionfont}
    {\llap{\thesubsubsection\hskip\msvreport@sectionnumsep}}{0pt}{}{}

% {name}
% {level}
% {indent} (\z@ = zero)
% {beforeskip}
% {afterskip}
% {style commands}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
    {3.25ex \@plus 1ex \@minus.2ex}%
    {-1em}%
    {\msvreport@paragraphfont}%
}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
    {3.25ex \@plus 1ex \@minus .2ex}%
    {-1em}%
    {\msvreport@subparagraphfont}%
}

%----------------------------------------------------------------------
% Table of contents
%
%   also copied from report.cls and modified
% 
\setcounter{tocdepth}{2}
\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname}%
    %\@mkboth{\contentsname}{\contentsname}%
    {\msvreport@headsfamily%
    \@starttoc{toc}%
    }%
    \if@restonecol\twocolumn\fi
}
\renewcommand*\l@part[2]{%
    \ifnum \c@tocdepth >-2\relax
        \addpenalty{-\@highpenalty}%
        \addvspace{2.25em \@plus\p@}%
        \setlength\@tempdima{3em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            {\leavevmode\bfseries\Large #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
%            {\leavevmode\large #1\hspace{1em}#2}\par
            \nobreak
            \global\@nobreaktrue
            \everypar{\global\@nobreakfalse\everypar{}}%
        \endgroup
    \fi%
}
\renewcommand*\l@chapter[2]{%
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \vskip 1.0em \@plus\p@
        \setlength\@tempdima{1.5em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            %\color{TUMDarkerBlue}
            \bfseries#1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
%            #1\hspace{1em}#2\hfil\ \par
%            #1\hspace{1em}#2
            \penalty\@highpenalty
        \endgroup
    \fi%
}
\renewcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

\renewcommand\@tocrmarg{3.5em}
\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \vskip \z@ \@plus.2\p@
    {\leftskip #2\relax \rightskip \@tocrmarg \advance\rightskip by 0pt plus 2cm
               \parfillskip -\rightskip \pretolerance=10000
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     {#4}\nobreak
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
%     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \hb@xt@\@pnumwidth{\hfil\msvreport@headsfamily \normalcolor #5}%
     \par}%
\fi}

%----------------------------------------------------------------------
% Bibliography environment
%
\setcounter{secnumdepth}{3}
\setlength\bibindent{1.5em}
\renewenvironment{thebibliography}[1]{%
    \chapter*{\bibname}%
    %\@mkboth{\bibname}{\bibname}%
    \list{\@biblabel{\@arabic\c@enumiv}}%
         {\settowidth\labelwidth{\@biblabel{#1}}%
          \leftmargin\labelwidth
          \advance\leftmargin\labelsep
          \@openbib@code
          \usecounter{enumiv}%
          \let\p@enumiv\@empty
          \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m%
}{%
    \def\@noitemerr
     {\@latex@warning{Empty `thebibliography' environment}}%
    \endlist%
}


%----------------------------------------------------------------------
% Abstract
%
\renewenvironment{abstract}{%
    \thispagestyle{empty}
    \chapter*{\abstractname}
   % \@beginparpenalty\@lowpenalty
   % \begin{center}%
   %   \msvreport@sectionfont \abstractname
   %   \@endparpenalty\@M
   % \end{center}%
    }
    {\par\vfil\null}


%----------------------------------------------------------------------
% Title pages
%
\newcommand\msvreport@titlerunning{\@title}
\newcommand\titlerunning[1]{\renewcommand\msvreport@titlerunning{#1}}
\newcommand\msvreport@doctype{}
\newcommand\msvdoctype[1]{\renewcommand\msvreport@doctype{#1}}
\newcommand\msvreport@covertext{}
\newcommand\msvcovertext[1]{\renewcommand\msvreport@covertext{#1}}
\ifmsvreport@msvlayout
\else
    \ifthenelse{\equal{\msvreport@titlestyle}{flags}}{\renewcommand*\msvreport@titlestyle{banner}}{}
    \ifthenelse{\equal{\msvreport@titlestyle}{flags}}{\renewcommand*\msvreport@coverstyle{banner}}{}
\fi

\newcommand*\msvreport@style{\msvreport@coverstyle}
\newcommand*\msvreport@@showbinding{\msvreport@showbinding}

\ifmsvreport@smalltitlefonts
    \newcommand*\msvreport@titlefont{\LARGE\bfseries\selectfont}
    \newcommand*\msvreport@subtitlefont{\large\bfseries\selectfont}
    \newcommand*\msvreport@authorfont{\large\selectfont}
    \newcommand*\msvreport@footerfont{\footnotesize\selectfont}
\else
    \newcommand*\msvreport@titlefont{\fontsize{20}{20}\bfseries\selectfont}
    \newcommand*\msvreport@subtitlefont{\fontsize{14}{14}\bfseries\selectfont}
    \newcommand*\msvreport@authorfont{\fontsize{14}{16}\selectfont}
    \newcommand*\msvreport@footerfont{\fontsize{11}{11}\selectfont}
\fi

% disable banner with flags for layouts other than a4


\renewenvironment{titlepage}{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse\newpage
    \fi
    \thispagestyle{reporttitle}%
    \setcounter{page}\@ne
}{%
    \if@restonecol
        \twocolumn
    \else
        \newpage
    \fi
    % \if@twoside
    % \else
    %     \setcounter{page}\@ne
    % \fi
}

\renewcommand\maketitle{%
% Klebebindung: ca. 11mm
% Ringelbindung: ca. 8mm
    \if@twoside
        \newgeometry{   %showframe=false,
                        bindingoffset=11mm,
                        hmargin={7mm,12mm}, % left right
                        vmargin={13mm,16mm},  % top bottom
                        nohead, nofoot,
                        marginparsep=0pt,
                        marginparwidth=0pt,
                        footskip=0pt
                    }
    \else
        \newgeometry{   %showframe=false,
                        bindingoffset=0mm,
                        hmargin={15mm,15mm}, % left right
                        vmargin={20mm,20mm},  % top bottom
                        nohead, nofoot,
                        marginparsep=0pt,
                        marginparwidth=0pt,
                        footskip=0pt
                    }
    \fi

    \ifthenelse{\equal{\msvreport@coverstyle}{none}}{}
      {\renewcommand{\thepage}{\Roman{page}}\maketitlepage
        \ifthenelse{\equal{\msvreport@copyright}{cover}}
          {\clearpage \thispagestyle{empty} \null\vfill\MSVcopyright
           \clearpage}
          {\cleardoublepage}
      \renewcommand{\thepage}{\arabic{page}}}

    \renewcommand*\msvreport@style{\msvreport@titlestyle}
    \renewcommand*\msvreport@@showbinding{0}

    \ifthenelse{\equal{\msvreport@titlestyle}{none}}{}
      {\maketitlepage
        \ifthenelse{\equal{\msvreport@copyright}{title}}
          {\clearpage \thispagestyle{empty} \null\vfill\MSVcopyright
           \clearpage}
          {\cleardoublepage}}

    \setcounter{footnote}{0}%
    \global\let\thanks\relax
    \global\let\maketitle\relax
    % \global\let\@thanks\@empty
    % \global\let\@author\@empty
    % \global\let\@date\@empty
    % \global\let\@title\@empty
    % \global\let\title\relax
    % \global\let\author\relax
    % \global\let\date\relax
    % \global\let\and\relax
    \restoregeometry
}

\newcommand\maketitlepage{%
{\tikzexternaldisable
\begin{titlepage}%
\let\footnoterule\relax%
\let \footnote \thanks%
        \sffamily%
        \fontsize{12}{14}%
        \selectfont%
        \setlength\parindent{0mm}%
        \begin{tikzpicture}[x=\textwidth,y=3\msvreport@tumlogosize,inner sep=0pt,outer sep=0pt]
        \path[use as bounding box] (0,0) -- (1,1);

        % Show area lost by adhesive binding
        \ifthenelse{\equal{\msvreport@@showbinding}{0}}{
        }{
            \fill[black] ($(-18mm,1)+(0,13mm)$) rectangle ($(-18mm,-254mm)+(\msvreport@@showbinding,0)$);
        }

        % Select Title
        \ifthenelse{\equal{\msvreport@style}{flags}}{
            \node [anchor=south west] at (-7mm,0) {\TUMbanner{30mm}};
        }{}

        \ifthenelse{\equal{\msvreport@style}{banner}}{
            \fill[shading=axis,left color=TUMLighterBlue!55,right color=TUMMediumBlue] ($(0,0)-(7mm,0)$) rectangle ($(1,1)+(7mm,0)$);
            \node (tumlogo) at ($(1,1) - (0,7mm)$) [anchor=north east] {\TUMlogo{height=\msvreport@tumlogosize,color=white}};
            \node at ($(tumlogo.south east) - (0,3.0mm)$) [anchor=north east] {\color{white}\fontsize{10}{10}\selectfont\TUMname};
        }{}

        \ifthenelse{\equal{\msvreport@style}{bw}}{
            \node (tumlogo) at ($(1,1) - (0,7mm)$) [anchor=north east] {\TUMlogo{height=\msvreport@tumlogosize,color=black,shape=outline}};
            \node at ($(tumlogo.south east) - (0,3.0mm)$) [anchor=north east] {\color{black}\fontsize{10}{10}\selectfont\TUMname};
        }{}

        \ifthenelse{\equal{\msvreport@style}{color}}{
            \node (tumlogo) at ($(1,1) - (0,7mm)$) [anchor=north east] {\TUMlogo{height=\msvreport@tumlogosize}};
            \node at ($(tumlogo.south east) - (0,3.0mm)$) [anchor=north east] {\color{TUMBlue}\fontsize{10}{10}\selectfont\TUMname};
        }{}

        \end{tikzpicture}
        \vskip0.21\textheight
        {\msvreport@titlefont\@title\par}%
        \vskip2em%
        {\msvreport@subtitlefont
         \msvreport@doctype\par}
        \vskip1.5em
        {\msvreport@authorfont\@author \par}
        \vfill
        {\msvreport@authorfont
        \msvreport@covertext
        }
        \ifmsvreport@msvlayout
            \vskip6em%
        \else
            \vskip3em%
        \fi
{\msvreport@footerfont%
\ifthenelse{\equal{\msvreport@style}{bw}}%
{%
\vskip 0.5\msvreport@msvlogosize\vskip 0.252mm
\noindent%
\rlap{\ifmsvreport@eilogo\EIlogo{height=\msvreport@msvlogosize,color=black}\fi}%
\ifmsvreport@eilogo\ifmsvreport@msvlogo\else\hspace{1.4\msvreport@msvlogosize}\fi\fi%
\vbox{\fontsize{\msvreport@msvlogofontsize}{\msvreport@msvlogobaselineskip}\selectfont\ifmsvreport@eilogo\ifmsvreport@msvlogo\centering\fi\fi\EIname\\\MSVname\\\MSVhead}%
\llap{\ifmsvreport@msvlogo\MSVlogo{height=\msvreport@msvlogosize,color=black}\fi}%
}{%
{\color{TUMMediumBlue}\hrule height 0.252mm\vskip 0.5\msvreport@msvlogosize}%
\noindent%
\rlap{\ifmsvreport@eilogo\EIlogo{height=\msvreport@msvlogosize}\fi}%
%\hbox to 0pt {\vbox{\hrule width \hsize}}% show baseline
%\raise\msvreport@msvlogosize\hbox to 0pt {\vbox{\hrule width \hsize}}% show upper boundary of logo
\ifmsvreport@eilogo\ifmsvreport@msvlogo\else\hspace{1.4\msvreport@msvlogosize}\fi\fi%
\vbox{\fontsize{\msvreport@msvlogofontsize}{\msvreport@msvlogobaselineskip}\selectfont\ifmsvreport@eilogo\ifmsvreport@msvlogo\centering\fi\fi\EIname\\\MSVname\\\MSVhead}%
\llap{\ifmsvreport@msvlogo\MSVlogo{height=\msvreport@msvlogosize}\fi}%
}
}%
\end{titlepage}%
}}


% set pagestyle according to \ps@report commands
\pagestyle{report}
