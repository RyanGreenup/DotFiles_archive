;;; hydra-window.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defhydra hydra-window-menu ()
  "
    Movement^   ^Split^         ^Switch^       ^^^Resize^         ^Window Purpose^
    ------------------------------------------------------------------------------------------------------
    _h_ ←        _|_ vertical    ^_b_uffer       _<left>_  X←     choose window _P_urpose
    _j_ ↓        _-_ horizontal  ^_f_ind files   _<down>_  X↓     switch to _B_uffer w/ same purpose
    _k_ ↑        _u_ undo        ^_a_ce window   _<up>_    X↑     Purpose-dedication(_!_)
    _l_ →        _r_ reset       ^_s_wap         _<right>_ X→     Buffer-dedication(_#_)
    ^^^^^^^                                      _M_aximize
    ^^^^^^^                                      _d_elete
    _x_ M-x      _q_ quit
    "
  ("h" windmove-left)
  ("j" windmove-down)
  ("k" windmove-up)
  ("l" windmove-right)
  ("|" (lambda ()
         (interactive)
         (split-window-right)
         (windmove-right)))
  ("-" (lambda ()
         (interactive)
         (split-window-below)
         (windmove-down)))
  ("u" (progn
         (winner-undo)
         (setq this-command 'winner-undo)))
  ("r" winner-redo)
  ("b" helm-source-buffers-list)
  ("f" helm-find)
  ("a" (lambda ()
         (interactive)
         (ace-window 1)
         (add-hook 'ace-window-end-once-hook
                   'hydra-window/body)))
  ("s" (lambda ()
         (interactive)
         (ace-swap-window)
         (add-hook 'ace-window-end-once-hook
                   'hydra-window/body)))
  ("<left>" hydra-move-splitter-left)
  ("<down>" hydra-move-splitter-down)
  ("<up>" hydra-move-splitter-up)
  ("<right>" hydra-move-splitter-right)
  ("M" delete-other-windows)
  ("d" delete-window)

  ("P" purpose-set-window-purpose)
  ("B" ivy-purpose-switch-buffer-with-purpose)
  ("!" purpose-toggle-window-purpose-dedicated)
  ("#" purpose-toggle-window-buffer-dedicated)

  ;; ("K" ace-delete-other-windows)
  ;; ("S" save-buffer)
  ;; ("d" delete-window)
  ;; ("D" (lambda ()
  ;;        (interactive)
  ;;        (ace-delete-window)
  ;;        (add-hook 'ace-window-end-once-hook
  ;;                  'hydra-window/body))
  ;;  )

  ("x" counsel-M-x)
  ("q" nil)
  )
(global-set-key (kbd "<f1>") 'hydra-window-menu/body)


(provide 'hydra-window)
;;; hydra-window.el ends here
