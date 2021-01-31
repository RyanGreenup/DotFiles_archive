;;; init-texfrag.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq texfrag-subdir "/tmp/texfrag/")
(setq texfrag-scale 1)

(defun texfrag-force-preview-at-point ()
  (interactive)
  (defvar original-major-mode)
  (setq original-major-mode major-mode)
  (message "was in %s\n" original-major-mode)
  (org-mode)
  (preview-at-point)
  (message "now in %s\n" major-mode)
  (with-current-buffer (current-buffer)
  (funcall original-major-mode))
  (message "Back to %s" major-mode)
  )

(provide 'init-texfrag)
;;; init-texfrag.el ends here
