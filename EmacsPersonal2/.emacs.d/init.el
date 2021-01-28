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

;; Load Package Manager
(require 'init-straight)
;; (require 'init-elpa)

(defun display-startup-echo-area-message ()
  (message (emacs-init-time)))


;; Load all packages
(require 'init-user-packages)

;; Configure Evil
(require 'init-evil)

;; Configure Helm
(require 'init-helm)
;;(require 'init-ivy)
 


;; Set Theme
(load-theme 'leuven-dark t)
