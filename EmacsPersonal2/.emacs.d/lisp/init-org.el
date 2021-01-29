;;; init-org.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Use Superstar Mode for Leading Stars
;; SLOW ; This  may cause issue
(add-hook 'org-mode-hook
          (lambda ()
            (org-superstar-mode 1))
          (lambda ()
            (texfrag-mode 1))
	  )


(provide 'init-org)
;;; init-org.el ends here
