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


;;; Preiodically When Idle
;; Maybe Rebuild Org-Agenda?
;;; After loading org

(with-eval-after-load 'org

  (lambda ()

    (texfrag-global-mode 1)  ;; Load globally here, it throws an error at init
			     ;; and I mostly use it in org-mode anyway

    ;;;;; Appearance
  (setq org-display-inline-images t)
  (setq org-redisplay-inline-images t)
  (setq org-startup-with-inline-images "inlineimages")
  (setq org-hide-emphasis-markers t)
  (setq org-confirm-elisp-link-function nil)
  (setq org-link-frame-setup '((file . find-file)))

  ;;;; Super Agenda
    ;;;; Orb Babel Languages
    ;;;;; Active Babel languagevs
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


;;;;  Styling
(setq org-hidden-keywords '(title))
;; set basic title font
(set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)

))

;; Hooks


;; keybindings
(global-set-key (kbd "C-c a") (lambda () (interactive) (org-agenda) (evil-emacs-state)))
(global-set-key (kbd "C-c A") '(lambda () (interactive) (my/org-super-agenda) (evil-emacs-state)))
(defun org-agenda-sans-evil ()
  (interactive)
  (org-agenda)
  (evil-emacs-state)
  )

;; Move up and Down in Agenda
;; In the agenda evil doesn't work, because there are already other
;; keybindings like F for follow mode, map j/k as a compromise
(add-hook 'org-agenda-mode-hook (lambda ()
				;; (define-key org-agenda-mode-map "k" 'org-agenda-next-item)
				;; (define-key org-agenda-mode-map "k" 'org-agenda-previous-item)
				(define-key org-agenda-mode-map "j" 'evil-next-line)
				(define-key org-agenda-mode-map "k" 'evil-previous-line)
				(define-key org-agenda-mode-map (kbd "M-SPC" ) 'hydra-org-agenda/body)
				)
	)

(provide 'init-org)
;;; init-org.el ends here
