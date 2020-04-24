;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.


;;; My settings
;;;; Font
;; (setq doom-font (font-spec :family "monospace" :size 22 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :size 22 ))
 (setq doom-font (font-spec :family "monospace" :size 22 :weight 'semi-light))

; Load last location
;; this makes loading slower
;; (desktop-save-mode 1)
;;;; Window/Folding Settings
;;;;; Ivy Settings
; (require 'ivy-posframe)
;; display at `ivy-posframe-style'
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
 (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
(ivy-posframe-mode 1)





;;;;; Helm Settings
; Allow Auto Adjust
(add-hook 'buffer-list-update-hook #'golden-ratio)
(add-hook 'focus-in-hook           #'golden-ratio)
(add-hook 'focus-out-hook          #'golden-ratio)
;;;;; OutShine
; Require packages for following code
;(require 'dash)
;(require 'outshine)
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

;(spacemacs/set-leader-keys
;  ;; Narrowing
;  "nn" 'outshine-narrow-to-subtree
;  "nw" 'widen
;
;  ;; Structural edits
;  "nj" 'outline-move-subtree-down
;  "nk" 'outline-move-subtree-up
;  "nh" 'outline-promote
;  "nl" 'outline-demote)
;
;(let ((kmap outline-minor-mode-map))
;  (define-key kmap (kbd "M-RET") 'outshine-insert-heading)
;  (define-key kmap (kbd "<backtab>") 'outshine-cycle-buffer)
;
;  ;; Evil outline navigation keybindings
;  (evil-define-key nil evil-normal-state-map
;    "zk" 'outline-up-heading
;    "zj" 'outline-previous-visible-heading
;    "zj" 'outline-next-visible-heading)
;                                       )
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

;(require 'nrepl-eval-sexp-fu)
;(setq nrepl-eval-sexp-fu-flash-duration 0.25)
;
;(defadvice lisp-eval-region (around lisp-eval-region-flash activate)
;  "Flash any calls to lisp-eval-region (and the functions that depend on it, like lisp-eval-defun)."
;  (let* ((start (ad-get-arg 0))
;         (end (ad-get-arg 1))
;         (flasher (nrepl-eval-sexp-fu-flash (cons start end)))
;         (hi (cadr flasher))
;         (unhi (caddr flasher)))
;    (nrepl-eval-sexp-fu-flash-doit-simple '(lambda () ad-do-it) hi unhi)))

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
;(require 'org-wiki)
;(setq org-wiki-location "~/Dropbox/Notes/Org")
;;; <Spc> w w opens the wiki file
;;(spacemacs/set-leader-keys "ww" (lambda () (interactive) (find-file "~/Notes/MD/notes/index.md")))
;;(spacemacs/set-leader-keys "wo" (lambda () (interactive) (find-file "~/Notes/Org/index.org")))
;(setq org-return-follows-link t)
;(with-eval-after-load 'evil-maps
;  (define-key evil-motion-state-map (kbd "SPC") nil)
;  (define-key evil-motion-state-map (kbd "RET") nil)
;  (define-key evil-motion-state-map (kbd "TAB") nil))

;;;;; No Lock Files
;; This breaks gh-pages
;; All the other crap didn't do anything, THIS is what fixed everything!!!
(setq create-lockfiles nil)


;;;; Org-Mode
;;;;; Helm-Org-Rifle
;; use Tab for Preview
;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
;(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
;(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
;(spacemacs/set-leader-keys "fk" (lambda () (interactive) (darkroom-mode)))
; rifle buffer/dir/headlines ripgrep

;;;;; Identity and Directory
(setq user-full-name "Ryan G"
      user-mail-address "exogenesis@protonmail.com")
(setq org-directory "~/Notes/Org/") ;; <<89238>>
(setq org-agenda-files '("~/Notes/Org"))
;; currently I'm using this to load all the files I like into the agenda, what I
;; should do instead is define a function to open all files in a directory and
;; then I would have a much leaner argenda
(global-set-key (kbd "C-c b") '(kbd "C-c a"))

(defun my-open-current-file-in-vim ()
  (interactive)
  (call-process-shell-command
                                        ;  (format "gvim +%d %s"
   (format "~/.local/kitty.app/bin/kitty -e nvim +%d %s"
           (+ (if (bolp) 1 0) (count-lines 1 (point)))
           (shell-quote-argument buffer-file-name))))


;; Macro for Day View
(global-set-key (kbd "C-c a") 'org-agenda)
(fset 'my-day-page
   (kmacro-lambda-form [?\C-c ?a ?a ?\C-c ?\C-x ?\C-c] 0 "%d"))
(global-set-key (kbd "C-c b") 'my-day-page)
(global-set-key (kbd "C-c C-x C-l") 'org-toggle-latex-fragment)


     (add-hook 'mardkown-mode-hook
       (lambda ()
         (local-set-key (kbd "C-c C-x C-l") 'org-toggle-latex-fragment)
         (local-set-key (kbd "C-c C-x C-u") 'markdown-toggle-url-hiding)
         ))






;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type `relative)
;;;;; Use `org-id' to make links
; This can make it faster but it makes it confusing too
;(require 'org-id)
;;(setq org-id-link-to-org-use-id t)
(setq org-id-link-to-org-use-id nil)
;;;;; Insert ScreenShot
;; Don't use this, use org-download-screenshot instead
;;   Also there is =org-download-dnd=
;; remember use ~ fzf | xargs rm ~ to remove a screenshot
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
;;;;; Run Code without prompt
(setq org-confirm-babel-evaluate nil)
;;;;; In Buffer Format
;;;;;; Prettify by Default
(add-hook 'TeX-mode-hook 'prettify-symbols-mode )
(add-hook 'org-mode-hook 'prettify-symbols-mode )
;;;;;; This is to preview tikz
;(add-to-list 'org-latex-packages-alist '("" "tikz" t))
;(add-to-list 'org-latex-packages-alist '("" "listings"))
;(add-to-list 'org-latex-packages-alist '("" "color"))
;
;(eval-after-load "preview"
;  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))
;                                        ;this might conflict with the setting above [[use =dvisvgm= not =dvipng= for math preview]]
;(setq org-latex-create-formula-image-program 'imagemagick)
;
;                                        ; Bigger preview images (the default was too small, this wan't affect export)
;                                        ; For Org
;(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.8))
;                                        ; For latex-mode
;(set-default 'preview-scale-function 1.62178)

;;;;;; use =dvisvgm= not =dvipng= for math preview
;; Theres a problem with =dvipng= in =org-mode= where it will not
;; preview choose any foreground colour other than black despite the
;; settings, this is not related to ghostscript an is a bug inside org-mode,
;; instead switching to =dvisvgm= fixes that, but, breakes transparency for some reason.
(setq org-preview-latex-default-process `dvisvgm)
;;;;;; Make nice pretty bullets
;; (add-hook 'org-mode-hook 'org-bullets-mode)

;;;;; Exports
;;;;; HTML Attachment Links
(setq org-attach-dir-relative t)
;; Links are weird, see [[https://orgmode.org/manual/Attachment-links.html#Attachment-links]]
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
;(require 'org-ref)
(setq org-export-with-broken-links t)
;;;;;; LaTeX Export
;;;;;;; Ordinary LaTeX
;; Export using the 'listings package
;(require 'ox-latex)

(setq org-latex-listings t)
;(add-to-list 'org-latex-packages-alist '("" "listings"))
;(add-to-list 'org-latex-packages-alist '("" "color"))


                                        ; Export using the 'minted package (Using XeLaTeX)
                                        ; I have templates for listings but what's annoying is that it only supports a few languages, minted has way more support
;; (add-to-list 'org-src-lang-modes (cons "vim" 'vimrc))
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
(defvar org-theme-css-dir "~/Templates/CSS/Org-CSS/")

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
;; I think this is better as opt in
;; Also I still need to set up the image embedding part, which I have been
;working on in visual analytics I just haven't made a nice function.
;; (add-hook 'org-mode-hook 'toggle-org-custom-inline-style)

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

;; (after! org
;; (add-to-list 'org-file-apps
;;              '("\\.pdf\\'" . (lambda (file link)
;;                                (org-pdfview-open link))))
;; )
;;;;;; References
;;;;;;; Use citeproc to replace all references upon export
;; This means I'm only using org-ref for
;;  + internal references being passed to LaTeX
;;  + the handy shortcuts for inserting bibtex citations
;;      + because this respects that syntax
;;  + transforming cite:key to \cite{key} on LaTeX export
;;

  (after! org

    ;; load pdfview
     (eval-after-load 'org '(require 'org-pdfview))
     ;; Use pdfview in org-mode
 (add-to-list 'org-file-apps '("\\.pdf\\'" . (lambda (file link) (org-pdfview-open link))))

(use-package! citeproc-org
  :load-path "~/DotFiles/Spacemacs/Downloads/citeproc-org-0.2.2"
  ;; :config
    ;;  configure your package here
  )

(defun citeproc-org-setup ()
  "Add citeproc-org rendering to the `org-export-before-parsing-hook' hook."
  (interactive)
  (add-hook 'org-export-before-parsing-hook 'citeproc-org-render-references))
(defun citeproc-off ()
  "remove citeproc-org rendering from the `org-export-before-parsing-hook' hook."
  (interactive)
  (remove-hook 'org-export-before-parsing-hook 'citeproc-org-render-references))

(citeproc-org-setup)
)

;;;;;;; Install org-ref
;;(after! package
;;(add-to-list 'package-archives
;;	           '("melpa" . "http://melpa.org/packages/") t)
;;(when (< emacs-major-version 24)
;;  ;; For compatibility
;;  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;;)
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
;
(after! org

;;;;;; Active Babel languages
 (org-babel-do-load-languages
  'org-babel-load-languages
  '((R          . t)
    (latex       . t)
    (python      . t)
    (plantuml    . t)
    (dot         . t)
    (gnuplot     . t)
    (java        . t)
    (sed         . t)
    (shell       . t)
    (mathematica . t)
    (emacs-lisp  . t)))


;;;;;; Set up Plant UML
 (setq org-plantuml-jar-path (expand-file-name "/bin/plantuml.jar"))
 (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
 )
;; (setq ob-mermaid-cli-path "home/ryan/.nvm/versions/node/v13.6.0/bin/mmdc")
;; write =#+BEGIN_SRC vim= to get =vimrc-mode= behaviour
; (add-to-list 'org-src-lang-modes (cons "vim" 'vimrc))
; (add-to-list 'org-src-lang-modes (cons "vim" 'vimrc))

; Doom loads things differently to operate faster this won't work:
; (eval-after-load "org"
;   (add-to-list 'org-src-lang-modes '("vim" . vimrc))
;   )

;; Instead you'll need to use something like this [fn:gh]
(after! org
  (add-to-list 'org-src-lang-modes '("vim" . vimrc)))

;;;;;; org-attach image
; when you point to a link it will attach it to the file
 ;(require 'org-attach)
;; (setq org-link-abbrev-alist '(("att" . org-attach-expand-link)))

;;;;;; Closing )
)
(put 'TeX-narrow-to-group 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'LaTeX-narrow-to-environment 'disabled nil)
;;; KeyBindings
(map! :leader
;; #' delimits namespace, i.e. local var
      "h L" #'global-keycast-mode
      "f t" #'find-in-dotfiles
      "f T" #'browse-dotfiles
      "f k" #'darkroom-mode ;; Just use zen mode with SPC t z
      "i n" 'open-wiki-index
      "r o" 'helm-org-rifle-org-directory ;; [[89238]] ord-dir is different to agenda
      "r b" 'helm-org-rifle-current-buffer
      "r d" 'helm-org-rifle-directories
      "o !" 'open-all-org-agenda-files
      "/"   'helm-rg
      "r hh" 'helm-org-in-buffer-headings
      "r ha" 'helm-org-agenda-files-headings
      )
;; eval chunk

;; eval line
;; insert assignment
     (add-hook 'ess-mode-hook
       (lambda ()
        (local-set-key "M--" 'polymode-eval-chunk)))

(after! company (setq company-idle-delay 1))
(after! company (setq company-tooltip-idle-delay 1))



(defun open-wiki-index ()
  "Opens the Org Wiki Index"
  (interactive)
  (find-file "~/Notes/Org/index.org"))

(after! org
(defun open-all-org-agenda-files () (interactive) (let ((files (org-agenda-files))) (mapcar (lambda (x) (find-file x)) files)))
)

(after! org
;;; Org-Publish
;; Each call of setq org-publish overwrites the last
;; You must have one big list
;; Refer to    [[file:~/Notes/Org/VisualAnalytics.org::*Publishing Pathway][Publishing Pathway]]

;; (remove-hook 'org-mode-hook 'toggle-org-custom-inline-style)
;; (toggle-org-custom-inline-style)
;;;; Github Autumn Files
(setq org-publish-project-alist
      '(
;; (https://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html)
        ("Aut_orgfiles"
         :base-directory "~/Notes/Org/"
         :base-extension "org"
         :publishing-directory "~/Documents/ryangreenup.github.io/Org-Publish/"
         :publishing-function org-html-publish-to-html
         :exclude ".*" ;; Regexp
         :include ("./VisualAnalytics.org" "ThinkingAboutData.org"
                   "analytic_programming.org" "Social_Web_Analytics.org") ;; regexp ;; everything included otherwise
         :headline-levels 3
         :recursive t
         :section-numbers nil
         :with-toc t
         :html-head "<link rel=\"stylesheet\"
         href=\"./style.css\" type=\"text/css\"/>"
         :html-preamble t)


        ("Aut_images"
         :base-directory "~/Notes/Org/"
         :base-extension "jpg\\|gif\\|png"
         :exclude ".*ltximg.*" ;; regexp
         :recursive t
         :publishing-directory "~/Documents/ryangreenup.github.io/Org-Publish/"
         :publishing-function org-publish-attachment)

        ("Aut_other"
         :base-directory "~/Notes/Org/"
         :base-extension "css\\|el\\|pdf\\|rmd\\|r\\|R\\|sh"
         :exclude "journal.*" ;; Regexp
         :recursive t
         :publishing-directory "~/Documents/ryangreenup.github.io/Org-Publish/"
         :publishing-function org-publish-attachment)

        ("Autumn" :components ("Aut_orgfiles" "Aut_images" "Aut_other"))

;;;; Server Autumn Files

        ("Server_Org"
         :base-directory "~/Notes/Org/"
         :base-extension "org"
         :index-filename "index.org"
         :auto-index t
         :auto-sitemap t                ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
         :publishing-directory "~/Public/html/Org/"
         :publishing-function org-html-publish-to-html
         :exclude "*jour.*" ;; Regexp
;;         :include ("./VisualAnalytics.org" "ThinkingAboutData.org"
 ;;                  "analytic_programming.org" "Social_Web_Analytics.org") ;; regexp ;; everything included otherwise
         :headline-levels 3
         :recursive t
         :section-numbers nil
         :with-toc t
         :html-head "<link rel=\"stylesheet\"
         href=\"./style.css\" type=\"text/css\"/>"
         :html-preamble t)


        ("Server_Images"
         :base-directory "~/Notes/Org/"
         :base-extension "jpg\\|gif\\|png"
         :exclude ".*ltximg.*" ;; regexp
         :recursive t
         :publishing-directory "~/Public/html/Org/"
         :publishing-function org-publish-attachment)

        ("Server_Other"
         :base-directory "~/Notes/Org/"
         :base-extension "css\\|el\\|pdf\\|rmd\\|r\\|R\\|sh"
         :exclude "journal.*" ;; Regexp
         :recursive t
         :publishing-directory "~/Public/html/Org/"
         :publishing-function org-publish-attachment)

        ("Server" :components ("Server_Org" "Server_Images" "Server_Other"))

        ))
;; todo, but be mindful to move apache from root
;; Ox-Hugo
;; If you do want to split an org-file up into multiple pieces look at these:
;; [[https://lists.gnu.org/archive/html/emacs-orgmode/2015-08/msg01283.html]]
;; [[https://github.com/mbork/org-one-to-many]]
;; (withheval-after-load 'ox
;;                       (require 'ox-hugo))
  )


;; Footnotes

;; [fn:gh] https://github.com/hlissner/doom-emacs/issues/2059
;;;; Org-Mode Stuff
;;;;
(after! org
;; File Links
 (setq org-link-abbrev-alist
       '(("bugzilla"  . "http://10.1.2.9/bugzilla/show_bug.cgi?id=")
         ("url-to-ja" . "http://translate.google.fr/translate?sl=en&tl=ja&u=%h")
         ("google"    . "http://www.google.com/search?q=")
         ("gmap"      . "http://maps.google.com/maps?q=%s")
         ("vidar"     . "http://121.210.19.69/")
         ("omap"      . "http://nominatim.openstreetmap.org/search?q=%s&polygon=1")
         ("ads"       .
          "https://ui.adsabs.harvard.edu/search/q=%20author%3A\"%s\"")))
 )
