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
(setq debug-on-error nil)


;;;; Run After Initialisation
(add-hook 'after-init-hook (lambda ()

;;;;; Load Package Manager
    (require 'init-straight)

    ;; (require 'init-elpa)

    (defun display-startup-echo-area-message ()
      (message (format "Init Time:\n---> %s\n Final Startup Time (post after-init-hook):\n---> %s\n"
		     (float-time (time-subtract after-init-time before-init-time))
		     (float-time (time-subtract (current-time) before-init-time))
		) 
    )
    )


;;;;; Load all packages
    (require 'init-user-packages)
    (require 'init-keybindings)
    (require 'init-change-theme-timer)

;;;;; Configure Evil
    (require 'init-evil)

;;;;; Configure Helm
    (require 'init-helm)
    ;; (require 'init-ivy)

;;;;; Popup Scratch Buffer
    (require 'init-popup-scratch)

;;;;; Configure Org Mode
    ;; This contributes to a significant amount of startup time
    (require 'init-org)
    (require 'init-org-super-agenda) 
    (require 'init-texfrag)


;;;;; Set default font and apply theme
	(texfrag-global-mode 1) ;; TODO Move this in with helm
	(winner-mode 1) ;; TODO Move this in with helm
	;; Set Theme
	(set-theme-for-time-of-day)





;;;;; Doom Modeline
    ;; This causes major scrolling and performance issues in org-mode
    ;; (require 'init-doom-modeline)
    ;; (require 'init-spacemacs-modeline) ;; TODO Does this slow down org buffers like doom?

;;;;; Hydra
(require 'init-hydra)

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




))


;;;; Run When Idle (Trivial Things Only)
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
						;; (menu-bar-mode -1)  ;; I like the Menus actually
    )
    )
;;;;; 2 Second
;; Load Org mode so it's ready after some delay

(defvar init-org-idle-load 2)
(run-with-idle-timer init-org-idle-load nil
		     (lambda ()
		       (message "\n---\nIdle Timer of %s seconds:\n\t Loading Org\n---\n" init-org-idle-load)
		       ;; Load Index and Todo
		       (find-file-noselect "~/Notes/Org/index.org")
		       (find-file-noselect "~/Notes/Org/agenda/todo.org")
		       ;; Build Agenda
			 (org-agenda-list)
			 (delete-window)
		       )
		     )
;;;;; 3 Second


;;;; Smooth Scrolling
    ;; scroll one line at a time (less "jumpy" than defaults)
(require 'init-smooth-scrolling)

