%
% msvposter.cls
%
% This class defines the official MSV poster style
%

%----------------------------------------------------------------------
% Identify class
%
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{msvposter2}%
    [2017/03/09 v1.1 %
    msvposter.cls MSV poster class based on beamerposter.sty]

%----------------------------------------------------------------------
% Class options
%
\newcommand\msvposter@size{a0}
\newcommand\msvposter@columns{2}

\RequirePackage{kvoptions}%
\SetupKeyvalOptions{family=msvposter,prefix=msvposter@}%

% msvposter.cls
\DeclareVoidOption{1col}{\renewcommand\msvposter@columns{1}}%
\DeclareVoidOption{2col}{\renewcommand\msvposter@columns{2}}%
\DeclareVoidOption{3col}{\renewcommand\msvposter@columns{3}}%
\DeclareVoidOption{4col}{\renewcommand\msvposter@columns{4}}%
\DeclareVoidOption{5col}{\renewcommand\msvposter@columns{5}}%

\DeclareBoolOption{landscape}
\DeclareComplementaryOption{portrait}{landscape}

\DeclareVoidOption{a0}{\renewcommand\msvposter@size{a0}}%
\DeclareVoidOption{a1}{\renewcommand\msvposter@size{a1}}%
\DeclareVoidOption{a2}{\renewcommand\msvposter@size{a2}}%
\DeclareVoidOption{a3}{\renewcommand\msvposter@size{a3}}%
\DeclareVoidOption{a4}{\renewcommand\msvposter@size{a4}}%

\DeclareStringOption[1.3]{fontscale}[1.3]

% box-related options
\DeclareBoolOption{boxrule}%
\DeclareStringOption[30pt]{boxarc}
\DeclareVoidOption{rounded}{\renewcommand\msvposter@boxarc{30pt}} % only works with pstricks
\DeclareVoidOption{rectangular}{\renewcommand\msvposter@boxarc{0pt}}
\DeclareBoolOption[false]{pstricks}
\DeclareComplementaryOption{nopstricks}{pstricks}


% Process options
\ProcessKeyvalOptions*\relax
\PassOptionsToPackage{cmyk}{msvcommon}
\PassOptionsToPackage{print}{msvcommon}

%----------------------------------------------------------------------
% Load base class beamer and required packages
%

\newcommand\msvposter@orientation{portrait}
\ifmsvposter@landscape
    \renewcommand\msvposter@orientation{landscape}
\fi

\LoadClassWithOptions{beamer}
\RequirePackage{msvcommon}
\RequirePackage[size=\msvposter@size,orientation=\msvposter@orientation,scale=\msvposter@fontscale]{beamerposter}


