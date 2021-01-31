
;;; init-keybindings.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; (global-set-key (kbd "C-RET") (lambda () (message "Yeah It's working"))
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x w") 'count-words)
(global-set-key (kbd "C-c C-p C-p") 'texfrag-force-preview-at-point)

(global-set-key (kbd "M-p")  'move-line-up)
(global-set-key (kbd "M-n")  'move-line-down)

;; Org Agenda
(global-set-key (kbd "C-c a") (lambda () (interactive) (org-agenda) (evil-emacs-state)))
(global-set-key (kbd "C-c A") '(lambda () (interactive) (my/org-super-agenda) (evil-emacs-state)))
(global-set-key (kbd "C-c v") 'my-open-current-file-in-vim)
;; (global-set-key (kbd "C-c s") 'company-yasnippet) ;; TODO



(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(provide 'init-keybindings)
;;; init-keybindings.el ends here
