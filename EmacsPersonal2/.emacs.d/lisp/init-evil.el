;;; init-evil.el --- Load the Evil Layer and Leader  keys   ---
;;; Commentary:
;;; Code:



;; Enable Evil
(setq evil-want-C-u-scroll t)
(evil-mode)

;; Leader Keys
(evil-set-leader 'normal (kbd "SPC"))
(evil-set-leader 'insert (kbd "M-SPC"))
(evil-set-leader 'visual (kbd "M-SPC"))
(evil-set-leader 'replace (kbd "M-SPC"))
(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
(evil-define-key 'normal 'global (kbd "<leader>fz") 'fzf) 
(evil-define-key 'normal 'global (kbd "<leader>wv") 'evil-window-vsplit)
(evil-define-key 'normal 'global (kbd "<leader>ws") 'evil-window-split)
(evil-define-key 'normal 'global (kbd "<leader>wd") 'evil-quit)
(evil-define-key 'normal 'global (kbd "<leader>wl") 'evil-window-right)
(evil-define-key 'normal 'global (kbd "<leader>wh") 'evil-window-left)
(evil-define-key 'normal 'global (kbd "<leader>wj") 'evil-window-down)
(evil-define-key 'normal 'global (kbd "<leader>wk") 'evil-window-up)
(evil-define-key 'normal 'global (kbd "<leader>bp") 'previous-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bn") 'next-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bd") 'kill-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bD") 'kill-buffer-and-window)
(evil-define-key 'normal 'global (kbd "<leader>fy") 'My-Copy-File-Path)
;; (evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file) ; Use helm
(evil-define-key 'normal 'global (kbd "<leader>ht") 'load-theme)
(evil-define-key 'normal 'global (kbd "<leader>hrt") 'reset-theme)
(evil-define-key 'normal 'global (kbd "<leader>fr") 'consult-recent-file)
(evil-define-key 'normal 'global (kbd "<leader>fp") 'open-local-config)
(setq vc-follow-symlinks t) ;; Must follow for version control to work
(evil-define-key 'normal 'global (kbd "<leader>SPC") 'projectile--find-file)
(evil-define-key 'normal 'global (kbd "<leader>gs") 'magit-stage)
(evil-define-key 'normal 'global (kbd "<leader>gS") 'magit-stage-file)
(evil-define-key 'normal 'global (kbd "<leader>gc") 'magit-commit)
(evil-define-key 'normal 'global (kbd "<leader>bb") 'helm-buffers-list)
(evil-define-key 'normal 'global (kbd "<leader>nrf") 'org-roam-find-file)
(evil-define-key 'normal 'global (kbd "<leader>nri") 'org-roam-insert)
(evil-define-key 'normal 'global (kbd "<leader>'") 'helm-resume)
(evil-define-key 'normal 'global (kbd "<leader>'") 'helm-resume)
(evil-define-key 'normal 'global (kbd "<leader>wu") 'winner-undo)
(evil-define-key 'normal 'global (kbd "<leader>wU") 'winner-redo)
(evil-define-key 'normal 'global (kbd "<leader>zns") 'org-narrow-to-subtree)
(evil-define-key 'normal 'global (kbd "<leader>znb") 'org-narrow-to-block)
(evil-define-key 'normal 'global (kbd "<leader>zne") 'org-narrow-to-element)
(evil-define-key 'normal 'global (kbd "<leader>znp") 'narrow-to-page)
(evil-define-key 'normal 'global (kbd "<leader>znd") 'narrow-to-defun)
(evil-define-key 'normal 'global (kbd "<leader>znn") 'narrow-to-region)
(evil-define-key 'normal 'global (kbd "<leader>znw") 'widen)




(defun reset-theme ()
  "Unload the theme"
  (interactive)
  (save-window-excursion
    (eval (mapc 'disable-theme custom-enabled-themes) t)
    )
  )


(defun open-local-config ()
  (interactive)
  (find-file "~/.emacs.d/init.el")
  )

(defun My-Copy-File-Path ()
  (interactive)
  (save-window-excursion
(kill-new
            (shell-quote-argument buffer-file-name))

(message
            (shell-quote-argument buffer-file-name))
))


;; KBD
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
(set 'org-return-follows-link t)


(provide 'init-evil)
;;; init-evil.el ends here
