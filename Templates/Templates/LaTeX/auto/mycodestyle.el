(TeX-add-style-hook
 "mycodestyle"
 (lambda ()
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "listings"
    "minted"
    "mdframed"
    "tcolorbox"
    "etoolbox")
   (LaTeX-add-environments
    '("sol" LaTeX-env-args ["argument"] 0))
   (LaTeX-add-xcolor-definecolors
    "dkgreen"
    "gray"
    "mauve"))
 :latex)

