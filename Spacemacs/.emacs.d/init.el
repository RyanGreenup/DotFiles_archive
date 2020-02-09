;;; init.el --- Spacemacs Initialization File
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

;; Increase gc-cons-threshold, depending on your system you may set it back to a
;; lower value in your dotfile (function `dotspacemacs/user-config')
;(setq gc-cons-threshold 20000000)

(defconst spacemacs-version         "0.200.13" "Spacemacs version.")
(defconst spacemacs-emacs-min-version   "24.4" "Minimal version of Emacs.")

(if (not (version<= spacemacs-emacs-min-version emacs-version))
    (error (concat "Your version of Emacs (%s) is too old. "
                   "Spacemacs requires Emacs version %s or above.")
           emacs-version spacemacs-emacs-min-version)
  (load-file (concat (file-name-directory load-file-name)
                     "core/core-load-paths.el"))
  (require 'core-spacemacs)
  (spacemacs/init)
  (configuration-layer/sync)
  (spacemacs-buffer/display-startup-note)
  (spacemacs/setup-startup-hook)
  (require 'server)
  (unless (server-running-p) (server-start)))

;; Garbage Collection
;(setq gc-cons-threshold 1000000000 gc-cons-percentage 0.6)

;;; My settings
; Load last location
;; this makes loading slower
;; (desktop-save-mode 1)
;;;; Window/Folding Settings
;;;;; Helm Settings
;; Popup Window
(setq helm-display-function 'helm-display-buffer-in-own-frame
      helm-display-buffer-reuse-frame t
      helm-use-undecorated-frame-option t)
(setq ivy-posframe-mode 1)
;; Auto Complete Path
(setq helm-ff-auto-update-initial-value t)
;; Display Below
;;(setq helm-split-window-default-side 'left)
;; I think Helm might automatically decide given resolution???
;; (setq helm-split-window-default-side 'below)
;;(helm-autoresize-mode 1)
;;;;; Golden Ratio Window Management
(require 'golden-ratio)
(golden-ratio-mode 1)
; Allow Auto Adjust
(add-hook 'buffer-list-update-hook #'golden-ratio) 
(add-hook 'focus-in-hook           #'golden-ratio)
(add-hook 'focus-out-hook          #'golden-ratio)
;;;;; OutShine
; Require packages for following code
(require 'dash)
(require 'outshine)
; Enables outline-minor-mode for *ALL* programming buffers
(add-hook 'prog-mode-hook 'outline-minor-mode)
(add-hook 'prog-mode-hook 'outshine-mode)
(add-hook 'emacs-lisp-mode-hook 'outshine-mode)
(add-hook 'latex-mode-hook  'outline-minor-mode)
;;;;;; Key Bindings
; Narrowing now works within the headline rather than requiring to be on it
(advice-add 'outshine-narrow-to-subtree :before
            (lambda (&rest args) (unless (outline-on-heading-p t)
                                   (outline-previous-visible-heading 1))))

(spacemacs/set-leader-keys
  ;; Narrowing
  "nn" 'outshine-narrow-to-subtree
  "nw" 'widen

  ;; Structural edits
  "nj" 'outline-move-subtree-down
  "nk" 'outline-move-subtree-up
  "nh" 'outline-promote
  "nl" 'outline-demote)

(let ((kmap outline-minor-mode-map))
  (define-key kmap (kbd "M-RET") 'outshine-insert-heading)
  (define-key kmap (kbd "<backtab>") 'outshine-cycle-buffer)

  ;; Evil outline navigation keybindings
  (evil-define-key nil evil-normal-state-map
    "zk" 'outline-up-heading
    "zj" 'outline-previous-visible-heading
    "zj" 'outline-next-visible-heading)
                                       )
; consider also
   ; 'outline-forward-same-level
   ; 'outline-backward-same-level
   ; 'outline-previous-visible-heading


;;;;;; LaTeX Mode Fix
;;;;; Use mouse to zoom
;;(global-set-key [C-mouse-4] 'text-scale-increase)
;;(global-set-key [C-mouse-5] 'text-scale-decrease)
;;;;; Fokus Mode
;; (spacemacs/set-leader-keys "fk" (lambda () (interactive) (darkroom-mode)))
(spacemacs/set-leader-keys "fk" 'darkroom-mode)



;; Change this if every you want to actually edit the symlink
(setq vc-follow-symlinks t)
;;;; Programming
(setq-default auto-fill-function 'do-auto-fill)
;;;;; ESS and R Stuff
;; R Binding for <-
 ;; https://develop.spacemacs.org/layers/+lang/ess/README.html
(setq-default dotspacemacs-configuration-layers '((ess :variables
                                                       ess-assign-key "\M--")))

;;;;; Make Evaluated code Flash

(require 'nrepl-eval-sexp-fu)
(setq nrepl-eval-sexp-fu-flash-duration 0.25)

(defadvice lisp-eval-region (around lisp-eval-region-flash activate)
  "Flash any calls to lisp-eval-region (and the functions that depend on it, like lisp-eval-defun)."
  (let* ((start (ad-get-arg 0))
         (end (ad-get-arg 1))
         (flasher (nrepl-eval-sexp-fu-flash (cons start end)))
         (hi (cadr flasher))
         (unhi (caddr flasher)))
    (nrepl-eval-sexp-fu-flash-doit-simple '(lambda () ad-do-it) hi unhi)))

;;;;; Shell
(add-hook 'sh-mode-hook 'indent-guide-mode)
(add-hook 'sh-mode-hook 'flycheck-mode)
(add-hook 'sh-mode-hook 'company-mode)

;;;;; Open Current File in Kitty / neovim
;; no popup
;; https://stackoverflow.com/a/22982525
(defun my-open-current-file-in-vim ()
  (interactive)
  (call-process-shell-command
                                        ;  (format "gvim +%d %s"
   (format "~/.local/kitty.app/bin/kitty -e nvim +%d %s"
           (+ (if (bolp) 1 0) (count-lines 1 (point)))
           (shell-quote-argument buffer-file-name))))

(global-set-key (kbd "C-c v") 'my-open-current-file-in-vim)
(global-set-key (kbd "C-c s") 'company-yasnippet)
;;;; AucTeX
;;;;; use shell-escape flag (withpdflatex)
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))

(with-eval-after-load 'tex
  (add-to-list 'safe-local-variable-values
               '(TeX-command-extra-options . "-shell-escape")
               '(TeX-command-extra-options . "-synctex=1")))
                                        ;synctex is necessary to play ball with PDF tools
;;;;; Use magic symbols
;; for reference
;; This is already in the space latex layer
;;  if you leave spacemacs youll need to list it
;;  other wise leave it off
;; (require 'magic-latex-buffer)
;;(add-hook 'from-mode-hook 'what to do)
;;pretty symbols enabled below
;;(add-hook 'TeX-mode-hook 'prettify-symbols-mode )
(add-hook 'latex-mode-hook 'magic-latex-buffer)
;;;; Snippets
;;;;; Get Snipet Suggestions in Company mode
;; I cannot figure this out, again this is better in vim
;; If you want snippets with auto suggestion, just hit =C-c v=
;;;;; Better expand keybindings
;; just use =SPC i s= for =helm-yas=, that's the simplest way for now
;; in reality snippets are easier in Vim and I'm already set up
;; What you NEED is company mode, snippets are a nicety but
;; I might as well jump to vim when I NEED Electric+Comp Snippets
;; Otherwise for org-babel Company is sufficient.
(yas-global-mode 1)
;(define-key yas-minor-mode-map [kbd "l"]     'yas-expand)
;(define-key yas-minor-mode-map [(tab)]        nil)
;(define-key yas-minor-mode-map (kbd "TAB")    nil)
;(define-key yas-minor-mode-map (kbd "<tab>")  nil)
;;;; templates
;; (auto-insert-mode)
;; ;; *NOTE* Trailing slash important
;; (setq auto-insert-directory "/path/to/template/directory/")
;; (setq auto-insert-query nil)
;; (define-auto-insert "\\.tex$" "my-latex-template.tex")
   (define-auto-insert "\\.sh$" "~/bin/hworld.sh")

;;;; Wiki Stuff
(require 'org-wiki) 
(setq org-wiki-location "~/Dropbox/Notes/Org")
;; <Spc> w w opens the wiki file
(spacemacs/set-leader-keys "ww" (lambda () (interactive) (find-file "~/Notes/MD/notes/index.md")))
(spacemacs/set-leader-keys "wo" (lambda () (interactive) (find-file "~/Notes/Org/index.org")))
(setq org-return-follows-link t)
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))

;;;;; No Lock Files
;; This breaks gh-pages
;; All the other crap didn't do anything, THIS is what fixed everything!!!
(setq create-lockfiles nil)


;;;; Org-Mode
;;;;; Helm-Org-Rifle
;; use Tab for Preview
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(spacemacs/set-leader-keys "fk" (lambda () (interactive) (darkroom-mode)))
; rifle buffer/dir/headlines ripgrep
(spacemacs/set-leader-keys "srd" 'helm-org-rifle-org-directory)
(spacemacs/set-leader-keys "srb" 'helm-org-rifle-current-buffer)
(spacemacs/set-leader-keys "srh" 'helm-org-agenda-files-headings)
(spacemacs/set-leader-keys "/" 'helm-org-in-buffer-headings)

;;;;; Identity and Directory
(setq user-full-name "Ryan G"
      user-mail-address "exogenesis@protonmail.com")
(setq org-directory "~/Notes/Org/")
(setq org-agenda-files '("~/Notes/Org"))
;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type `relative)
;;;;; Use `org-id' to make links
; This can make it faster but it makes it confusing too
(require 'org-id)
;;(setq org-id-link-to-org-use-id t)
(setq org-id-link-to-org-use-id nil)
;;;;; PGP
(require 'org-crypt)
;;;;; Insert ScreenShot
;; Don't use this, use org-download-screenshot instead
;; remember use = fzf | xargs rm = to remove a screenshot
;; If you take it out of org mode
;;(defun my-org-screenshot ()
;;  "Take a screenshot into a time stamped unique-named file in the
;;same directory as the org-buffer and insert a link to this file."
;;  (interactive)
;;  (setq filename
;;        (concat
;;         (make-temp-name
;;          (concat (buffer-file-name)
;;                  "_"
;;                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
;;  (call-process "import" nil nil nil filename)
;;  (insert (concat "[[" filename "]]"))
;;  (org-display-inline-images))
;;;;; Open all Agenda Files
(defun open-all-org-agenda-files () (interactive) (let ((files (org-agenda-files))) (mapcar (lambda (x) (find-file x)) files)))
;;;;; Run Code without prompt
(setq org-confirm-babel-evaluate nil)
;;;;; In Buffer Format
;;;;;; Prettify by Default
(add-hook 'TeX-mode-hook 'prettify-symbols-mode )
(add-hook 'org-mode-hook 'prettify-symbols-mode )
;;;;;; This is to preview tikz
(add-to-list 'org-latex-packages-alist
             '("" "tikz" t))

(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))
                                        ;this might conflict with the setting above [[use =dvisvgm= not =dvipng= for math preview]]
(setq org-latex-create-formula-image-program 'imagemagick)

                                        ; Bigger preview images (the default was too small, this wan't affect export)
                                        ; For Org
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.8))
                                        ; For latex-mode
(set-default 'preview-scale-function 1.62178)

;;;;;; use =dvisvgm= not =dvipng= for math preview
;; Theres a problem with =dvipng= in =org-mode= where it will not
;; preview choose any foreground colour other than black despite the
;; settings, this is not related to ghostscript an is a bug inside org-mode,
;; instead switching to =dvisvgm= fixes that, but, breakes transparency for some reason.
(setq org-preview-latex-default-process `dvisvgm)
;;;;;; Make nice pretty bullets
(add-hook 'org-mode-hook 'org-bullets-mode)

