;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.
;; See https://github.com/purcell/emacs.d/blob/bf65ab24cb31a32add371a7bad5d391d02b5391d/init.el

;;; Code:

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
(setq debug-on-error t)

(let ((minver "24.5"))
  (when (version< emacs-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version< emacs-version "25.1")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


;; Garbage Collect and startup hacks at Idle
(require 'init-startup-gc)

;; Load Package Manager
(require 'init-straight)
;; (require 'init-elpa)

(defun display-startup-echo-area-message ()
  (message (emacs-init-time)))


;; Load all packages
(require 'init-user-packages)
;; (require 'init-change-theme-timer)

;; Configure Evil
(require 'init-evil)

;; Configure Helm
(require 'init-helm)
;; (require 'init-ivy)

;; Configure Org Mode
(require 'init-org)

 

;; Set default font
(run-with-idle-timer 1 nil (lambda ()
				;; (set-frame-font "Roboto Mono-10" nil t)
				(set-frame-font "Fira Code-10" nil t)
				;; (set-frame-font "monofur-10" nil t)
				;; (set-frame-font "Source Code Pro-10" nil t)
				(message "Changed Font after Idle Time")
				;; Toggle scroll bar and Toolbar 
				(toggle-scroll-bar -1) 
				(tool-bar-mode -1) 
				;; (menu-bar-mode -1)  ;; I like the Menus actually

				;; Set Theme
			    )
		     ) 

(load-theme 'misterioso t)


;; compile hook
;; (add-hook 'after-save-hook '(lambda () (byte-recompile-directory "~/.emacs.d/lisp")) t t)

