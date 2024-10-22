(TeX-add-style-hook
 "Report.org-Exponential_20Generating_20Functions-1"
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
   (LaTeX-add-labels
    "eq:exp-pow-series"
    "eq:exp-pow-series-sol"
    "eq:hom-ode"
    "eq:recurrence-relation-def"
    "eq:unique-root-sol-power-series-form"
    "eq:hom-repeated-roots-recurrence"
    "eq:rep-roots-func-ode"
    "eq:rep-roots-recurrence-char-sol"
    "eq:rep-roots-ode-sol"
    "eq:uniq-roots-pow-series-ident"
    "eq:gen-form-rep-roots-ode"
    "eq:sol-rep-roots-ode")
   (LaTeX-add-environments
    '("sol" LaTeX-env-args ["argument"] 0))
   (LaTeX-add-bibliographies
    "../Resources/references"))
 :latex)

