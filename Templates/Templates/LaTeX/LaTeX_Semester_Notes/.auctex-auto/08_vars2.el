(TeX-add-style-hook
 "08_vars2"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("standalone" "class=article" "crop=false")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10")
   (LaTeX-add-labels
    "sec:funct-compl-vari"))
 :latex)

