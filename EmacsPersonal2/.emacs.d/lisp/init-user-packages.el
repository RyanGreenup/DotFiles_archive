;;; init-user-packages.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;;;; Set up straight

(straight-use-package 'magit)
;;;; Download Evil
(straight-use-package 'evil)
(straight-use-package 'fzf)
(straight-use-package 'texfrag)

;;;; Helm
(straight-use-package 'helm) 
;; Import when idle because it takes 0.2 seconds
;; (run-with-idle-timer 1 nil (lambda () (helm-mode 1)(message "Enabled Helm Mode after Idle Time"))) 
;; (add-hook 'after-init-hook (lambda () (helm-mode 1)(message "Enabled Helm Mode after Idle Time")))
;;  ;; SLOW This takues 0.2 sec, 

(straight-use-package 'helm-swoop)
(straight-use-package 'helm-org-rifle)

;;;; Ivy
;; (straight-use-package 'ivy)
;; (straight-use-package 'counsel)
;; (straight-use-package 'swiper)


;;;; Themes
(straight-use-package 'dracula-theme
  :defer t) ;; SLOW adds 0.343 s to startups
(straight-use-package 'lab-themes)
(straight-use-package 'flucui-themes)
(straight-use-package 'material-theme)
(straight-use-package 'leuven-theme)
(setq custom-safe-themes t)
(defun apply-elegance-style ()
  (interactive)
  (require 'elegance)
)

;;;; Notes
(straight-use-package 'markdown-mode)

;;;; Git
(straight-use-package 'magit)
(straight-use-package 'git-timemachine)
(straight-use-package 'git-gutter)
(add-hook 'after-init-hook (global-git-gutter-mode +1))

;;;; Org
(straight-use-package 'org-superstar)

;;;; Programming
(straight-use-package 'eglot)
(straight-use-package 'ess)
(straight-use-package 'hl-todo)
(straight-use-package 'company)
(global-set-key (kbd "C-SPC") 'company-complete)
(add-hook 'after-init-hook 'global-company-mode)
;; (add-hook 'python-mode-hook 'eglot-ensure)
;; (add-hook 'ess-r-mode-hook 'eglot-ensure)
(add-hook 'prog-mode-hook 'eglot-ensure)
(add-hook 'prog-mode-hook 'hs-minor-mode)

;;;; Doom Modeline
;; (straight-use-package 'doom-modeline)
;; (straight-use-package 'all-the-icons)
;; (straight-use-package 'minions)

;;;; Shell
(straight-use-package 'vterm)

;;;; Profiling
(straight-use-package 'esup)

;;;; Keybindings
;;; Which Key
(straight-use-package 'which-key)
(add-hook 'after-init-hook (lambda ()
			     (which-key-mode 1)
			     ))

;;;;; Hydra
(straight-use-package 'hydra)

;;;; Outshine Mode
(straight-use-package 'outshine)
(add-hook 'prog-mode-hook '(lambda () (outshine-mode 1)))

;;; Golden Ratio Mode
(straight-use-package 'golden-ratio)
(add-hook 'prog-mode-hook '(lambda ()
			     (golden-ratio-mode 1)
			     (setq golden-ratio-extra-commands
				    (append golden-ratio-extra-commands
					    '(evil-window-left
						evil-window-right
						evil-window-up
						evil-window-down
						select-window-1
						select-window-2
						select-window-3
						select-window-4
						select-window-5)))
			     ))


(provide 'init-user-packages)
;;; init-user-packages.el ends here
