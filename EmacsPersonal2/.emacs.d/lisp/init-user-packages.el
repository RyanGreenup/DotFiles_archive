;;; init-user-packages.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Set up straight

;; Download Evil
(straight-use-package 'evil)
(straight-use-package 'fzf)
(straight-use-package 'texfrag)

;; Helm
(straight-use-package 'helm)
(straight-use-package 'helm-swoop)

;; Ivy
;; (straight-use-package 'ivy)
;; (straight-use-package 'counsel)
;; (straight-use-package 'swiper)


;; Themes
(straight-use-package 'dracula-theme)
(straight-use-package 'lab-themes)
(straight-use-package 'flucui-themes)
(straight-use-package 'material-theme)
(straight-use-package 'leuven-theme)
(setq custom-safe-themes t)
; (require 'elegance) ; Takes 1000 msSecond to apply



(provide 'init-user-packages)
;;; init-user-packages.el ends here
