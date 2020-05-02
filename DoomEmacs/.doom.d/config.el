;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; (setq explicit-shell-file-name "/bin/bash")
(setq explicit-shell-file-name "/bin/zsh")
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ryan Greenup"
      user-mail-address "Ryan.Greenup@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 24))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Notes/Org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;;; Org Mode Settings
(after! org
;;;; PDF Viewer (To view PDF files inside Emacs)
    ;; load pdfview
     (eval-after-load 'org '(require 'org-pdfview))
     ;; Use pdfview in org-mode
 (add-to-list 'org-file-apps '("\\.pdf\\'" . (lambda (file link) (org-pdfview-open link))))

;;;; citeproc for references in HTMl
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




;;;;
;; File Links
 (setq org-link-abbrev-alist
       '(("bugzilla"  . "http://10.1.2.9/bugzilla/show_bug.cgi?id=")
         ("url-to-ja" . "http://translate.google.fr/translate?sl=en&tl=ja&u=%h")
         ("google"    . "http://www.google.com/search?q=")
         ("gmap"      . "http://maps.google.com/maps?q=%s")
         ("vidar"     . "http://121.210.19.69/")
;;         ("DataSci"     . "~/Notes/DataSci/")  ; This isn't made relative upon HTML export
         ("omap"      . "http://nominatim.openstreetmap.org/search?q=%s&polygon=1")
         ("ads"       .
          "https://ui.adsabs.harvard.edu/search/q=%20author%3A\"%s\"")))

;;;;; Org-Publish
;; Each call of setq org-publish overwrites the last
;; You must have one big list
;; Refer to    [[file:~/Notes/Org/VisualAnalytics.org::*Publishing Pathway][Publishing Pathway]]

;; (remove-hook 'org-mode-hook 'toggle-org-custom-inline-style)
;; (toggle-org-custom-inline-style)
;;;;;; Github Autumn Files
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

;;;;;; Server Autumn Files

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


;;;; Open all org-agenda files
(defun open-all-org-agenda-files () (interactive) (let ((files (org-agenda-files))) (mapcar (lambda (x) (find-file x)) files)))

;;;; Offer all Tags for Autocomplete
  ;; this may break marking with Space.
(setq org-complete-tags-always-offer-all-agenda-tags t)
(setq org-tags-column 80)
;;;; org-babel languages
;;;;;;; Active Babel languages
 (org-babel-do-load-languages
  'org-babel-load-languages
  '((R           . t)
    (latex       . t)
    (python      . t)
    (plantuml    . t)
    (dot         . t)
    (gnuplot     . t)
    (java        . t)
    (javascript        . t)
    (sed         . t)
    (shell       . t)
    (mathematica . t)
    (emacs-lisp  . t)))


;;;;;;; Set up Plant UML
 (setq org-plantuml-jar-path (expand-file-name "/bin/plantuml.jar"))
 (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
;;;; Export
;;;;; LaTeX use minted package with python pygments
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("xelatex -shell-escape -synctex=1 -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -synctex=1 -interaction nonstopmode -output-directory %o %f"))
)

;;;;; Inline Style Sheet
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

;;; Programming
;;;; Outshine Mode
(use-package! outshine :load-path "~/.doom.d/local/"
  :hook ((outline-minor-mode . outshine-mode))
  :config
  (map! :map outline-minor-mode-map
        :nm [tab] #'outshine-cycle
        :nm [backtab] #'outshine-cycle-buffer))

;; (define-key outline-minor-mode-map [tab] (lambda () (interactive) (+fold/toggle)))
;; (define-key outline-minor-mode-map [tab] (lambda () (interactive) (outshine-cycle)))
;; (define-key outline-minor-mode-map [backtab] (lambda () (interactive) (#'outshine-cycle-buffer)))
;;; ESS Settings
;;;; Auto-Scroll Inferior Buffer
;; (setq comint-prompt-read-only t) ;; Avoid this, causes problems [[https://stackoverflow.com/a/2710510/10593632]]
(setq comint-scroll-to-bottom-on-input t) ;; does
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
;;;; Company mode Auto complete delay
(after! company (setq company-idle-delay 1))
(after! company (setq company-tooltip-idle-delay 1))

;;;; Insert R Heading
(defun Insert-R-Heading-1 ()
  (interactive)
  (outshine-mode)
  (let ((hname (read-from-minibuffer "Heading Name: ")))
    (message (number-to-string (length hname)))
    (let ((hlen (length hname)))
      (let ((num (- 80 hlen)))
        (message (number-to-string num))
          (insert "## * ")
          (insert hname)

          (insert " ")
          (insert
            (apply 'concat (make-list (- 75 hlen) "-"))
           )
       )
     )
    )
)
(defun Insert-R-Heading-2 ()
  (interactive)
  (outshine-mode)
  (let ((hname (read-from-minibuffer "Heading Name: ")))
    (message (number-to-string (length hname)))
    (let ((hlen (length hname)))
      (let ((num (- 80 hlen)))
        (message (number-to-string num))
          (insert "## ** ")
          (insert hname)
          (insert " ")
          (insert
            (apply 'concat (make-list (- 74 hlen) "="))
           )
       )
     )
    )
)
(defun Insert-R-Heading-3 ()
  (interactive)
  (outshine-mode)
  (let ((hname (read-from-minibuffer "Heading Name: ")))
    (message (number-to-string (length hname)))
    (let ((hlen (length hname)))
      (let ((num (- 80 hlen)))
        (message (number-to-string num))
          (insert "## *** ")
          (insert hname)
          (insert " ")
          (insert
            (apply 'concat (make-list (- 74 hlen) "#"))
           )
       )
     )
    )
)

(defun myR/tidyverse-pipe ()
  (interactive)
  (insert " %>% "))

(defun myR/assign ()
  (interactive)
  (insert " <- "))

(add-hook 'ess-mode-hook
  (lambda ()
    (local-set-key (kbd "C-S-r") 'Insert-R-Heading-1)
    (local-set-key (kbd "C-|") 'myR/tidyverse-pipe)
    (local-unset-key (kbd "M--"))
    (local-set-key (kbd "M--") 'myR/assign)
  )
)

;;; Keybindings
 (map!  :after ess
        :map ess-mode-map
        :localleader
        "l" #'ess-eval-region-or-function-or-paragraph
        "1" #'Insert-R-Heading-1
        "2" #'Insert-R-Heading-2
        "3" #'Insert-R-Heading-3
        "d" #'ess-eval-region-or-function-or-paragraph-and-step
 )


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
;;;; Remap Esc
(setq evil-escape-key-sequence "jj")
;;;; Agenda
(global-set-key (kbd "C-c a") 'org-agenda)
;;;; Open in vim
(defun my-open-current-file-in-vim ()
  (interactive)
  (call-process-shell-command
                                        ;  (format "gvim +%d %s"
   (format "~/.local/kitty.app/bin/kitty -e nvim +%d %s"
           (+ (if (bolp) 1 0) (count-lines 1 (point)))
           (shell-quote-argument buffer-file-name))))

(global-set-key (kbd "C-c v") 'my-open-current-file-in-vim)
(global-set-key (kbd "C-c s") 'company-yasnippet)
