(TeX-add-style-hook
 "01CompletenessPropertyReals"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10")
   (LaTeX-add-labels
    "upperdef"
    "lowerdef"
    "supdef"
    "infdef")
   (LaTeX-add-environments
    '("sol" LaTeX-env-args ["argument"] 0)
    '("prob" LaTeX-env-args ["argument"] 0)))
 :latex)

