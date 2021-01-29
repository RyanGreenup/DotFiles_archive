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
(setq org-agenda-files '("~/Notes/Org/agenda/"))

;; After loading org

(with-eval-after-load 'org


    ;;; Orb Babel Languages
    ;;;; Active Babel languagevs
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


;; Hooks


;; keybindings
(global-set-key (kbd "C-c a") 'org-agenda)

;; Move up and Down in Agenda
;; In the agenda evil doesn't work, because there are already other
;; keybindings like F for follow mode, map j/k as a compromise
(add-hook 'org-mode-hook (lambda ()
				;; (define-key org-agenda-mode-map "k" 'org-agenda-next-item)
				;; (define-key org-agenda-mode-map "k" 'org-agenda-previous-item)
				(define-key org-agenda-mode-map "j" 'evil-next-line)
				(define-key org-agenda-mode-map "k" 'evil-previous-line)
				)
	)

(provide 'init-org)
;;; init-org.el ends here
