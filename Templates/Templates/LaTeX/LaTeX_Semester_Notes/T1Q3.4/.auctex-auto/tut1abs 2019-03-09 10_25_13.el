(TeX-add-style-hook
 "tut1abs 2019-03-09 10_25_13"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("standalone" "class=article" "crop=false")))
   (TeX-run-style-hooks
    "latex2e"
    "standalone"
    "standalone10")
   (LaTeX-add-labels
    "fig:pic"
    "def1"
    "def2"
    "def3"
    "trichotomy")
   (LaTeX-add-environments
    '("sol" LaTeX-env-args ["argument"] 0)
    '("prob" LaTeX-env-args ["argument"] 0)))
 :latex)

