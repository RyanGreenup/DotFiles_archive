(TeX-add-style-hook
 "notes"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("inputenc" "utf8") ("hyperref" "unicode=true")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "lmodern"
    "amssymb"
    "amsmath"
    "ifxetex"
    "ifluatex"
    "fixltx2e"
    "fontenc"
    "inputenc"
    "mathspec"
    "fontspec"
    "upquote"
    "microtype"
    "hyperref"
    "parskip")
   (TeX-add-symbols
    "tightlist"
    "oldparagraph"
    "oldsubparagraph")
   (LaTeX-add-labels
    "limits"
    "limits-of-functions-4.1"
    "the-limit-generally"
    "remarks-on-this-definition"
    "notation"
    "the-limit-using-cluster-points"
    "neighborhoods-2.2.7"
    "cluster-points"
    "definition-of-the-limit-4.1.4"
    "definition-using-neigborhoods-4.1.6"
    "only-one-limit-value-4.1.5"
    "using-sequences-to-define-limits-4.1.8"
    "definition"
    "divergence-criteria-4.1.9"
    "a-limit-is-not-a-specific-value"
    "b-no-limit-whatsover"
    "the-signum-function"
    "limit-theorems-4.2"
    "bounded-functions"
    "definition-1"
    "limits-imply-bounded-neighbourhoods-4.2.2"
    "functions-and-arithmetic-4.2.3"
    "limit-theorems"
    "limits-captured-in-intervals-4.2.6"
    "squeeze-theorem-4.2.7"
    "a-positive-limit-implies-a-neighbourhood-with-positive-values"
    "extensions-of-the-limit-concept-4.3"
    "one-sided-limits-4.3.1"
    "definition-4.3.1"
    "limit-must-be-equal-on-both-sides"
    "infinite-limits-4.3.5"
    "one-sided-limits-to-infinity-4.3.8"
    "ordered-functions"
    "limits-at-infinity-4.3.10"
    "infinite-limits-at-infinity")
   (LaTeX-add-environments
    '("sol" LaTeX-env-args ["argument"] 0)
    '("prob" LaTeX-env-args ["argument"] 0)))
 :latex)

