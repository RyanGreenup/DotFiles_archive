(TeX-add-style-hook
 "diffpreamble"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("geometry" "margin=1in")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "tcolorbox"
    "mdframed"
    "inputenc"
    "pgfplots"
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
    "bibentry"
    "hyperref")
   (LaTeX-add-environments
    '("sol" LaTeX-env-args ["argument"] 0)))
 :latex)

