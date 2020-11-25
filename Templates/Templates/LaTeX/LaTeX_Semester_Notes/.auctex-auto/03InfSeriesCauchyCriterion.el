(TeX-add-style-hook
 "03InfSeriesCauchyCriterion"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("standalone" "class=article" "crop=false")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10")
   (LaTeX-add-labels
    "inprob"
    "cauchdef"
    "finalform"
    "epsrestfin"
    "Hrest2"))
 :latex)

