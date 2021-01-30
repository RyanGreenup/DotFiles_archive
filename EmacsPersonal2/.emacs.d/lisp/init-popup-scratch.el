;;; init-popup-scratch.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(defvar init-is-pop-scratch)
(setq init-is-pop-scratch nil)
(defvar init-my-scratch-file "~/Sync/Scratch")
(defun pop-scratch ()
  "Pop up a scratch Buffer"
    (interactive)
    (if init-is-pop-scratch
        (close-popup-scratch)
        (open-popup-scratch)
    )
)

(defun open-popup-scratch ()
  (setq init-is-pop-scratch t)
  (find-file-noselect init-my-scratch-file)
  (popwin:popup-buffer "*scratch*")
)

(defun close-popup-scratch ()
  (setq init-is-pop-scratch nil)
  (popwin:close-popup-window)
  )


(provide 'init-popup-scratch)
;;; init-popup-scratch.el ends here
