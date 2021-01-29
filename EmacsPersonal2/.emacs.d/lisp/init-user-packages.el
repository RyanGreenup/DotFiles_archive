;;; init-user-packages.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Set up straight

(straight-use-package 'magit)
;; Download Evil
(straight-use-package 'evil)
(straight-use-package 'fzf)
(straight-use-package 'texfrag)

;; Helm
(straight-use-package 'helm) 
;; Import when idle because it takes 0.2 seconds
;; (run-with-idle-timer 1 nil (lambda () (helm-mode 1)(message "Enabled Helm Mode after Idle Time"))) 
(add-hook 'after-init-hook (lambda () (helm-mode 1)(message "Enabled Helm Mode after Idle Time")))
;;  ;; SLOW This takues 0.2 sec, 

(straight-use-package 'helm-swoop)
(straight-use-package 'helm-org-rifle)

;; Ivy
;; (straight-use-package 'ivy)
;; (straight-use-package 'counsel)
;; (straight-use-package 'swiper)


;; Themes
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

;; Notes
(straight-use-package 'markdown-mode)

;; Git
(straight-use-package 'magit)
(straight-use-package 'git-timemachine)


;; Org
(straight-use-package 'org-superstar)

;; Programming
(straight-use-package 'eglot)
(straight-use-package 'ess)
(straight-use-package 'chess)
(straight-use-package 'company)
(global-set-key (kbd "C-SPC") 'company-complete)
(add-hook 'after-init-hook 'global-company-mode)
;; (add-hook 'python-mode-hook 'eglot-ensure)
;; (add-hook 'ess-r-mode-hook 'eglot-ensure)
(add-hook 'prog-mode-hook 'eglot-ensure)
(add-hook 'prog-mode-hook 'hs-minor-mode)

;; Doom Modeline
(straight-use-package 'doom-modeline)
(straight-use-package 'all-the-icons)



(provide 'init-user-packages)
;;; init-user-packages.el ends here
