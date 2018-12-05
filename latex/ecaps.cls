%%%%%%%%%%%%%%%%
%% Class Options
\ProvidesClass{ecaps}

\DeclareOption{centerpage}{} % Backwards compatibility with previous version of this class

\newif\ifXETEX\XETEXfalse
\DeclareOption{xetex}{\XETEXtrue}

\newif\ifANYMEMO\ANYMEMOfalse
\newif\ifMEMO\MEMOfalse
\DeclareOption{memo}{\MEMOtrue \ANYMEMOtrue}
\newif\ifMEMOSINGLECOLUMN\MEMOSINGLECOLUMNfalse
\DeclareOption{memosinglecolumn}{\MEMOSINGLECOLUMNtrue \ANYMEMOtrue}

% Font options
% Adobe Source Sans Pro:
\newif\ifSOURCESANS\SOURCESANSfalse
\DeclareOption{sourcesans}{\SOURCESANStrue \XETEXtrue}

% Currently Gentium
\newif\ifSERIF\SERIFfalse
\DeclareOption{serif}{\SERIFtrue}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax

\ifMEMO
  \LoadClass[twocolumn]{article}
\else
  \LoadClass{article}
\fi

%%%%%%%%%%%%%%%%%%
%% main doc fields
\newcommand{\doctitle}[1]{\def \@doctitle {#1}} % Backward compatibility. Use \title instead
\newcommand{\docsubtitle}[1]{\def \@docsubtitle {#1}}
\newcommand{\docnumber}[1]{\def \@docnumber {#1}}

\title{\@doctitle}
\docsubtitle{}
\docnumber{}

% needed to widen margins to center the tables of approvers, versions
% when centering the page.
\RequirePackage{chngpage}

%%%%%%%%%%
%% margins
\ifMEMO
  \RequirePackage[top=1in,bottom=1in,left=0.75in,right=0.75in,headheight=.5in,columnsep=.25in]{geometry}
\else
  \ifMEMOSINGLECOLUMN
    \RequirePackage[top=1in,bottom=1in,left=1.25in,right=1.25in,headheight=.5in]{geometry}
  \else
    \RequirePackage[top=2in,bottom=1.5in,left=1.25in,right=1.25in,headheight=1in]{geometry}
  \fi
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Misc. Packages and tweaks
\RequirePackage{graphicx}

\RequirePackage[table]{xcolor}
\RequirePackage{tabularx}
\RequirePackage{multirow}

\definecolor{ECAPSBlue}{RGB}{16,103,158}
\definecolor{ECAPSGray}{RGB}{155,155,154}

%hyperlinks
\colorlet{linkcolor}{ECAPSBlue!80!black}
\RequirePackage[backref,pagebackref=true,colorlinks=true,%
linkcolor=linkcolor,citecolor=linkcolor,urlcolor=linkcolor]{hyperref}
\g@addto@macro{\UrlBreaks}{\UrlOrds} % Wrap URLs reasonably.

% Wrapfigure
\RequirePackage{wrapfig}%   wrap figures/tables in text (i.e., Di Vinci style)

% Smart referencing
\RequirePackage{varioref}%  smart page, figure, table, and equation referencing

% Tweak footnote indentation.
\usepackage[hang]{footmisc}
\setlength\footnotemargin{0.8em}

% spacing
\RequirePackage{setspace}

%LaTeX Goodies
\RequirePackage{amsmath,amsbsy}
\RequirePackage{xfrac}
\RequirePackage{mathtools}
\RequirePackage{fixltx2e}
\RequirePackage{array}
\RequirePackage{verbatim}
\RequirePackage{caption}

% other packages
\RequirePackage{booktabs} %nice tables
\RequirePackage{textcomp} % juicy symbols in text mode

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sectioning (Make paragraphs look the same as sections)
\setcounter{secnumdepth}{4}
\RequirePackage{titlesec}
\titleformat{\paragraph}{\normalfont\normalsize\bfseries}{\theparagraph}{1em}{}
\titlespacing*{\paragraph}{0pt}{2ex}{0pt}
\titleformat{\subparagraph}{\normalfont\normalsize\bfseries}{\thesubparagraph}{1em}{}
\titlespacing*{\subparagraph}{0pt}{\parskip}{0pt}

\ifANYMEMO
\titlespacing*{\section}{0pt}{2ex}{1ex}
\titlespacing*{\subsection}{0pt}{1.5ex}{1ex}
\titlespacing*{\subsubsection}{0pt}{1.5ex}{1ex}
\titlespacing*{\paragraph}{0pt}{1ex}{0pt}
\fi

%%%%%%%%%%%%%%%
%% Paragraphing
\ifANYMEMO
  \RequirePackage[document]{ragged2e}
  \setlength{\RaggedRightParindent}{1.5em}
\else
  \setlength{\parindent}{0pt}
  \setlength{\parskip}{1ex plus 0.5ex minus 0.2ex}
\fi

%%%%%%%%%%%%%%%%%%%
%% Other Formatting
% Make description list descriptions line up nice.
\RequirePackage{enumitem}
\ifANYMEMO
  \setlist{noitemsep,topsep=1ex,style=nextline}
\else
  \setlist[description]{style=nextline}
\fi
%%%%%%%%%
%% FONTS!
% (we'll never get to a consensus on this)
\ifSOURCESANS
  % Set up fonts for xetex

  \RequirePackage{mathspec} % pulls in fontspec
  \RequirePackage{xunicode,xltxtra}
  \defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
  \setmonofont{Source Code Pro}
  \setmathfont(Digits,Latin,Greek){Source Sans Pro}
  \setsansfont[BoldFont={Source Sans Pro Semibold},
               ItalicFont={Source Sans Pro Italic},
               BoldItalicFont={Source Sans Pro Semibold Italic},
              ]{Source Sans Pro}

  \newcommand{\headerfamily}{\normalfont}
  \renewcommand*\familydefault{\sfdefault}

\else
  \ifSERIF
    %\RequirePackage{pxfonts}
    %\RequirePackage[T1]{fontenc}

    \usepackage[T1]{fontenc}
    \usepackage{gentium}

    \newcommand{\headerfamily}{\normalfont}
  \else
    \RequirePackage{lmodern}
    \renewcommand*\familydefault{\sfdefault}

    \renewcommand{\ttdefault}{cmtt}
    \renewcommand{\sfdefault}{cmss}
    \newcommand{\headerfamily}{\normalfont}

    %%%%%%%%%%\RequirePackage{fouriernc}
    % sf fonts in math mode
    \RequirePackage{sfmath}
  \fi
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Used by footers and title pages.
\newcommand{\longitarnotice}{This document contains information confidential
    to ECAPS AB}

%%%%%%%%%%%%%%%%%%%%%%
%% Headers and Footers
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}

% output the subtitle followed by a newline if the subtitle is set, else nothing
\newcommand{\@docsubtitleline}{%
  \ifx \@docsubtitle
    \@empty \relax
  \else
    {\@docsubtitle} \linebreak
  \fi
}

% output the doc number followed by a newline if the doc number is set, else nothing
\newcommand{\@docnumberline}{%
  \ifx \@docnumber
    \@empty \relax
  \else
    {\@docnumber} \linebreak
  \fi
}

\fancypagestyle{ECAPSpagestyle}{%
  \fancyhead[L]{\includegraphics[width=3.5cm]{logo.pdf}}
  \fancyhead[R]{%
    \headerfamily
	\@title \linebreak
    \@docsubtitleline
    \@docnumberline
  }

  \fancyfoot[R]{\thepage\ of \pageref*{LastPage}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0.4pt}
}

\fancypagestyle{memootherpages}{%
  \fancyhf{}
  
  \fancyhead[L]{\headerfamily\bfseries\@title}
  \fancyhead[R]{\@docnumber}

  \fancyfoot[R]{Page \thepage\ of \pageref*{LastPage}}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0.4pt}
}

\fancypagestyle{memofirstpage}{%
  \fancyhf{} % clear all header and footer fields
  \fancyhead[L]{\raisebox{-.4in}[0pt][0pt]{\includegraphics[width=3.5cm]{logo.pdf}}}
  \fancyhead[R]{\raisebox{-.25in}[0pt][0pt]{\parbox{\textwidth}{%
        \begin{flushright}
    \headerfamily 
    \@docnumberline
    \@date
    \end{flushright}}}}
  %\fancyfoot[R]{\thepage\ of \pageref{LastPage}}
  \fancyfoot[C]{\fbox{\parbox{0.8\textwidth}{\centering\footnotesize\bfseries\longitarnotice}} \\
                Page \thepage\ of \pageref*{LastPage}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\ifANYMEMO
  \pagestyle{memootherpages}
\else
  \pagestyle{ECAPSpagestyle}
\fi

%%%%%%%%%%%%%
%% Title Page
\newcommand{\memotitle}{%
  \begin{center}
    {\headerfamily\bfseries\huge\@title} \\
    \vspace{1ex}
    \ifx \@docsubtitle \@empty \relax
    \else {\headerfamily\Large\@docsubtitle} \\ \vspace{1ex} \fi
    {\headerfamily  \@author}
    \vspace{1ex}
    \hrule
  \end{center}
}

\newcommand{\normaltitle}{%
  \thispagestyle{empty}%
  \begin{center}
    \includegraphics[width=7cm]{logo.pdf}\\
    \vskip20mm
    \headerfamily\Large\@title \\
    {\headerfamily\large\@docsubtitleline}
    \vskip3mm
    {\headerfamily\large\@docnumberline}
    \vskip20mm
    \normalsize
    \@author\\
    \@date\\
  \end{center}
  \vfill
  \begin{center}
    \fbox{\parbox{0.95\textwidth}{
        \begin{center}
          \longitarnotice
        \end{center}}}
  \end{center}
  \vskip5mm
  \begin{center}
    \headerfamily
  \end{center}
  \newpage
}

\def\titlepage{%
  \ifANYMEMO
    \thispagestyle{memofirstpage}
    \ifMEMO \twocolumn[\begin{@twocolumnfalse} \fi
    \memotitle
    \ifMEMO \end{@twocolumnfalse}] \fi
  \else
    \normaltitle
  \fi
}

%%%%%%%%%%%%%%%%%%%%
%% Table of Contents
\def\contents {%
  \newpage
  \tableofcontents
  \newpage
}

%%%%%%%%%%%%%%%
%% Environments
\newenvironment{approvals}{%
  \begin{adjustwidth}{-0.5in}{-0.5in}
    \begin{center}
      ~\vskip 5mm
      {\Large Approvals}

      \rowcolors{1}{ECAPSBlue!40}{ECAPSBlue!20}
      \begin{tabular}{p{4cm}p{3.9cm}p{5cm}p{2cm}}
        \textbf{Function} & \textbf{Name} & \textbf{Signature} & \textbf{Date}\\
        \hline
}{%
      \end{tabular}
    \end{center}
  \end{adjustwidth}
}
% \approver{<name>}{<function>}
\newcommand{\approver}[2]{#2 & #1 & & \\}


\newenvironment{applicableprograms}{%
  \begin{center}
    ~\vskip 5mm
    {\Large Applicable Programs}
    \rowcolors{1}{ECAPSBlue!40}{ECAPSBlue!20}
    \begin{tabular}{c}
}{%
    \end{tabular}
  \end{center}
}
% \applicableprog{<name>}{<function>}
\newcommand{\applicableprog}[1]{#1 \\}

\newenvironment{revhistory}{%
  \begin{adjustwidth}{-0.5in}{-0.5in}
    \begin{center}
      ~\vskip 5mm
      {\Large Revision history}

      \rowcolors{1}{ECAPSBlue!40}{ECAPSBlue!20}
      \begin{tabular}{p{9mm}p{25mm}p{12cm}}
        \textbf{Rev.} & \textbf{Date} & \textbf{Comment} \\
        \hline
}{%
      \end{tabular}
    \end{center}
  \end{adjustwidth}
}
% \approver{<name>}{<function>}
\newcommand{\revitem}[3]{#1 & #2 & #3\\}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Small Formatting Commands
% adds \sub{} \super{} for sub/superscripting
\providecommand{\sub}[1]{\textsubscript{#1}}
\providecommand{\super}[1]{\textsuperscript{#1}}

\newcommand{\vect}[1]{\pmb{#1}}
\renewcommand{\Re}{\mathrm{Re}}
\renewcommand{\Im}{\mathrm{Im}}
\newcommand{\unit}[1]{\ensuremath{\, \mbox{#1}}}
%Example
%$ m = 5 kg $ will render as �m = 5 kg�.
%$ m = 5\unit{kg} $ will also render as �m = 5 kg�.

\newcommand{\jiraurl}[1]{\url{http://jira.sky/browse/#1}}
\newcommand{\jira}[2]{\textsc{#1--#2}\footnote{\jiraurl{#1-#2}}}

% Scientific notation
\providecommand{\e}[1]{\ensuremath{\times 10^{#1}}}

% Hexadecimal
\newcommand{\hex}[1]{\texttt{0x\uppercase{#1}}}

% Listings
\RequirePackage{listings}
\lstset{%
  basicstyle=\footnotesize\ttfamily,
  frame=tb,
  backgroundcolor=\color{ECAPSBlue!20},
  linewidth=0.95\linewidth,
  xleftmargin=0.05\linewidth,
  escapeinside={(*@}{@*)}
}

\lstnewenvironment{bash}{\lstset{language=bash}}{}
\lstnewenvironment{matlab}{\lstset{language=Matlab}}{}
\lstnewenvironment{octave}{\lstset{language=Octave}}{}
\lstnewenvironment{clisting}{\lstset{language=C}}{}
\lstnewenvironment{python}{\lstset{language=Python}}{}

% Spacecraft Commands
\RequirePackage{pgffor}
\newcommand{\cmdarg}[1]{\texttt{\textmd{\lowercase{\detokenize\expandafter{#1}}}}}

\newcommand{\cmd}[2][]{\textbf{\texttt{\uppercase{\detokenize{#2}}}}%
  \lowercase{\foreach \x in {#1}{\enspace\cmdarg{\x}}}}
