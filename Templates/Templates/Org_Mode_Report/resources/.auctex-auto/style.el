(TeX-add-style-hook
 "style"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("inputenc" "utf8") ("ulem" "normalem") ("geometry" "margin=1.5in") ("libertine" "mono=false")))
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
    "comment"
    "import"
    "tikz"
    "svg"
    "fontenc"
    "inputenc"
    "ulem"
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
    "sectsty"
    "fancyhdr"
    "lastpage"
    "listings"
    "tcolorbox"
    "minted"
    "libertine"
    "xltxtra"
    "fontspec"
    "xunicode")
   (LaTeX-add-environments
    '("sol" LaTeX-env-args ["argument"] 0))
   (LaTeX-add-tcbuselibraries
    "breakable, most, minted"
    "skins")
   (LaTeX-add-xcolor-definecolors
    "sec"
    "subsec"
    "subsubsec"
    "paragraph"
    "subparagrap"
    "midnightblue"
    "dkgreen"
    "gray"
    "mauve"))
 :latex)

