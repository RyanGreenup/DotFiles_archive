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


;;;; Load Package Manager
(require 'init-straight)

    ;; (require 'init-elpa)

    (defun display-startup-echo-area-message ()
      (print-time-delta)
      )


(defun print-time-delta ()
  (interactive)
(message (format "Init Time:\n---> %s\n Final Startup Time (post after-init-hook):\n---> %s\n"
		     (float-time (time-subtract after-init-time before-init-time))
		     (float-time (time-subtract (current-time) before-init-time))
		) 
    )
  )


;;;; Load all packages
    (require 'init-user-packages)
    (require 'init-keybindings)
    (require 'init-change-theme-timer)
    (message "All Packages Loaded")
(require 'org)
(add-hook 'after-org-mode (message "org loaded"))
;;;; Load Org Lazy

(defvar org-startedQ nil)
(setq org-startedQ nil)


(defun init-org-fun ()
  (interactive)
  (when (not org-startedQ) 
      (setq org-startedQ t)
      (message "Org mode has been triggered, running all the after-org stuff")
      (require 'init-org)
      (require 'org-ref)
      (require 'init-org-publish)
      (require 'init-org-super-agenda) 
      (use-package org-roam-server
      :straight t
      :ensure t
      :config
      (setq org-roam-server-host "127.0.0.1"
            org-roam-server-port 8080
            org-roam-server-authenticate nil
            org-roam-server-export-inline-images t
            org-roam-server-serve-files nil
            org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
            org-roam-server-network-poll t
            org-roam-server-network-arrows nil
            org-roam-server-network-label-truncate t
            org-roam-server-network-label-truncate-length 60
            org-roam-server-network-label-wrap-length 20))
    				  ;; after-org
    
      (require 'init-hydra)
      (message "loaded all the crap")
	)
  )

(add-hook 'org-mode-hook (lambda ()
			   (display-line-numbers-mode)
			   (init-org-fun)
			   (message "hey")

			   ))
			      

(yas-global-mode 1)             ;; TODO company and yasnippet should
(global-company-fuzzy-mode 1)	;; be in an after-prog-mode not after org
				;; Tis is needed for good M-e in terminal

;;;; Interface
;;;;;; Which key
(require 'init-which-key)
;;;;;; Scrolling
    ;; scroll one line at a time (less "jumpy" than defaults)
(require 'init-smooth-scrolling)

;;;;;; Configure Evil
    (require 'init-evil)
    (winner-mode 1) 

;;;;;; Configure Helm
    (require 'init-helm)
    ;; (require 'init-ivy)

;;;;;; Popup Scratch Buffer
    (require 'init-popup-scratch)

;;;;;; Open in External program
(require 'init-open-in-external-program)
;;;; Configure LaTeX Mode
(require 'init-latex)
;;;; Configure Org Mode
    ;; This contributes to a significant amount of startup time
    (require 'init-texfrag)


;;;; Programming
(require 'init-ess)
;;;; Set default font and apply theme
	;; Set Theme
	(set-theme-for-time-of-day)
;;;; Hydra

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






;;;; Run once When Idle (Trivial Things Only)
;;;;; 1 Second
(run-with-idle-timer 1 nil
    (lambda ()
	(evil-escape-mode 1)			;; ~0.1 s
	(message "Idle Timer 1 Second: Begining Post Initialisation Modifications")
						;; (set-frame-font "Roboto Mono-10" nil t)
	(set-frame-font "Fira Code-10" nil t)	;; ~ 0.1 s
						;; (set-frame-font "monofur-10" nil t)
						;; (set-frame-font "Source Code Pro-10" nil t)
						;; Toggle scroll bar and Toolbar 
	(toggle-scroll-bar -1)			;; ! 0.1 s
	(tool-bar-mode -1)			;; ! 0.1 s
        (menu-bar-mode -1)                      ;; I like the Menus actually so toggle with <SPC t SPC>
    )
    )
;;;;; 3 Second
;; Load Org mode so it's ready after some delay

(defvar init-org-idle-load 3)
(run-with-idle-timer init-org-idle-load nil
		     (lambda ()
		       (message "\n---\nIdle Timer of %s seconds:\n\t Loading Org\n---\n" init-org-idle-load)
		       ;; Load Index and Todo
		       (find-file-noselect "~/Notes/Org/index.org")
		       (find-file-noselect "~/Notes/Org/agenda/todo.org")
		       (require 'org-ref)
		       (org-reload)
		       ;; Build Agenda
			 (org-agenda-list)
			 (delete-window)
		       )
		     )
;;;;; 4 Second


;;;;; Modeline 
(require 'init-telephone-line)        ;; Loads Quick and feels fine
;; (require 'init-spacemacs-modeline) ;; takes 1.2 seconds at startup
;; (require 'init-doom-modeline)      ;; FIXME The doom modeline cripples
				      ;; the performance of org-mode
				      ;; files, this can be seen by a
				      ;; side by side comparison of two
				      ;; org files using follow mode, one
				      ;; without the modeline.

(run-with-idle-timer 3 nil (lambda ()
;; EMPTY
)
)


;; This gets annoying so turn it off after launch
(setq debug-on-error nil)


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


