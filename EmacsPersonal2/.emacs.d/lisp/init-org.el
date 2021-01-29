;;; init-org.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Use Superstar Mode for Leading Stars
;; SLOW ; This  may cause issue
(add-hook 'org-mode-hook
          (lambda ()
            (org-superstar-mode 1))
          (lambda ()
            (texfrag-mode 1))
	  )

(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-tags-column 80)
(setq org-agenda-files '("~/Notes/Org"))

;; After loading org
(with-eval-after-load 'org


    ;;; Orb Babel Languages
    ;;;; Active Babel languages
    (org-babel-do-load-languages
    'org-babel-load-languages
    '((R           . t)
	(latex       . t)
	(python      . t)
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
    ;;;;;;; Set up Plant UML
    (setq org-plantuml-jar-path (expand-file-name "/bin/plantuml.jar"))
    (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))


;;;; Styling
(setq org-hidden-keywords '(title))
;; set basic title font
(set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)


)


(global-set-key (kbd "C-c a") 'org-agenda)

(provide 'init-org)
;;; init-org.el ends here
