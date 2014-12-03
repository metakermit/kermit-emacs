; start server (if it ain't running already)
;; so that we can use emacsclient for future file-opening
(load "server")
(unless (server-running-p) (server-start))

;; initialize the package infrastructure - TODO
;;(load "~/.emacs.d/init/packages")

 ;; activate package.el
(require 'package)
(package-initialize)

;; set the package repositories - so far only melpa after reading
;; http://batsov.com/articles/2012/04/06/melpa-homebrew-emacs-edition/
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ;;("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; add the packages location to the load path
(let ((default-directory "~/.emacs.d/elpa/"))
      (normal-top-level-add-subdirs-to-load-path))

;; ------------------install packages-----------------

(require 'cl)
;; Guarantee all packages are installed on start
(defvar packages-list
  '(
    helm
    projectile
    ;;helm-projectile - seems to be included in helm
    ;;solarized-theme - issues in the terminal
    color-theme-solarized
    ;;sublimity
    git-gutter
    web-mode
    jedi
    magit
    markdown-mode
    js2-mode
    skewer-mode
    auto-complete
    ac-js2
    multi-term
    yasnippet
    load-relative
    cython-mode
    yaml-mode
    )

    ;; rainbow-mode
    ;; fill-column-indicator
    ;; clojure-mode
    ;; cursor-chg
    ;; highlight-indentation
    ;; highlight-symbol
    ;; php-mode
    ;; protobuf-mode
    ;; rvm)
  "List of packages needs to be installed at launch")

(defun has-package-not-installed ()
  (loop for p in packages-list
        when (not (package-installed-p p)) do (return t)
        finally (return nil)))
(when (has-package-not-installed)
  ;; Check for new packages (package versions)
  (message "%s" "Get latest versions of all packages...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; Install the missing packages
  (dolist (p packages-list)
    (when (not (package-installed-p p))
      (package-install p))))
;; ---------------------------------------------------


;; load the main config file which relatively loads all the submodules
(require 'load-relative)
(load-relative "~/.emacs.d/init/config")


;; automatically created
;;-----------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("073dbd38a7ce4f316eba2b0c9be8193d8ba58c0f0a399ce4c02aeda812fecf3f" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(fci-rule-color "#073642")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors (quote (("#073642" . 0) ("#546E00" . 20) ("#00736F" . 30) ("#00629D" . 50) ("#7B6000" . 60) ("#8B2C02" . 70) ("#93115C" . 85) ("#073642" . 100))))
 '(inhibit-startup-screen t)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote left))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#CF4F1F") (60 . "#C26C0F") (80 . "#b58900") (100 . "#AB8C00") (120 . "#A18F00") (140 . "#989200") (160 . "#8E9500") (180 . "#859900") (200 . "#729A1E") (220 . "#609C3C") (240 . "#4E9D5B") (260 . "#3C9F79") (280 . "#2aa198") (300 . "#299BA6") (320 . "#2896B5") (340 . "#2790C3") (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list (quote (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
