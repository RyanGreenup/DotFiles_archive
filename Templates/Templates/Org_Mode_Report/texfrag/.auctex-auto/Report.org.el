(TeX-add-style-hook
 "Report.org"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("color" "usenames") ("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem") ("standalone" "mode=buildnew")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
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
    "eq:koch-dim"
    "eq:hausdorff-covering"
    "eq:delta-measure"
    "eq:limit-haus"
    "eq:hdfzero"
    "eq:visek-iter"
    "eq:vic-dim-val"
    "eq:bottom-right"
    "eq:phi-sim-to-fib-rec"
    "eq:phi-value"
    "eq:fib-def-shift"
    "eq:exp-gen-def-1"
    "eq:exp-gen-def-2"
    "eq:exp-gen-def-3"
    "eq:fib-sol"
    "eq:mb-sequence"
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
    "eq:sol-rep-roots-ode"
    "eq:uniq-roots-pow-series-ident-used")
   (LaTeX-add-bibliographies
    "../Resources/references"))
 :latex)

