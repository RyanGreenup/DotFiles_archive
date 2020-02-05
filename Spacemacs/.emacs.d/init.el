;;; init.el --- Spacemacs Initialization File
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

;; Avoid garbage collection during startup.
;; see `SPC h . dotspacemacs-gc-cons' for more info
(defconst emacs-start-time (current-time))
(setq gc-cons-threshold 402653184 gc-cons-percentage 0.6)
(load (concat (file-name-directory load-file-name)
              "core/core-versions.el")
      nil (not init-file-debug))
(load (concat (file-name-directory load-file-name)
              "core/core-load-paths.el")
      nil (not init-file-debug))
(load (concat spacemacs-core-directory "core-dumper.el")
      nil (not init-file-debug))

(if (not (version<= spacemacs-emacs-min-version emacs-version))
    (error (concat "Your version of Emacs (%s) is too old. "
                   "Spacemacs requires Emacs version %s or above.")
           emacs-version spacemacs-emacs-min-version)
  ;; Disable file-name-handlers for a speed boost during init
  (let ((file-name-handler-alist nil))
    (require 'core-spacemacs)
    (spacemacs/dump-restore-load-path)
    (configuration-layer/load-lock-file)
    (spacemacs/init)
    (configuration-layer/stable-elpa-init)
    (configuration-layer/load)
    (spacemacs-buffer/display-startup-note)
    (spacemacs/setup-startup-hook)
    (spacemacs/dump-eval-delayed-functions)
    (when (and dotspacemacs-enable-server (not (spacemacs-is-dumping-p)))
      (require 'server)
      (when dotspacemacs-server-socket-dir
        (setq server-socket-dir dotspacemacs-server-socket-dir))
      (unless (server-running-p)
        (message "Starting a server...")
        (server-start)))))

;;; My Settings
;;;; Housekeeping
;;;; IDE Stuff
;;;;; Golden Ratio Windo Management
(require 'golden-ratio)
(golden-ratio-mode 1)
;;;;; Hook start indent-guide-mode in shell and py mode
;;;;; Fold indents
;;;;;; add a hook
(add-hook 'sh-mode-hook 'indent-guide-mode)
(add-hook 'sh-mode-hook 'flycheck-mode)
(add-hook 'sh-mode-hook 'company-mode)
;;;;; Auto Preview Math


(defvar org-equation-live-preview-buffer-name "*Equation Live*")
(defvar org-equation-live-preview-split-size 30)
(defvar org-equation-live-preview-idle-time 0.5)
(defvar org-equation-live-preview--timer)
(defvar org-equation-live-preview--org-buffer)
(defvar org-equation-live-preview--preview-buffer)

(defun org-equation-live-preview--preview ()
  (interactive)
  (let ((datum (org-element-context)))
    (and (memq (org-element-type datum) '(latex-environment latex-fragment))
         (let* ((beg (org-element-property :begin datum))
                (end (org-element-property :end datum))
                (text (buffer-substring-no-properties beg end)))
           (with-current-buffer org-equation-live-preview--preview-buffer
             (let ((inhibit-read-only t))
               (erase-buffer) (insert (replace-regexp-in-string "\n$" "" text))
               (org-preview-latex-fragment)))))))

(defun org-equation-live-preview--open-buffer ()
  (interactive)
  (setq org-equation-live-preview--org-buffer (current-buffer))
  (let ((buffer-name org-equation-live-preview-buffer-name))
    (setq org-equation-live-preview--preview-buffer
          (get-buffer-create buffer-name))
    (split-window-vertically org-equation-live-preview-split-size)
    (other-window 1)
    (switch-to-buffer buffer-name)
    (special-mode)
    (other-window -1)))

(defun org-equation-live-preview--activate ()
  (interactive)
  (org-equation-live-preview--open-buffer)
  (message "Activating org-equation-live-preview")
  (setq org-equation-live-preview--timer
        (run-with-idle-timer org-equation-live-preview-idle-time t 'org-equation-live-preview--preview)))

(defun org-equation-live-preview--deactivate ()
  (interactive)
  (delete-other-windows)
  (message "Deactivating org-equation-live-preview")
  (cancel-function-timers 'org-equation-live-preview--preview))

(provide 'org-equation-live-preview)

;;;; Org-Brain
;(push '("b" "Brain" plain (function org-brain-goto-end)
;        "* %i%?" :empty-lines 1)
;      org-capture-templates)
(use-package org-brain :ensure t
  :init
  (setq org-brain-path "~/Notes/Org")
  ;; For Evil users
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12)
  (setq org-brain-include-file-entries nil
        org-brain-file-entries-use-title nil))
;;;; AutoExport OrgMode to HTML
(defun toggle-html-export-on-save ()
  "Enable or disable export HTML when saving current buffer."
  (interactive)
  (when (not (eq major-mode 'org-mode))
    (error "Not an org-mode file!"))
  (if (memq 'org-html-export-to-html after-save-hook)
      (progn (remove-hook 'after-save-hook 'org-html-export-to-html t)
             (message "Disabled org html export on save"))
    (add-hook 'after-save-hook 'org-html-export-to-html nil t)
    (set-buffer-modified-p t)
    (message "Enabled org html export on save")))
;;;;; Auto-Complete Skeleton Template
;; (auto-insert-mode)
;; ;; *NOTE* Trailing slash important
;; (setq auto-insert-directory "/path/to/template/directory/")
;; (setq auto-insert-query nil)
;; (define-auto-insert "\\.tex$" "my-latex-template.tex")
;;;;; Disable Auto-backup
; hidden files brakes hugo/jekyll so I'm just going move where they get saved
;; backup in one place. flat, no tree structure
    ; I did this in the customise-variables window
;; disable auto-save and auto-backup
;; store all backup and autosave files in the tmp dir
;use =auto-save-visited-mode= to save to the actual file.

;; Do civilized backup names.  Added by dbrady 2003-03-07, taken from
;; http://emacswiki.wikiwikiweb.de/cgi-bin/wiki.pl?BackupDirectory
;; 
;; Don't forget to mkdir ~/saves
(setq
 backup-by-copying t         ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacssaves"))        ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)          ; use versioned backups

(global-set-key "\M-g" 'goto-line)
(setq-default c-basic-offset 2)
(setq-default indent-tabs-mode nil)
                                        ;(setq-default indent-tabs-mode t)
(setq default-tab-width 2)

     ; These are independent.
; I would like to have it working, but, I cannot find a way to make the backups go into a different directory
;;;;;; LaTeX
(auto-insert-mode)
;; *NOTE* Trailing slash important
(setq auto-insert-directory "~/Dropbox/profiles/Templates/LaTeX/")
(setq auto-insert-query nil)
(define-auto-insert "\\.tex$" "LaTeX.tex")
;;;;; Make Auto-Save Visit enable for MD and Org
(add-hook 'markdown-mode-hook 'auto-save-visited-mode)
(add-hook 'org-mode-hook 'auto-save-visited-mode)
; The issue is creating these lock files,
;these cause hugo and other programs like rsync to crash
(setq create-lockfiles nil) ;All the other crap didn't do anything, THIS is what fixed everything!!!
;;;;; Add Outline-Cycling
; by default =outline-mode= doesn't have cycling although =outshine= introduces this, =outshine= conflicts with =latex-mode=, this doesn't and just extends the default package (wheras outshine is a buggier newer implementation.)
(eval-after-load 'outline
  '(progn
     (require 'outline-magic)
     (define-key outline-minor-mode-map (kbd "<C-tab>") 'outline-cycle)))
;;;;; Jump to fold
(evil-define-key 'normal evil-org-mode-map
"zk" 'outline-up-heading
"zk" 'outline-down-heading)


;;;;; Use mouse to zoom
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

;;;;; Open File in Vim

(defun prelude-open-with ()
"Simple function that allows us to open the underlying
  file of a buffer in an external program. only works with GTK
  not terminal programs like Vim"

(interactive)
(when buffer-file-name
  (shell-command (concat
                  (if (eq system-type 'darwin)
                      "open"
                    (read-shell-command "Open current file with: "))
                  " "
                  buffer-file-name))))


;;;;; Open a terminal in the working directory

(defun open-gnome-terminal ()
 (interactive)
 (shell-command "gnome-terminal"))

(defun open-term-copy-path ()
 "Run `gnome terminal' and `filename' in sequence."
 (interactive)
 (filename)
 (open-gnome-terminal))


