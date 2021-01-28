;;; init-user-packages.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Set up straight

;; Download Evil
(straight-use-package 'evil)
(straight-use-package 'texfrag)

;; Helm
;; (straight-use-package 'helm)
;; (straight-use-package 'helm-swoop)

;; Ivy
(straight-use-package 'ivy)
(straight-use-package 'counsel)
(straight-use-package 'swiper)




(provide 'init-user-packages)
;;; init-user-packages.el ends here
