##
# Final Report
#
# @file
# @version 0.1
#
# Use Tabs not Spaces
# https://opensource.com/article/18/8/what-how-makefile
# https://www.gnu.org/software/make/manual/html_node/How-Make-Works.html
#
make_latex:
	@ command -v xelatex >/dev/null 2>&1 || { echo >&2 "I require xelatex but it's not installed.  Aborting."; exit 1; }
	@ command -v biber >/dev/null 2>&1 || { echo >&2 "I require xelatex but it's not installed.  Aborting."; exit 1; }
	@ command -v zathura >/dev/null 2>&1 || echo >&2 "You should install Zathura"
	@ xelatex -interaction=nonstopmode -shell-escape Report.tex
	@ biber Report.bcf
	@ xelatex -interaction=nonstopmode -shell-escape Report.tex
	@ latexmk -c
	zathura Report.pdf
# Make the HTML
# Doesn't tolerate missing images
#	@ pandoc Report.tex -s -t html                                \
#	-c resources/style.css                                      \
#	--csl resources/nature.csl --bibliography ../Resources/references.bib    \
#	--mathjax                                                   \
#	-o Report.html
#	@ pandoc -s --self-contained -B resources/mathjax.js        \
#	-c resources/style.css                                      \
#	Report.html -o Report.html
