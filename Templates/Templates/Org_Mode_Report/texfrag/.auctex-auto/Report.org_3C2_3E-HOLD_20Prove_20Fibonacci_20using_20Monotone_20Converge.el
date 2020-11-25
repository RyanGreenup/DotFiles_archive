(TeX-add-style-hook
 "Report.org_3C2_3E-HOLD_20Prove_20Fibonacci_20using_20Monotone_20Converge"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("color" "usenames") ("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem") ("standalone" "mode=buildnew")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "color"
    "minted"
    "inputenc"
    "fontenc"
    "graphicx"
    "grffile"
    "ulem"
    "amsmath"
    "textcomp"
    "amssymb"
    "standalone"
    "tikz")
   (LaTeX-add-environments
    '("sol" LaTeX-env-args ["argument"] 0))
   (LaTeX-add-bibliographies
    "../Resources/references"))
 :latex)

