;;; init-org.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-tags-column 80)
(setq org-agenda-files '("~/Notes/Org/agenda/"))


;;; Periodically When Idle
;; Maybe Rebuild Org-Agenda?

;;; Exports
;;;; LaTeX
;;;;; Captions go Below Table
(setq org-latex-caption-above nil)

;;;;; LaTeX Call
;(setq org-latex-listings 'listings
;      org-latex-packages-alist '(("" "listings"))
;      org-latex-pdf-process
;      '("xelatex -shell-escape -synctex=1 -interaction nonstopmode -output-directory %o %f"
;        "biber %b.bcf"
;        "xelatex -shell-escape -synctex=1 -interaction nonstopmode -output-directory %o %f"))

; (setq org-latex-listings 'minted
;       org-latex-packages-alist '(("" "minted"))
;       org-latex-pdf-process
;       '("xelatex -shell-escape -synctex=1 -interaction nonstopmode -output-directory %o %f"
;         "biber %b.bcf"
;         "xelatex -shell-escape -synctex=1 -interaction nonstopmode -output-directory %o %f"))

; LaTeXMk is more efficient
;; Execute either depending on which one you want, and or swap order
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("latexmk -f -shell-escape -xelatex -interaction=nonstopmode %F")
        )

;; (setq org-latex-listings 'listings
;;       org-latex-packages-alist '(("" "listings"))
;;       org-latex-pdf-process
;;       '("latexmk -f -shell-escape -xelatex -interaction=nonstopmode %F")
;;         )

; Press f5 to Export Macro (NOTE: Use el:macro)
(fset 'Async\ Export\ Latex
   (kmacro-lambda-form [?\C-c ?\C-e ?\C-a ?l ?p] 0 "%d"))
(global-set-key [f5] 'Async\ Export\ Latex)

;;;; ODT Export uses MathML
(setq org-latex-to-mathml-convert-command
      "latexmlmath \"%i\" --presentationmathml=%o")
;;;; Pandoc Org-Mode HTML Export
;; TODO offer CSS Choices
;; TODO Have the file type read automatically?
;; TODO MathJax could be put in more elegantly, maybe use a variable
;; TODO Shouldn't check for the file name four times in a row.

(defun export-org-as-self-contained-html-pandoc ()
 (interactive)
  (save-window-excursion
   (async-shell-command
    (format "pandoc %s.org --self-contained -s -B ~/.doom.d/mathjax.js -o %s.html"
     (shell-quote-argument (file-name-sans-extension buffer-file-name))
     (shell-quote-argument (file-name-sans-extension buffer-file-name))
   )
  )
 )
)

;;; org-ref
;; (require 'org-ref) ;; Must be required, see README
(setq reftex-default-bibliography '("~/Sync/Studies/Papers/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/Sync/Studies/Papers/notes.org"
      org-ref-default-bibliography '("~/Sync/Studies/Papers/references.bib")
      org-ref-pdf-directory "~/Sync/Studies/Papers/PDFS")
;;;;; Hide Citation Syntax
(add-hook 'org-mode-hook
  (lambda ()
    (add-to-list 'font-lock-extra-managed-props 'display)
    (font-lock-add-keywords nil
     '((" \\(cite:[a-z0-9A-Z]\+\\)" 1 '(face nil display "🤔"))))

    (add-to-list 'font-lock-extra-managed-props 'display)
    (font-lock-add-keywords nil
     '((" \\(\\[\\[cite:[a-z0-9A-Z]\+\\]\\[\.\*\\]\\]\\)" 1 '(face nil display "¹"))))

  )
)
;;; After loading org
;; Seemingly this can only be done when using Doom with (after!...)
;; I should look at how that was done and review my doom config

;;;;; Active Babel languagevs
(org-babel-do-load-languages
'org-babel-load-languages
'(  (R           . t)
    (latex       . t)
    (python      . t)
    ;; (ess-julia   . t)
    ;; (mongo       . t) ;; TODO Should I set this up?
    (sqlite      . t)
    (plantuml    . t)
    (dot         . t)
    (gnuplot     . t)
    (asymptote   . t)
    (java        . t)
    ;; (javascript  . t) ;; TODO
    (sed         . t)
    (shell       . t)
    ;; (mathematica . t)
    (emacs-lisp  . t)))
;;;;;; Don't Ask
(setq org-confirm-babel-evaluate nil)
;; (load "./straight/repos/org/contrib/lisp/ob-julia.el")
;;;;;; Set up Plant UML
(setq org-plantuml-jar-path (expand-file-name "/bin/plantuml.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))



;;;; Org Download
(setq org-download-method 'directory)
(setq-default org-download-image-dir "./media/")
;;;; Appearance
(setq org-display-inline-images t)
(setq org-redisplay-inline-images t)
(setq org-startup-with-inline-images "inlineimages")
(setq org-hide-emphasis-markers t)
(setq org-confirm-elisp-link-function nil)
(setq org-link-frame-setup '((file . find-file)))

;;;; Orb Babel Languages
;;;;  Styling
(setq org-hidden-keywords '(title))
;; set basic title font
(set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)


;;;; Keybindings
;;;;; Agenda
;; Move up and Down in Agenda
;; In the agenda evil doesn't work, because there are already other
;; keybindings like F for follow mode, map j/k as a compromise
(add-hook 'org-agenda-mode-hook (lambda ()
(define-key org-agenda-mode-map "j" 'evil-next-line)
(define-key org-agenda-mode-map "k" 'evil-previous-line)
(define-key org-agenda-mode-map (kbd "M-SPC" ) 'hydra-org-agenda/body)
))





;;;; End After Loading Org

;;; Hooks
;; Use Superstar Mode for Leading Stars
;; SLOW ; Superstar mode is slightly slower
(add-hook 'org-mode-hook (lambda ()
			   (org-superstar-mode 1)
             		   (texfrag-mode 1)
			   ))

;;; init-org.el ends here
(provide 'init-org)
