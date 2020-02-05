;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ryan G"
      user-mail-address "exogenesis@protonmail.com")

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
(setq org-directory "~/Notes/Org/")

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

(defadvice! debug-log (&rest _)
  :before #'ws-butler-after-change
  (message "-- %s %s %s"
           (current-buffer)
           buffer-file-name
           major-mode))

;;; My Settings
;;;; Housekeeping
;;;; IDE Stuff
(golden-ratio-mode 1)
;;;;; Hook start indent-guide-mode in shell and py mode
;;;;; Fold indents
;;;;;; add a hook
(add-hook 'sh-mode-hook 'indent-guide-mode)
(add-hook 'sh-mode-hook 'flycheck-mode)
(add-hook 'sh-mode-hook 'company-mode)
;(global-set-key (kbd ";C-c v") 'open-term-copy-path)
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
;(eval-after-load 'outline
;  '(progn
;     (require 'outline-magic)
;     (define-key outline-minor-mode-map (kbd "<C-tab>") 'outline-cycle)))
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

;(global-set-key (kbd "C-c v") 'open-term-copy-path)
(global-set-key "\C-cv" 'open-term-copy-path)

(defun my-open-current-file-in-vim ()
 (interactive)
 (call-process-shell-command
;  (format "gvim +%d %s"
  (format "~/.local/bin/kitty -e nvim +%d %s"
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
; (require 'dash)
; (require 'outshine)

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
;     (advice-add 'outshine-narrow-to-subtree :before
;                 (lambda (&rest args) (unless (outline-on-heading-p t)
;                                        (outline-previous-visible-heading 1))))
;
;
;     (let ((kmap outline-minor-mode-map))
;       (define-key kmap (kbd "M-RET") 'outshine-insert-heading)
;       (define-key kmap (kbd "<backtab>") 'outshine-cycle-buffer)
;
;       ;; Evil outline navigation keybindings
;       (evil-define-key '(normal visual motion) kmap
;         "gh" 'outline-up-heading
;         "gj" 'outline-forward-same-level
;         "gk" 'outline-backward-same-level
;         "gl" 'outline-next-visible-heading
;         "gu" 'outline-previous-visible-heading))
;

;;;;; Temporary Buffer for ~helm-ag~
;  (custom-set-variables
;   '(helm-ag-use-temp-buffer t))
;  ;;;; Wiki Stuff
;  ; <Spc> w w opens the wiki file
;  (doom-leader-key "ww" (lambda () (interactive) (find-file "~/Notes/MD/notes/index.md")))
;  (doom-leader-key "wo" (lambda () (interactive) (find-file "~/Notes/Org/0index.org")))
;  ;;;;; Show preview Buffer Helm-ag
;  (custom-set-variables
;   '(helm-ag-use-temp-buffer t))
;  ;;;;; org-wiki
;;  (require 'org-wiki)
   (setq org-wiki-location "~/Dropbox/Notes/Org")



;;;; Fokus Mode
; (spacemacs/set-leader-keys "fk" (lambda () (interactive) (darkroom-mode)))

;;;; AucTeX
;;;;; use shell-escape flag (withpdflatex)
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))

(with-eval-after-load 'tex
  (add-to-list 'safe-local-variable-values
               '(TeX-command-extra-options . "-shell-escape")))
;;;;; Use magic symbols
; for reference
;(require 'magic-latex-buffer)
;   (add-hook 'from-mode-hook 'what to do)
; pretty symbols enabled below
(add-hook 'TeX-mode-hook 'prettify-symbols-mode )
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
; (setq-default dotspacemacs-configuration-layers '((ess :variables
 ;                                                      ess-assign-key "\M--")))



;;;; Org-Mode Settings
;;;;; Use `org-id' to make links
;(require 'org-id)
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
;(require 'ox-latex)

(setq org-latex-listings t)
;(add-to-list 'org-latex-packages-alist '("" "listings"))
;(add-to-list 'org-latex-packages-alist '("" "color"))


; Export using the 'minted package (Using XeLaTeX)
; I have templates for listings but what's annoying is that it only supports a few languages, minted has way more support
;     (add-to-list 'org-src-lang-modes (cons "vim" 'vimrc))

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
;(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.8))
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
 ;(require 'org-attach)
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
