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
(run-with-idle-timer 3 t '(lambda () (helm-mode 1))) 
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
;; (require 'elegance) ; Takes 1000 msSecond to apply

;; Notes
(straight-use-package 'markdown-mode)

;; Git
(straight-use-package 'magit)

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

;; Set default font
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 110
                    :weight 'normal
                    :width 'normal)


(provide 'init-user-packages)
;;; init-user-packages.el ends here
