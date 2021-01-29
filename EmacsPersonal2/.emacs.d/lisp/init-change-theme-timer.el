
;;; init-change-theme-timer.el.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(run-at-time "10:58" nil #'dark-theme)

(defun dark-theme ()
  "Change to Dark Theme"
  (
   (load-theme 'leuven-dark t)
   )
  )


(provide 'init-change-theme-timer.el)
;;; init-change-theme-timer.el.el ends here
