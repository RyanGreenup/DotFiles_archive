(TeX-add-style-hook
 "style"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("babel" "english") ("hyperref" "colorlinks=true" "linkcolor=blue" "urlcolor=blue" "bookmarksopen=true") ("geometry" "margin=1.5in") ("bookmark" "depth=5")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "standalone"
    "inputenc"
    "babel"
    "hyperref"
    "geometry"
    "centernot"
    "wrapfig"
    "xcolor"
    "amsmath"
    "amssymb"
    "amsfonts"
    "svg"
    "esint"
    "multicol"
    "steinmetz"
    "lipsum"
    "lmodern"
    "libertine"
    "graphicx"
    "xfrac"
    "bookmark"
    "titlesec"
    "tcolorbox"
    "fancyhdr"
    "tikz"
    "pstricks"
    "import"))
 :latex)