(defun my-open-current-file-in-vim ()
 (interactive)
 (async-shell-command
;  (format "gvim +%d %s"
  (format "~/.local/kitty.app/bin/kitty -e nvim +%d %s"
      (+ (if (bolp) 1 0) (count-lines 1 (point)))
      (shell-quote-argument buffer-file-name))))


; no popup
; https://stackoverflow.com/a/22982525
(defun my-open-current-file-in-vim ()
  (interactive)
  (call-process-shell-command
                                        ;  (format "gvim +%d %s"
   (format "~/.local/kitty.app/bin/kitty -e nvim +%d %s"
           (+ (if (bolp) 1 0) (count-lines 1 (point)))
           (shell-quote-argument buffer-file-name))))

(global-set-key (kbd "C-c v") 'my-open-current-file-in-vim)
(global-set-key (kbd "C-c s") 'company-yasnippet)


;;;;; Save Desktop Session
;Automatically save layout of emacs and then magically reload it
;https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Emacs-Sessions.html
(desktop-save-mode 1)

;;;;; scroll one line at a time (less "jumpy" than defaults)
; there was lag here
; You will need to increas gc-cons-threshold to like 6*10^8
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;;; one line at a time
;(setq mouse-wheel-progressive-speed nil) ;;; don't accelerate scrolling
;(setq mouse-wheel-follow-mouse 't) ;;; scroll window under mouse
;(setq scroll-step 1) ;;; keyboard scroll one line at a time




 ;;;; Code Folding Outshine
 ; Require packages for following code
 (require 'dash)
 (require 'outshine)

 ;;;;;; Required for outshine
; (add-hook 'outline-minor-mode-hook 'outshine-mode)
; This does not work well in latex at all
; Just enable it manually whenever you need to edit config files
; be mindful though, that, if you collaps things with outline mode and then load
; outshine mode, it won't work properly, you'll need to kill the buffer with =C-x k RET= and then reopen and then immediately enable outshine-mode, it's a bit glitchy but it's so nice to use, much nicer that raw outline.

 ;;;;;; Enables outline-minor-mode for *ALL* programming buffers
;(add-hook 'prog-mode-hook 'outline-minor-mode)
(add-hook 'prog-mode-hook 'outshine-mode)
(add-hook 'emacs-lisp-mode-hook 'outshine-mode)
(add-hook 'latex-mode-hook  'outline-minor-mode)




 ;;;;;; Narrowing now works within the headline rather than requiring to be on it
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
   (evil-define-key '(normal visual motion) kmap
     "gh" 'outline-up-heading
     "gj" 'outline-forward-same-level
     "gk" 'outline-backward-same-level
     "gl" 'outline-next-visible-heading
     "gu" 'outline-previous-visible-heading))


;;;;; Temporary Buffer for ~helm-ag~
(custom-set-variables
 '(helm-ag-use-temp-buffer t))
;;;; Wiki Stuff
; <Spc> w w opens the wiki file
(spacemacs/set-leader-keys "ww" (lambda () (interactive) (find-file "~/Notes/MD/notes/index.md")))
(spacemacs/set-leader-keys "wo" (lambda () (interactive) (find-file "~/Notes/Org/index.org")))
;;;;; Show preview Buffer Helm-ag
(custom-set-variables
 '(helm-ag-use-temp-buffer t))
;;;;; org-wiki
(require 'org-wiki)
 (setq org-wiki-location "~/Dropbox/Notes/Org")



;;;; Fokus Mode
(spacemacs/set-leader-keys "fk" (lambda () (interactive) (darkroom-mode)))

;;;; AucTeX
;;;;; use shell-escape flag (withpdflatex)
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))

(with-eval-after-load 'tex
  (add-to-list 'safe-local-variable-values
               '(TeX-command-extra-options . "-shell-escape")))
;;;;; Use magic symbols
; for reference
(require 'magic-latex-buffer)
;(add-hook 'from-mode-hook 'what to do)
 ;pretty symbols enabled below
;(add-hook 'TeX-mode-hook 'prettify-symbols-mode )
(add-hook 'latex-mode-hook 'magic-latex-buffer)
;;;; Snippets
;;;;; Remove tab binding
; The default is a ghastly =M-/= in spacemacs so this is just an example
;(define-key yas-minor-mode-map (kbd "<tab>") nil)
;(define-key yas-minor-mode-map (kbd "TAB") nil)

;;;;; Better expand keybindings
;; Bind `SPC' to `yas-expand' when snippet expansion available (it
;; will still call `self-insert-command' otherwise).
; space might get annoying
(yas-global-mode 1)
(define-key yas-minor-mode-map [kbd "M-l"]     'yas-expand)
(define-key yas-minor-mode-map [(tab)]        nil)
(define-key yas-minor-mode-map (kbd "TAB")    nil)
(define-key yas-minor-mode-map (kbd "<tab>")  nil)


;;;; Use citeproc to replace all references upon export
                                        ; This means I'm only using org-ref for
                                        ;  + internal references being passed to LaTeX
                                        ;  + the handy shortcuts for inserting bibtex citations
                                        ;      + because this respects that syntax
                                        ;  + transforming cite:key to \cite{key} on LaTeX export
(defun citeproc-org-setup ()
  "Add citeproc-org rendering to the `org-export-before-parsing-hook' hook."
  (interactive)
  (add-hook 'org-export-before-parsing-hook 'citeproc-org-render-references))
(defun citeproc-off ()
  "remove citeproc-org rendering from the `org-export-before-parsing-hook' hook."
  (interactive)
  (remove-hook 'org-export-before-parsing-hook 'citeproc-org-render-references))

(citeproc-org-setup)


;;;; ESS and R Stuff
;R Binding for <-
; https://develop.spacemacs.org/layers/+lang/ess/README.html
(setq-default dotspacemacs-configuration-layers '((ess :variables
                                                      ess-assign-key "\M--")))



;;;; Org-Mode Settings
;;;;; Identity and Directory
(setq user-full-name "Ryan G"
      user-mail-address "exogenesis@protonmail.com")
(setq org-directory "~/Notes/Org/")
;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type `relative)
;;;;; Use `org-id' to make links
(require 'org-id)
(setq org-id-link-to-org-use-id t)
;;;;; Insert ScreenShot
(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (buffer-file-name)
                  "_"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (call-process "import" nil nil nil filename)
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))
;;;;; Run Code without prompt
   (setq org-confirm-babel-evaluate nil)

;;;;;; LaTeX Export
; Export using the 'listings package
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

;;;;;; Tikz
;Backend Test
 (setq org-babel-latex-htlatex "htlatex")
 (defmacro by-backend (&rest body)
   `(case (if (boundp 'backend) (org-export-backend-name backend) nil) ,@body))


;;;;; use =dvisvgm= not =dvipng= for math preview
                                       ;; Theres a problem with =dvipng= in =org-mode= where it will not preview choose any foreground colour other than black despite the settings, this is not related to ghostscript an is a bug inside org-mode, instead switching to =dvisvgm= fixes that, but, breakes transparency for some reason.
(setq org-preview-latex-default-process `dvisvgm)

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

;;;;; Prettify by Default
(add-hook 'TeX-mode-hook 'prettify-symbols-mode )
(add-hook 'org-mode-hook 'prettify-symbols-mode )
;;;;;  Add CSS to HTML
; Add CSS (Be mindful that you may want to implement this in a more sensible way, similar to how beorg does it
;;;;;;  Put your css files there
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


;;;;; Install org-ref

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
 ;;; For compatibility
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)








;;;;; Use PDF-Tools
(eval-after-load 'org '(require 'org-pdfview))

(add-to-list 'org-file-apps 
             '("\\.pdf\\'" . (lambda (file link)
                               (org-pdfview-open link))))
;;;;; Set Agenda to be entire =~/notes/Org/= dir
(setq org-agenda-files '("~/Notes/Org"))
;;;;;  Eval AFter Load (babel etc.)
(with-eval-after-load 'org
;; all org stuff must be wrapped
;;;;;; Enable global tags autocomplete
; this may break marking with Space.
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



;;;;;; org-attach image
; when you point to a link it will attach it to the file
 (require 'org-attach)
 (setq org-link-abbrev-alist '(("att" . org-attach-expand-link)))

;;;;;; Generate Random ID
 (defconst our-charset "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
 (defconst our-charset-length (length our-charset))

 (defun random-string (&optional max-length min-length)
   "Generate a random string."
   (let (string)
     (dotimes (_i (+ (random (- (or max-length 10) (or min-length 5) -1)) (or min-length 5)))
       (push (aref our-charset (random our-charset-length)) string))
     (concat string)))
;;;;;; Closing )
)
(put 'TeX-narrow-to-group 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'LaTeX-narrow-to-environment 'disabled nil)
