;;; init-ivy.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; (global-set-key (kbd "M-x") 'ivy-M-x)
(evil-define-key 'normal 'global (kbd "<leader>ff") 'counsel-find-file) ; Use ivy
(evil-define-key 'normal 'global (kbd "<leader>fr") 'consult-recent-files) ;; use ivy

;; (ivy-mode 1)

(provide 'init-ivy)
;;; init-ivy.el ends here
