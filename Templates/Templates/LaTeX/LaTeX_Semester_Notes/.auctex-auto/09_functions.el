(TeX-add-style-hook
 "09_functions"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("standalone" "class=article" "crop=false")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10")
   (LaTeX-add-labels
    "compdef"
    "prinlogdef"
    "mvlogfunc"
    "pblog"
    "branchlogdef"
    "logdiff"))
 :latex)

