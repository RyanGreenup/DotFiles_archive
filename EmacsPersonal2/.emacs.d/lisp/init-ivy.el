;;; init-ivy.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; (global-set-key (kbd "M-x") 'ivy-M-x)
(evil-define-key 'normal 'global (kbd "<leader>ff") 'counsel-find-file) ; Use ivy
(evil-define-key 'normal 'global (kbd "<leader>fr") 'consult-recent-files) ;; use ivy
(evil-define-key 'normal 'global (kbd "<leader>fz") 'counsel-fzf) ;; use ivy
(evil-define-key 'normal 'global (kbd "<leader>/") 'counsel-rg) ;; use ivy
(evil-define-key 'normal 'global (kbd "<leader>fd") 'counsel-fd) ;; use ivy
(evil-define-key 'normal 'global (kbd "<leader>ss") 'swiper) ;; use ivy
(global-set-key (kbd "M-x") 'counsel-M-x)


(setq helm-swoop-pre-input-function (lambda () ""))
;; C-M-p and C-M-n should work like follow mode







;; (ivy-mode 1)

(provide 'init-ivy)
;;; init-ivy.el ends here
