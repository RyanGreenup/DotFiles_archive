;;; init-startup-gc.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;; https://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
;; https://emacs.stackexchange.com/questions/34342/is-there-any-downside-to-setting-gc-cons-threshold-very-high-and-collecting-ga
;; https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
;;; Code:


;; Track when garbage collects
(setq DEBUG t)
(when DEBUG
(message "Debugging Enabled in %s" buffer-file-name)
(set 'garbage-collection-messages t)
(add-hook 'post-gc-hook
	  (lambda ()
	  (message "Garbage Collected")
	  (message "%s Seconds Spent on GC So far" gc-elapsed)
	  (message "%s GC's completed So far" gcs-done)
	  )
	  )
)
;; Typically when I first startup emacs, I end up garbage collecting 


(provide 'init-startup-gc)
;;; init-startup-gc.el ends here
