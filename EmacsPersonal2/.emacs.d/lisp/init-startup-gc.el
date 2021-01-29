;;; init-startup-gc.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
    
;;; Commentary:
;; look at these links:
;; https://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
;; https://emacs.stackexchange.com/questions/34342/is-there-any-downside-to-setting-gc-cons-threshold-very-high-and-collecting-ga
;; https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/

;; I found I was garbage collecting about 100 times per "action" I
;; would undertake, e.g. open an org file,swoop through it, edit
;; some babel,this would be about 100 GC so I've gon from 800KB ->
;; 100 MB Set high GC for startup

;; Making this change the total time (gc-elapsed) spent doing GC went down from ~1 sec to 0.02 sec (with 4 GC's)

;;; Code:
(defvar startup-DEBUG nil
  "Whether or not Garbage Collection should be printed."
  )

;; Set startup GC
(setq gc-cons-threshold (* 500 1024 1024 ))

(setq file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Reset GC after starting
;; Use idle timer not hook so the user doesn't wait for it
(run-with-idle-timer
 3 nil
 (lambda ()
   (setq gc-cons-threshold (* 800 1000 150))
   (setq file-name-handler-alist file-name-handler-alist-original)
   (message "gc-cons-threshold and file-name-handler-alist restored, see init-startup-gc.el")))

;; Garbage Collect when idle
(run-with-idle-timer 2 t (lambda () (garbage-collect)))


;; Track when garbage collects
(when startup-DEBUG
(message "Debugging Enabled in %s" buffer-file-name)
(set 'garbage-collection-messages t)
(add-hook 'post-gc-hook
	  (lambda ()
	  (message "Garbage Collected")
	  (message "%s Seconds Spent on GC So far" gc-elapsed)
	  (message "%s GC's completed So far" gcs-done)
	  (message "Threshold: %s MB" (/ gc-cons-threshold 1000000))
	  )
	  )
)
;; Typically when I first startup emacs, I end up garbage collecting 


(provide 'init-startup-gc)
;;; init-startup-gc.el ends here
