(TeX-add-style-hook
 "pandoc_style"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("inputenc" "utf8")))
   (TeX-run-style-hooks
    "lmodern"
    "amssymb"
    "amsmath"
    "ifxetex"
    "ifluatex"
    "fontenc"
    "inputenc"
    "textcomp"
    "unicode-math"
    "upquote"
    "microtype"
    "parskip"
    "xcolor"
    "xurl"
    "bookmark"
    "hyperref"
    "selnolig")
   (TeX-add-symbols
    "tightlist")
   (LaTeX-add-environments
    '("sol" LaTeX-env-args ["argument"] 0)
    '("prob" LaTeX-env-args ["argument"] 0)))
 :latex)

