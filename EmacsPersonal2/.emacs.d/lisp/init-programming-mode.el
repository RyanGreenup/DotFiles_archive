;;; init-programming-mode.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;; This doesn't work, the prog-mode hook is triggered at init, meaning
;; yas is still enabled taking 0.3 seconds, but, it is hidden from esup.

;; Solution, hmm, what if C-SPC at first evaluated after-prog and then switched to
;; it's default binding? a bit of a hack but it is definitely lazy loading
;; and it would solve the problem.

;;;; After Programming Mode

;; (add-hook 'prog-mode-hook  #'after-prog) ;; TODO This is triggered too early

(defun after-prog ()
  (interactive)
"A function that will run once after a programming mode is started.
This function is called by a 'progs-mode-hook' and
removes that hook after running. 

The idea is to delay an action until after 'prog-mode' has been
started, in order to reduce startup times.

Ideally this function should also be run after an idle timer as well."
    (message "started evaluating after-progs-functions")
    (remove-hook 'prog-mode-hook	#'after-prog)

    ;; Things to evaluate after prog go here↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

;;;;; Begin After programming mode
;;;;;; Company
    (global-unset-key (kbd "C-SPC"))
    (global-set-key (kbd "C-SPC") 'company-complete)
    (global-set-key (kbd "C-S-SPC") 'company-yasnippet)
    (global-set-key (kbd "C-c s") 'company-yasnippet) 
    (setq company-tooltip-idle-delay 0)              ;; This can cause slow downs
    (setq company-idle-delay 0)                      ;; on a lean emacs it's really nice though
    (global-company-mode 1)

    (global-company-fuzzy-mode 1)
;;;;;;; Fuzzy
    (setq company-fuzzy-sorting-backend 'flx)
    (setq company-require-match nil) ;; this needs to be disabled for fuzzy to make sense
    (global-company-fuzzy-mode 1)
;;;;;; YaSnippet
    (yas-global-mode 1)

;;;;; End After Programming Mode
    (message "Finished evaluating after-progs-functions")
)


;;;; Hooks
(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'julia-mode-hook '(lambda () (eglot-jl-init) (eglot-ensure)))
(add-hook 'ess-r-mode-hook (lambda ()
			     (eglot-ensure)  
			     (when (require 'helm nil 'noerror)
			       (helm-mode -1)
			       )
			     )
	  )      ;; helm-mode breaks ess-r so disable it
;; (add-hook 'prog-mode-hook 'eglot-ensure)
(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook 'outshine-mode)


(after-prog)
(provide 'init-programming-mode)
;;; init-programming-mode.el ends here



