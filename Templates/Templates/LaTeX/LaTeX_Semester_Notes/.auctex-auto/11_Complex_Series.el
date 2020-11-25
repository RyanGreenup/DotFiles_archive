(TeX-add-style-hook
 "11_Complex_Series"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("standalone" "class=article" "crop=false")))
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
    "standalone"
    "standalone10")
   (LaTeX-add-labels
    "power-series-and-uniform-continuity"
    "power-series"
    "convergence"
    "sequences-of-functionstbook"
    "define-a-sequence-of-functions"
    "pointwise-convergence"
    "definition"
    "why-power-series"
    "example"
    "convergence-of-power-series"
    "uniform-convergence-of-power-series"
    "circle-of-convergence"
    "taylor-seriestsrs3"
    "uniform-continuity"
    "what-is-uniform-continuity"
    "cantors-theorem"
    "why-is-uniform-continuity-important"
    "problem-example"))
 :latex)

