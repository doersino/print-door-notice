#!/bin/bash

[ -z "$1" ] && echo "USAGE: ./print-door-notice.sh [--print] HEADING [DETAILS]" && exit
# e.g. ./print-door-notice.sh "This office will not tolerate redundancy in this office." "Those tolerant of redundancy\footnote{Which is not tolerated in this office.} will be made redundant."

CWD="$PWD"

[ "$1" == "--print" ] && PRINT=true || PRINT=false

HEADING="$1"
DETAILS="$2"

TMP="$(mktemp -d)"
cat > "$TMP/door-notice.tex" <<LATEX
\documentclass[extrafontsizes,36pt]{memoir}
\usepackage[T1]{fontenc}
\usepackage[a4paper,landscape,top=0cm]{geometry}
%\usepackage{german}
%\usepackage[babel,german=quotes]{csquotes}
\pagestyle{empty}

\newcommand{\announce}[2]{
  \vspace*{\fill}
  \begin{center}
    \large \textbf{#1} \\\\[1cm]
    \oldfootnotesize #2
  \end{center}
  \vspace*{\fill}
}

\let\oldfootnotesize\footnotesize
\renewcommand*{\footnotesize}{\oldfootnotesize\tiny}

\begin{document}

\announce{$HEADING}{$DETAILS}

\end{document}
LATEX

cd "$TMP"
pdflatex "$TMP/door-notice.tex"
if [ "$PRINT" = true ]; then
    lpr "$TMP/door-notice.pdf"
else
    cp "$TMP/door-notice.pdf" "$CWD/"
    cd "$CWD"
fi
