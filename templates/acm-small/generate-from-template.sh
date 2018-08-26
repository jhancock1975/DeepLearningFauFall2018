#!/bin/bash
# run this script to copy
# files needed to get started
# on a research paper
if [ $# -ne 2 ]; then
  echo usage: $0 destination-directory report-name
  exit 0
fi
dest=$1
file_name=$2
cp based-on-acmsmall.tex ${dest}/${file_name}.tex
cp based-on-samplebody-journals.tex ${dest}/${file_name}-body.tex
cp acmart.cls ${dest}/
cp ACM-Reference-Format.bst ${dest}/
cp sample-bibliography.bib ${dest}/

