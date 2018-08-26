#!/bin/bash
if [ $# -ne 1 ]; then
 echo usage: $0 file-name.tex
 exit 0
fi
file_name=$1
bib_file_name=y=${$1%.*}.aux
pdflatex ${file_name}
bibtex ${bib_file_name}
pdflatex ${file_name}
pdflatex ${file_name}
