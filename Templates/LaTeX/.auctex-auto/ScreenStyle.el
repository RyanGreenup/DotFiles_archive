(TeX-add-style-hook
 "ScreenStyle"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("geometry" "margin=1in") ("biblatex" "citestyle=numeric" "bibstyle=numeric" "hyperref=true" "backref=true" "maxcitenames=3" "url=true" "backend=biber" "natbib=true")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "inputenc"
    "pgfplots"
    "comment"
    "import"
    "tikz"
    "pstricks"
    "fontenc"
    "sectsty"
    "lmodern"
    "enumitem"
    "ifxetex"
    "ifluatex"
    "lipsum"
    "geometry"
    "graphicx"
    "amsmath"
    "amssymb"
    "amsthm"
    "biblatex"
    "bibentry"
    "hyperref"
    "titlesec"
    "listings"
    "minted"
    "mdframed"
    "tcolorbox"
    "etoolbox")
   (LaTeX-add-environments
    '("sol" LaTeX-env-args ["argument"] 0))
   (LaTeX-add-bibliographies
    "/home/ryan/Dropbox/Studies/Papers/references")
   (LaTeX-add-xcolor-definecolors
    "colsse"
    "colsss"
    "colspg"
    "coltit"
    "colname"
    "dkgreen"
    "gray"
    "mauve"))
 :latex)