%----------------------------------------------------------------------
% Affiliation
%
\newcommand\msvposter@affiliationA{\MSVname}
\newcommand\msvposter@affiliationB{\TUMname}
\newcommand\affiliationA[1]{\renewcommand\msvposter@affiliationA{#1}}
\newcommand\affiliationB[1]{\renewcommand\msvposter@affiliationB{#1}}

%----------------------------------------------------------------------
% Geometry and lengths
%

% Margins
\newlength\posteroutermargin
\newlength\posterheadsep
\setlength\posteroutermargin{46mm}
\setlength\posterheadsep{2cm}

\geometry{
  paperwidth=\the\paperwidth,%
  paperheight=\the\paperheight,%
  hmargin=\posteroutermargin,%
  vmargin=0cm,%
  head=0cm,%
  headsep=0pt,%
  foot=0cm%
}

% Columns
\newlength\postercolumnsep
\newlength\postercolumnwidth
\newlength\postercolumnheight
\setlength\postercolumnsep{0.75cm}

% posterheadbox geometry (this is the box with the title etc.)
\newlength\posterheadboxheight
\setlength\posterheadboxheight{12cm}
\newlength\logoheight%
\setlength\logoheight{46mm}%

% posterbox geometry
\newlength\posterboxwidth
\newlength\posterboxrule
\newlength\posterboxsep
\setlength\posterboxrule{2pt}
\setlength\posterboxsep{30pt}
\newlength\posterboxarc % pstricks only
\setlength\posterboxarc{\msvposter@boxarc} % pstricks only


\setlength{\footnotesep}{0pt}

%----------------------------------------------------------------------
% Colors and font sizes (can be overriden in preamble)
%
\colorlet{msvposter@bgcolor}{TUMWhite} % background color
\usetheme{default}
\mode<all>
\beamertemplatenavigationsymbolsempty

% Color theme
\newcommand\msvposter@basecolor{TUMDarkerBlue}
\newcommand\msvposter@secondarycolor{TUMBlue} % Color for TUM Logo

% Font type
\usefonttheme{professionalfonts} % do not mess with fonts
\RequirePackage[scaled]{helvet}

% Headbox
\setbeamerfont{title}{size*={78pt}{82pt},series=\bfseries}
\setbeamerfont{author}{size=\Large}
\setbeamercolor{author}{fg=\msvposter@secondarycolor}
\setbeamerfont{affiliation}{size=\normalfont}
\setbeamercolor{affiliation}{fg=\msvposter@secondarycolor}

% Fonts
\setbeamerfont{block title}{size=\Large,series=\bfseries}%
\setbeamerfont{footnote}{size=\tiny}

% Colors
\setbeamercolor*{normal text}{fg=TUMBlack}
\setbeamercolor{alerted text}{fg=TUMOrange,bg=TUMWhite}
\setbeamercolor{example text}{fg=TUMGreen,bg=TUMWhite}
\setbeamercolor{structure}{fg=\msvposter@basecolor,bg=TUMWhite}

% Lists
\setbeamercolor{itemize item}{fg=black}
\setbeamercolor{itemize subitem}{fg=black}
\setbeamerfont{itemize/enumerate subbody}{size=\normalsize}
\setbeamertemplate{itemize items}{\raise0.3ex\hbox{\tiny$\bullet$}}
\setbeamertemplate{itemize subitem}{\color{black}\small$-$}
\setbeamercolor{enumerate item}{fg=black}

% Boxes
\colorlet{msvposter@boxrulecolor}{\msvposter@basecolor}


%----------------------------------------------------------------------
% Define poster environment
%
\newenvironment{poster}{%
    \pagecolor{msvposter@bgcolor}%
    \begin{frame}[t]{}%

    % should read: calculate logo height based on poster size and TUM
    % style guide
    % currently: just set the logo height to something smaller
    \isequal{\msvposter@size}{a1}\ifequal\setlength\logoheight{34mm}\fi%
    \isequal{\msvposter@size}{a2}\ifequal\setlength\logoheight{26mm}\fi%
    \isequal{\msvposter@size}{a3}\ifequal\setlength\logoheight{20mm}\fi%
    \isequal{\msvposter@size}{a4}\ifequal\setlength\logoheight{16mm}\fi%

    % calculate postercolumnwidth
    \setlength\postercolumnwidth{\textwidth}%
    \isequal{\msvposter@columns}{2}
      \ifequal\addtolength\postercolumnwidth{-\postercolumnsep}\setlength\postercolumnwidth{0.5\postercolumnwidth}\fi%
    \isequal{\msvposter@columns}{3}%
      \ifequal\addtolength\postercolumnwidth{-2\postercolumnsep}\setlength\postercolumnwidth{0.3333\postercolumnwidth}\fi%
    \isequal{\msvposter@columns}{4}%
      \ifequal\addtolength\postercolumnwidth{-3\postercolumnsep}\setlength\postercolumnwidth{0.25\postercolumnwidth}\fi%
    \isequal{\msvposter@columns}{5}%
      \ifequal\addtolength\postercolumnwidth{-4\postercolumnsep}\setlength\postercolumnwidth{0.2\postercolumnwidth}\fi%

    % calculate postercolumnheight
    \setlength\postercolumnheight{\paperheight}%

    \addtolength\postercolumnheight{-2\posteroutermargin}%
    \addtolength\postercolumnheight{-\posterheadboxheight}%
    \addtolength\postercolumnheight{-\posterheadsep}%

    % typeset posterheadbox
    \msvpostertitle%
}{%
    \end{frame}%
}

%----------------------------------------------------------------------
% Poster head
%
\newcommand{\msvpostertitle}{%
 \setlength\parindent{0mm}%
  \vskip\posteroutermargin%
  \begin{tikzpicture}[x=\textwidth,y=1\logoheight,inner sep=0pt,outer sep=0pt]
    \path[use as bounding box] (0,0) -- (1,1);
%    \draw (0,0) rectangle (1,1); % check spacings
    \node (author) at (0,1) [anchor=north west,\msvposter@secondarycolor] {\usebeamerfont{author}\insertauthor};
    \node (lehrstuhl) at (0,0.38) [anchor=west,\msvposter@secondarycolor] {\usebeamerfont{affiliation}\msvposter@affiliationA};
    \node (faculty) at (0,0) [anchor=south west,\msvposter@secondarycolor] {\usebeamerfont{affiliation}\msvposter@affiliationB};
    \node (tumlogo) at ($(1,1) - (0,0mm)$) [anchor=north east] {\TUMlogo{height=\logoheight,color=\msvposter@secondarycolor}};
    \node at ($(tumlogo.south east) - (0,3.0mm)$) [anchor=north east] {\color{white}\fontsize{10}{10}\selectfont\TUMname};
  \end{tikzpicture}
  \vskip\posterheadsep
%  \begin{center}{\usebeamerfont{title}\par\inserttitle\par}\end{center}
  {\usebeamerfont{title}\par\inserttitle\par} % \par necessary for baselineskips
  \vskip\posterheadsep
}

%----------------------------------------------------------------------
% Define postercolumn environment
%
\newenvironment{postercolumn}{%
    \begin{minipage}[t][\postercolumnheight][c]{\postercolumnwidth}%
}{%
    %\removelastskip % minipage seems to do this anyway
    \end{minipage}%
}


%----------------------------------------------------------------------
% Box commands
%

% internal msvposterbox environment
\newcommand{\msvposterbox}[1]{%
      \setlength\fboxsep{\posterboxsep}%
      \setlength\fboxrule{\posterboxrule}%
      \makeatother
      \fcolorbox{msvposter@boxrulecolor}{TUMWhite}{#1}%
      \makeatletter}
\ifmsvposter@pstricks
  \renewcommand{\msvposterbox}[1]{%
      \makeatother
      \psframebox[cornersize=absolute,
         linewidth=\posterboxrule,
         linearc=\posterboxarc,
         linecolor=msvposter@boxrulecolor,
         fillstyle=solid,
         fillcolor=TUMWhite,
         framesep=\posterboxsep,
         dimen=outer]{#1}%
       \makeatletter}
\fi

% posterbox environment (use this!)
\newcounter{posterbox}
\setcounter{posterbox}{0}
\newsavebox{\posterboxcontent}
\newenvironment{posterbox}[1]{%
    \leavevmode
    \addtocounter{posterbox}{1}%
    \setlength\posterboxwidth{\textwidth}%
    \addtolength\posterboxwidth{-2\posterboxsep}%
    \addtolength\posterboxwidth{-2\posterboxrule}%
    \begin{lrbox}{\posterboxcontent}%
        \begin{minipage}[t]{\posterboxwidth}%
            \begin{center}%
                {$\phantom{\text{\arabic{posterbox}}}$\hfill{\usebeamerfont{block
                      title} #1}\hfill\arabic{posterbox}}%
            \end{center}%
}{%
        \end{minipage}%
    \end{lrbox}%
    \msvposterbox{\usebox{\posterboxcontent}}%
    \vskip\fill
}%

\endinput


