;;; darkroom-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "darkroom" "darkroom.el" (0 0 0 0))
;;; Generated autoloads from darkroom.el

(autoload 'darkroom-mode "darkroom" "\
Remove visual distractions and focus on writing. When this
mode is active, everything but the buffer's text is elided from
view. The buffer margins are set so that text is centered on
screen. Text size is increased (display engine allowing) by
`darkroom-text-scale-increase'.

\(fn &optional ARG)" t nil)

(autoload 'darkroom-tentative-mode "darkroom" "\
Enters `darkroom-mode' when all other windows are deleted.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "darkroom" '("darkroom-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; darkroom-autoloads.el ends here
