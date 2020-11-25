(TeX-add-style-hook
 "00_master"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("report" "fleqn" "10pt" "titlepage" "twoside")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "01CompletenessPropertyReals"
    "02SequencesAndFunctions"
    "./03InfSeries"
    "./03InfSeriesCauchyCriterion"
    "04SimpleLimitsReal"
    "./05_Wk5_Notes_Continuity_Pure"
    "./07_complex"
    "./08_vars"
    "./08_vars2"
    "./09_functions"
    "./10_integrals"
    "./11_Complex_Series"
    "report"
    "rep10"
    "resources/style"))
 :latex)