;;;;;; Mixed Pitch
; (require 'mixed-pitch)
(add-hook 'org-mode-hook 'mixed-pitch-mode)
(add-hook 'org-mode-hook 'company-posframe-mode)
;;;;; Exports
;;;;; HTML Attachment Links
(setq org-attach-dir-relative t)
;;;;;; Export-all
(defun publish-dir-org ()
  "Publish all org files in a directory"
  (interactive)
  (save-excursion
    (mapc
     (lambda (file)
       (with-current-buffer
           (find-file-noselect file)
         (org-export-as-html-batch)))
     (file-expand-wildcards  "*.org")))) 
;;;;;; 5. Tolerate broken links
(require 'org-ref)
;; The warning is nice, don't forget about it though
;(setq org-export-with-broken-links t)
;;;;;; LaTeX Export
;;;;;;; Ordinary LaTeX
;; Export using the 'listings package
(require 'ox-latex)

(setq org-latex-listings t)
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))


                                        ; Export using the 'minted package (Using XeLaTeX)
                                        ; I have templates for listings but what's annoying is that it only supports a few languages, minted has way more support
(add-to-list 'org-src-lang-modes (cons "vim" 'vimrc))
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("xelatex -shell-escape -synctex=1 -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -synctex=1 -interaction nonstopmode -output-directory %o %f"))

