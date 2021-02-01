;;; eval-after-load-org.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;; This contains a function that runs only once after opening an org buffer
;;; Code:

;;;; Define Variables
;;;;; Variable to track that this only runs once
(defvar has-org-mode-startedQ nil
  "A boolean value indicating whether an 'org-mode ' buffer has been visited.")

;;;;; List of Functions to evaluate
(defvar after-org-functions nil
"A List of Functions that will be evaluated after visiting an org mode buffer.
This list is aced upon by the after-org-function")
(setq after-org-functions nil)

;;;; Add Hook
(add-hook 'org-mode-hook (lambda ()
			    (after-org after-org-functions)
			   ))


;;;; Function to evaluate each function in list
(push #'initial-message after-org-functions)
(defun initial-message ()
  (message "started evaluating after-org-functions")
  )
  
(defun after-org (list-of-functions)
"A function that will run once after org mode is started.
This function utilises an after 'org-mode' hook accepts a
list (LIST-OF-FUNCTIONS), this list will contain functions that
are each evaluated, the idea being that this list can be
populated throughout the init file in order to delay an action
until after 'org-mode' has been started, in order to reduce startup
times.  Ideally this function should also be run after an idle
timer as well."
 (when (not has-org-mode-startedQ)
      (setq has-org-mode-startedQ t)
	  (while list-of-functions					;; While loop
	    (funcall (car list-of-functions))			;; Print the first term
	    (setq list-of-functions (cdr list-of-functions))))	;; Drop the First term
      (message "Finished Loading after-org functions")
      )



;; (after-org (1 2 3))




(provide 'eval-after-load-org)
;;; eval-after-load-org.el ends here
