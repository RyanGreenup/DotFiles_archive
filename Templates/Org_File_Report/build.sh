#!/bin/bash
# Don't forget to adjust the permissions with:
#chmod +x ~/somecrazyfolder/script1

## Program


### Description
# If the makefile becomes a pain in the ass

### Code
# emacs -l ~/.emacs.d/init.el Report.org  --batch -f org-latex-export-to-latex --kill # if org-ref is installed globally
emacs Report.org  --batch -f org-latex-export-to-latex --kill    
sed -r \
    -e "s!^(cite:)(\S*)\ !\ \\\cite{\2}\ !g" \
    -e "s!\ (cite:)(\S*)!\ \\\cite{\2}\ !g"  \
    -e "s!\[\[cite:(.*)\]\[(.*)\]\]!\\\cite\[\2\]{\1}\ !g" \
    -i Report.tex
latexmk -pdf -xelatex -f -interaction=nonstopmode
latexmk -c
# rm  Report.run.xml Report.dvi Report.run.xml Report.xdv # Report.bbl


## This is what the makefile does:
    # emacs -l ~/.emacs.d/init.el Report.org  --batch -f org-latex-export-to-latex --kill
    # biber Report.bcf
    # xelatex -interaction=nonstopmode -shell-escape Report.tex
    # latexmk -c
    # zathura Report.pdf & disown




## vim:fdm=expr:fdl=0
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='

