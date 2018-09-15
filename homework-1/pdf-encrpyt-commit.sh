#!/bin/bash
function usage(){
echo "usage: $0 -f tex_file_name_prefix -b branch_name"
}  

while getopts ":f:b:" opt; do
  case $opt in
    f)
     file_prefix=$OPTARG 
     echo file_prefix = $file_prefix
     ;;
    b)
     branch=$OPTARG
     echo branch = $branch
     ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
  esac
done

if [ -z "$file_prefix" ]
then
   usage
   exit 1
fi

if [ -z "$branch" ]
then
  usage
  exit 1
fi

pdflatex ${file_prefix}.tex
gpg -r jhancock1975@gmail.com --yes -e ${file_prefix}.tex
git add ${file_prefix}.tex.gpg
git commit -m "working on ${file_prefix}"
git push -u origin ${branch}
