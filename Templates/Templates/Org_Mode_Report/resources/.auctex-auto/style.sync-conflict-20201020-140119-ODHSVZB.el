(TeX-add-style-hook
 "style"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("ucharclasses" "Latin" "Greek" "Emoticons") ("fontenc" "T1") ("geometry" "margin=2cm")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "inputenc"
    "fontspec"
    "ucharclasses"
    "pgfplots"
    "comment"
    "import"
    "tikz"
    "pstricks"
    "pst-solides3d"
    "svg"
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
   (LaTeX-add-tcbuselibraries
    "skins,breakable")
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

