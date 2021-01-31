;;; init-org.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-tags-column 80)
(setq org-agenda-files '("~/Notes/Org/agenda/"))


;;; Periodically When Idle
;; Maybe Rebuild Org-Agenda?
;;; Styling
;; (require 'init-org-heading-latex-style)

;; (custom-set-faces
;;   '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
;;   '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
;;   '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
;;   '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
;;   '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
;; )


;; (org-mode)
;; ;; Styling must be evaluated before
;; (setq org-hidden-keywords '(title))
;; ;; set basic title font
;; (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
;; ;; Low levels are unimportant => no scaling
;; (set-face-attribute 'org-level-7 nil  :inherit 'org-level-8)
;; (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
;; (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
;; (set-face-attribute 'org-level-4 nil :inherit 'org-level-8)
;; ;; Top ones get scaled the same as in LaTeX (\large, \Large, \LARGE)
;; (set-face-attribute 'org-level-3 nil :family 'unspecified :inherit 'org-level-8 :height 1.2) ;\large
;; (set-face-attribute 'org-level-2 nil :family 'unspecified :inherit 'org-level-8 :height 1.44) ;\Large
;; (set-face-attribute 'org-level-1 nil :family 'unspecified :inherit 'org-level-8 :height 1.728) ;\LARGE
;; ;; Only use the first 4 styles and do not cycle.
;; (setq org-cycle-level-faces nil)
;; (setq org-n-level-faces 4)
;; ;; Document Title, (\huge)
;; (set-face-attribute 'org-document-title nil
;;                     :height 2.074
;;                     :foreground "Liberation Serif"
;;                     :inherit 'org-level-8)


;;; After loading org
(with-eval-after-load 'org (lambda ()

(texfrag-global-mode 1)  ;; Load globally here, it throws an error at init
			    ;; and I mostly use it in org-mode anyway

;;;;; Appearance
(setq org-display-inline-images t)
(setq org-redisplay-inline-images t)
(setq org-startup-with-inline-images "inlineimages")
(setq org-hide-emphasis-markers t)
(setq org-confirm-elisp-link-function nil)
(setq org-link-frame-setup '((file . find-file)))

;;;; Orb Babel Languages
;;;;; Active Babel languagevs
(org-babel-do-load-languages
'org-babel-load-languages
'((R           . t)
    (latex       . t)
    (python      . t)
    ;; (mongo       . t) ;; TODO Should I set this up?
    (sqlite      . t)
    (plantuml    . t)
    (dot         . t)
    (gnuplot     . t)
    (asymptote   . t)
    (java        . t)
    ;; (javascript  . t) ;; TODO
    (sed         . t)
    (shell       . t)
    ;; (mathematica . t)
    (emacs-lisp  . t)))
;;;;;; Don't Ask
(defun my-org-confirm-babel-evaluate (lang body)
  (not (member lang '("C" "bash" "java" "javascript" "latex" "plantuml" "sqlite" "python" "ipython" "r" "R" "julia" "clojure" "sh"))))
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
;;;;;; Set up Plant UML
(setq org-plantuml-jar-path (expand-file-name "/bin/plantuml.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))


;;;; Keybindings
;;;;; Agenda
;; Move up and Down in Agenda
;; In the agenda evil doesn't work, because there are already other
;; keybindings like F for follow mode, map j/k as a compromise
(define-key org-agenda-mode-map "j" 'evil-next-line)
(define-key org-agenda-mode-map "k" 'evil-previous-line)
(define-key org-agenda-mode-map (kbd "M-SPC" ) 'hydra-org-agenda/body)






;;;; End After Loading Org
))

;;; Hooks
;; Use Superstar Mode for Leading Stars
;; SLOW ; Superstar mode is slightly slower
(add-hook 'org-mode-hook (lambda ()
			   (org-superstar-mode 1)
			    ; I'm hapy with the defaults
			    ;(setq org-superstar-headline-bullets-list '(" ")) ;; '("🞛" "◉" "○" "▷")
			    ;; (setq org-superstar-item-bullet-alist
			    ;;        '((?+ . ?•)
			    ;;          (?* . ?➤)
			    ;;          (?- . ?–)))
			    ;; (setq org-superstar-remove-leading-stars nil) ; This removes the indent
						    (texfrag-mode 1)
			   ))
;;;; Prettify Fonts
;; This has to be done as a hook
(add-hook 'org-mode-hook (lambda ()
   "Beautify Org Checkbox Symbol"
   (push '("[ ]" .  "☐") prettify-symbols-alist)
   (push '("[X]" . "☑" ) prettify-symbols-alist)
   (push '("[-]" . "❍" ) prettify-symbols-alist)
   (push '("#+begin_src" . "✨" ) prettify-symbols-alist)
   (push '("#+BEGIN_SRC" . "✨" ) prettify-symbols-alist)
   (push '("#+end_src" .   "✨" ) prettify-symbols-alist)
   (push '("#+END_SRC" .   "✨" ) prettify-symbols-alist)
   (push '("#+begin_quote" . "➲" ) prettify-symbols-alist)
   (push '("#+BEGIN_QUOTE" . "➲ " ) prettify-symbols-alist)
   (push '("#+end_quote" .   "➲" ) prettify-symbols-alist)
   (push '("#+END_QUOTE" .   "➲" ) prettify-symbols-alist)
   (push '("#+begin_comment" . "✀ " ) prettify-symbols-alist)
   (push '("#+BEGIN_COMMENT" . "✀" ) prettify-symbols-alist)
   (push '("#+end_comment" .   "✀") prettify-symbols-alist)
   (push '("#+END_COMMENT" .   "✀") prettify-symbols-alist)
   (push '("#+attr_html: :width" .   "?⇔🌍") prettify-symbols-alist)
   (push '("#+attr_html: :width" .   "?⇔🌍") prettify-symbols-alist)
   (push '("#+attr_latex: :width" .   "🖺") prettify-symbols-alist)
   (push '("#+ATTR_LATEX: :width" .   "🖺") prettify-symbols-alist)
   (push '("#+caption:" .   "✎") prettify-symbols-alist)
   (push '("#+CAPTION:" .   "✎") prettify-symbols-alist)
   (push '("#+caption:" .   "✎") prettify-symbols-alist)
   (push '("#+NAME:" .   "㋿") prettify-symbols-alist)
   (push '("#+name:" .   "㋿") prettify-symbols-alist)
   ;; (push '("DONE" .   "✅") prettify-symbols-alist)
   ;; (push '("TODO" .   "❢") prettify-symbols-alist)
   ;; (push '("STRT" .   "☯") prettify-symbols-alist)
   (push '("#+begin_src python" .   "🐍") prettify-symbols-alist)
   (push '("#+BEGIN_SRC python" .   "🐍") prettify-symbols-alist)
   (push '("#+BEGIN_SRC R"      .   "𝓡-") prettify-symbols-alist)
   (push '("#+begin_src R"      .   "𝓡") prettify-symbols-alist)
   (push '("#+BEGIN_SRC julia"  .   "🝆") prettify-symbols-alist)
   (push '("#+begin_src julia"  .   "🝆") prettify-symbols-alist)
   (push '("#+BEGIN_SRC bash"      .   "💻") prettify-symbols-alist)
   (push '("#+begin_src bash"      .   "💻") prettify-symbols-alist)
   (push '("eqref:"      .   "⅀") prettify-symbols-alist)
   (prettify-symbols-mode)))

;;; init-org.el ends here
(provide 'init-org)
