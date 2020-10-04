# Final Report
#
# Why not ~latexmk -pdf~ ?
  # Does not export the org file.
  # Does not like to clean up the directory at all
  # Practice
  # To replace ~-pvc~ try ~watch make~ or ~while true; do make --silent; sleep 1; done~
# @file
# @version 0.1
#
# Use Tabs not Spaces
# https://opensource.com/article/18/8/what-how-makefile
# https://www.gnu.org/software/make/manual/html_node/How-Make-Works.html
all: Report.tex Report.pdf Report.bbl Report.html
# In hindsight this could just use latexmk
.PHONY: all


# @ emacs -l ~/.emacs.d/init.el Report.org --batch -f org-latex-export-to-latex --kill
Report.tex : Report.org
	@ emacs Report.org --batch -f org-latex-export-to-latex --kill
	@ sed -r \
	    -e "s!^(cite:)(\S*)\ !\ \\\cite{\2}\ !g" \
	    -e "s!\ (cite:)(\S*)!\ \\\cite{\2}\ !g"  \
	    -e "s!\[\[cite:(.*)\]\[(.*)\]\]!\\\cite\[\2\]{\1}\ !g" \
	    -i Report.tex

Report.pdf : Report.tex
# there was a reason I didn't use latexmk, I just can't remember
#	@ xelatex -interaction=nonstopmode -shell-escape Report.tex
	@ latexmk -pdf -xelatex -f -interaction=nonstopmode Report.tex
clean :
	@ latexmk -c
	@ rm Report.run.xml
clear:
	latexmk -c
	@ rm Report.tex Report.pdf Report.pdf Report.run.xml Report.dvi Report.pdf Report.run.xml Report.xdv # Report.bbl

# * Rules

Report.html : Report.tex
# Make the HTML
#
# Doesn't tolerate missing images
#	@ pandoc Report.tex -s -t html                                \
#	-c resources/style.css                                      \
#	--csl resources/nature.csl --bibliography ../Resources/references.bib    \
#	--mathjax                                                   \
#	-o Report.html
#	@ pandoc -s --self-contained -B resources/mathjax.js        \
#	-c resources/style.css                                      \
#	Report.html -o Report.html
