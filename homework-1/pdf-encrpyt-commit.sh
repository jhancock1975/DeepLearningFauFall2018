#!/bin/bash
file_prefix=$1
branch=$2
pdflatex ${file_prefix}.tex
gpg -r jhancock1975@gmail.com -y -e ${file_prefix}.tex
git add ${file_prefix}.tex
git commit -m "working on ${file_prefix}"
git push -u origin ${branch}