;;;;;;; Tikz
                                        ;Backend Test
(setq org-babel-latex-htlatex "htlatex")
(defmacro by-backend (&rest body)
  `(case (if (boundp 'backend) (org-export-backend-name backend) nil) ,@body))
;;;;;;  Add CSS to HTML
;; Add CSS (Be mindful that you may want to implement this in a more sensible way, similar to how beorg does it
;; Put your css files there
(defvar org-theme-css-dir "~/.emacs.d/org-css/")

(defun toggle-org-custom-inline-style ()
 (interactive)
 (let ((hook 'org-export-before-parsing-hook)
       (fun 'set-org-html-style))
   (if (memq fun (eval hook))
       (progn
         (remove-hook hook fun 'buffer-local)
         (message "Removed %s from %s" (symbol-name fun) (symbol-name hook)))
     (add-hook hook fun nil 'buffer-local)
     (message "Added %s to %s" (symbol-name fun) (symbol-name hook)))))

; Enable Css hook by default
(add-hook 'org-mode-hook 'toggle-org-custom-inline-style)

(defun org-theme ()
  (interactive)
  (let* ((cssdir org-theme-css-dir)
         (css-choices (directory-files cssdir nil ".css$"))
         (css (completing-read "theme: " css-choices nil t)))
    (concat cssdir css)))
(defun set-org-html-style (&optional backend)
 (interactive)
 (when (or (null backend) (eq backend 'html))
(let ((f (or (and (boundp 'org-theme-css) org-theme-css) (org-theme))))
     (if (file-exists-p f)
         (progn
           (set (make-local-variable 'org-theme-css) f)
           (set (make-local-variable 'org-html-head)
                (with-temp-buffer
                  (insert "<style type=\"text/css\">\n<!-- [CDATA] -->\n")
                  (insert-file-contents f)
                  (goto-char (point-max))
                  (insert "\n/;]]>;/-->\n</style>\n")
                  (buffer-string)))
           (set (make-local-variable 'org-html-head-include-default-style)
                nil)
           (message "Set custom style from %s" f))
       (message "Custom header file %s doesnt exist")))))


;;;;;; Use PDF-Tools
(eval-after-load 'org '(require 'org-pdfview))

(add-to-list 'org-file-apps 
             '("\\.pdf\\'" . (lambda (file link)
                               (org-pdfview-open link))))
;;;;;; References
;;;;;;; Use citeproc to replace all references upon export
;; This means I'm only using org-ref for
;;  + internal references being passed to LaTeX
;;  + the handy shortcuts for inserting bibtex citations
;;      + because this respects that syntax
;;  + transforming cite:key to \cite{key} on LaTeX export
(defun citeproc-org-setup ()
  "Add citeproc-org rendering to the `org-export-before-parsing-hook' hook."
  (interactive)
  (add-hook 'org-export-before-parsing-hook 'citeproc-org-render-references))
