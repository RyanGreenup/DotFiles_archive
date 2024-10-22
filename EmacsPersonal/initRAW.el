;; Set up package.el to work with MELPA
(require 'package)
; Slow Start
 (add-to-list 'package-archives
              '("melpa" . "https://melpa.org/packages/"))
 (package-initialize)
(package-refresh-contents t)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)

;; Download texfrag
(unless (package-installed-p 'texfrag)
  (package-install 'texfrag))

;; Enable texfrag
(require 'texfrag)
(texfrag-mode 1)

(defun dark ()
    (setq frame-background-mode 'dark)
    (set-background-color "#3f3f3f")
    (set-foreground-color "#dcdccc")
    (set-face-attribute 'default nil
                        :foreground (face-foreground 'default)
                        :background (face-background 'default))
    )
(dark)
