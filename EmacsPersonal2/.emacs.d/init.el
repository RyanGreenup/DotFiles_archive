;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.
;; See https://github.com/purcell/emacs.d/blob/bf65ab24cb31a32add371a7bad5d391d02b5391d/init.el

;;; Code:
;; Set the load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;;; Garbage Collect and startup hacks at Idle
(require 'init-startup-gc)

;;;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
(setq debug-on-error t)


(add-hook 'after-init-hook (lambda ()

;;;; Load Package Manager
(require 'init-straight)

;; (require 'init-elpa)

(defun display-startup-echo-area-message ()
  (message (format "Starup Time: %s"(float-time
		  (time-subtract after-init-time before-init-time))
	   ) 
  )
)


;;;; Load all packages
(require 'init-user-packages)
(require 'init-keybindings)
(require 'init-change-theme-timer)

;;;; Configure Evil
(require 'init-evil)

;;;; Configure Helm
(require 'init-helm)
;; (require 'init-ivy)

;;;; Configure Org Mode
;; This contributes to a significant amount of startup time
;; do it after initializing
(add-hook 'after-init-hook
	  (lambda ()
		(require 'init-org)
	    )
	  ) ;; "HACK" This should be restructured inside init-org

(require 'init-texfrag)

;; Set default font and apply theme



    (message "Begining Post Initialisation Modifications")
    ;; (set-frame-font "Roboto Mono-10" nil t)
    (set-frame-font "Fira Code-10" nil t)
    ;; (set-frame-font "monofur-10" nil t)
    ;; (set-frame-font "Source Code Pro-10" nil t)
    ;; Toggle scroll bar and Toolbar 
    (toggle-scroll-bar -1) 
    (tool-bar-mode -1) 
    ;; (menu-bar-mode -1)  ;; I like the Menus actually


    (texfrag-global-mode 1) ;; TODO Move this in with helm
    (winner-mode 1) ;; TODO Move this in with helm
    ;; Set Theme
    (set-theme-for-time-of-day)





;; Doom Modeline
;; (require 'init-doom-modeline)

;; Hydra
(add-hook 'after-init-hook
	  (lambda ()
	    (require 'init-hydra)
	    )
	  )

;; Auto Save
;; Save when actually idle, this may get annoying though
;; (run-with-idle-timer 5 t 
;; 		     (lambda ()
;; 		       (save-buffer)
;; 		       (message "Saved")
;; 		       )
;; 		     )
;; compile hook
;; (add-hook 'after-save-hook '(lambda () (byte-recompile-directory "~/.emacs.d/lisp")) t t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-source-names-using-follow '("Buffers")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

))

