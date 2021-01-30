
;;; init-keybindings.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; (global-set-key (kbd "C-RET") (lambda () (message "Yeah It's working"))
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-c C-p C-p") 'texfrag-force-preview-at-point)


(provide 'init-keybindings)
;;; init-keybindings.el ends here
