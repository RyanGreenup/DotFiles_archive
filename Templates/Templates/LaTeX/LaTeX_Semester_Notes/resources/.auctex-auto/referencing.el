(TeX-add-style-hook
 "referencing"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("biblatex" "citestyle=numeric" "bibstyle=numeric" "hyperref=true" "backref=true" "maxcitenames=3" "url=true" "backend=biber" "natbib=true")))
   (TeX-run-style-hooks
    "biblatex")
   (LaTeX-add-bibliographies
    "./resources/references"))
 :latex)

