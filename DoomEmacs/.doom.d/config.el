;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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


;;; Keybindings
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
