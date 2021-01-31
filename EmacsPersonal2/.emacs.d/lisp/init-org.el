;;; init-org.el --- All Packages for Emacs using straight.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-tags-column 80)
(setq org-agenda-files '("~/Notes/Org/agenda/"))


;;; Periodically When Idle
;; Maybe Rebuild Org-Agenda?
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


;;;;  Styling
(setq org-hidden-keywords '(title))
;; set basic title font
(set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)


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