(defun citeproc-off ()
  "remove citeproc-org rendering from the `org-export-before-parsing-hook' hook."
  (interactive)
  (remove-hook 'org-export-before-parsing-hook 'citeproc-org-render-references))

(citeproc-org-setup)

;;;;;;; Install org-ref
(add-to-list 'package-archives
	           '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For compatibility
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;; This makes a warning but might be necessary ???
;; (package-initialize) 








;;;;; Generate Random ID for org-babel
;; useful for org-babel languages
(defconst our-charset "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
(defconst our-charset-length (length our-charset))

(defun random-string (&optional max-length min-length)
  "Generate a random string."
  (let (string)
    (dotimes (_i (+ (random (- (or max-length 10) (or min-length 5) -1)) (or min-length 5)))
      (push (aref our-charset (random our-charset-length)) string))
    (concat string)))




;;;;;  Eval AFter Load (babel etc.)
(with-eval-after-load 'org
;; all org stuff must be wrapped
;;;;;; Enable global tags autocomplete
;; this may break marking with Space.
 (setq org-complete-tags-always-offer-all-agenda-tags t)

 (setq org-tag-alist '((:startgrouptag)
                       ("GTD")
                       (:grouptags)
                       ("Control")
                       ("Persp")
                       (:endgrouptag)
                       (:startgrouptag)
                       ("Control")
                       (:grouptags)
                       ("Context")
                       ("Task")
                       (:endgrouptag)))

;(:grouptags)
;(:endgrouptag)

;;;;;; Active Babel languages
 (org-babel-do-load-languages
  'org-babel-load-languages
  '((R          . t)
    (latex       . t)
    (python      . t)
    (gnuplot     . t)
    (java        . t)
    (sed         . t)
    (shell       . t)
    (mathematica . t)
    (emacs-lisp  . t)))

;; write =#+BEGIN_SRC vim= to get =vimrc-mode= behaviour
 (add-to-list 'org-src-lang-modes (cons "vim" 'vimrc))

;;;;;; org-attach image
; when you point to a link it will attach it to the file
 (require 'org-attach)
 (setq org-link-abbrev-alist '(("att" . org-attach-expand-link)))

;;;;;; Closing )
)
(put 'TeX-narrow-to-group 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'LaTeX-narrow-to-environment 'disabled nil)

