;;; init-ivy.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Straight Packages
(straight-use-package 'ivy)
(straight-use-package 'counsel)
(straight-use-package 'swiper)
(straight-use-package 'ivy-posframe)

;;; Code:

;;;; M-x
(global-set-key (kbd "M-x") 'counsel-M-x)

;;;; Evil Bindings

;;;;; Swoop

(evil-define-key 'normal 'global (kbd "<leader>ss") 'swiper)

;;;;; Bookmarks
(evil-define-key 'normal 'global (kbd "<leader><return>") 'counsel-bookmark)


;;;;; Files
(evil-define-key 'normal 'global (kbd "<leader>ff") 'counsel-find-file) ; Use ivy
(evil-define-key 'normal 'global (kbd "<leader>fr") 'consult-recent-files) ;; use ivy
(straight-use-package 'ivy-posframe)
(ivy-posframe-mode)


(ivy-mode 1)
(provide 'init-ivy)
;;; init-ivy.el ends here
