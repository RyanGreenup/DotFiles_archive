(TeX-add-style-hook
 "07_complex"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("standalone" "class=article" "crop=false")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("inputenc" "utf8")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10"
    "lmodern"
    "amssymb"
    "amsmath"
    "esint"
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
   (LaTeX-add-labels
    "integrals-from-a-real-domain"
    "differentiation"
    "integration"
    "fundamental-theorem-of-calculus"
    "ftcest"
    "justification"
    "contours"
    "define-contours"
    "arcdef"
    "arccompdef"
    "types-of-arcs"
    "parametric-representation-not-unique"
    "contour-integral"
    "tdef"
    "negative-contours"
    "notation"
    "upper-bounds-for-moduli"
    "example"
    "excontint1"
    "antiderivatives"
    "basic-antiderivative-theorem"
    "proof"
    "cauchy-goursat-theorem"
    "the-cauchy-goursat-theorem"
    "simply-connected-domains"
    "multiply-connected-domains"
    "principle-of-deformation"
    "spacial-case-of-deformation"
    "example-1"
    "cauchy-integral-formula"
    "cauchy-integral-formula-1"
    "example-2"
    "extension-of-the-cauchy-integral-formula"
    "extension-to-cauchy-integral"))
 :latex)

