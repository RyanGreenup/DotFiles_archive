;;; init-helm.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(global-set-key (kbd "M-x") 'helm-M-x)
(evil-define-key 'normal 'global (kbd "<leader>ff") 'helm-find-files) ; Use helm
(evil-define-key 'normal 'global (kbd "<leader>fr") 'helm-recentf) ;; use helm
(evil-define-key 'normal 'global (kbd "<leader>ss") 'helm-swoop)
(evil-define-key 'normal 'global (kbd "<leader><return>") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-x r l") 'helm-filtered-bookmarks)



(provide 'init-helm)
;;; init-helm.el ends here
