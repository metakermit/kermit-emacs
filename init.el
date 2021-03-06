;; increase memory limit to speed things up
(setq gc-cons-threshold 100000000)

;; start server (if it ain't running already)
;; so that we can use emacsclient for future file-opening
(load "server")
(if (and (fboundp 'server-running-p)
         (not (server-running-p)))
   (server-start))

;; initialize the package infrastructure - TODO
;;(load "~/.emacs.d/init/packages")

;; packages
(when (>= emacs-major-version 24)
  ;; activate package.el
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)

  ;; ;; set the package repositories - so far only melpa after reading
  ;; ;; http://batsov.com/articles/2012/04/06/melpa-homebrew-emacs-edition/
  ;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
  ;;                          ;;("marmalade" . "http://marmalade-repo.org/packages/")
  ;;                          ("melpa" . "http://melpa.milkbox.net/packages/")))
  )

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
    gruvbox-theme
    ;;sublimity
    git-gutter
    web-mode
    jedi
    deferred
    magit
    markdown-mode
    js2-mode
    coffee-mode
    skewer-mode
    auto-complete
    ac-js2
    multi-term
    yasnippet
    load-relative
    cython-mode
    yaml-mode
    typescript-mode
    auctex
    flycheck
    flymake-cursor
    typo
    json-mode
    editorconfig
    rsense
    neotree
    dockerfile-mode
    ac-emoji
    exec-path-from-shell
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

(when (and (>= emacs-major-version 24) (display-graphic-p))
  (when (has-package-not-installed)
    ;; Check for new packages (package versions)
    (message "%s" "Get latest versions of all packages...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; Install the missing packages
    (dolist (p packages-list)
      (when (not (package-installed-p p))
        (package-install p))))
  )
;; ---------------------------------------------------


;; load the main config file which relatively loads all the submodules
(when (>= emacs-major-version 24)
  (require 'load-relative)
  (load-relative "~/.emacs.d/init/config")
  )


;; automatically created
;;-----------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("3fa81193ab414a4d54cde427c2662337c2cab5dd4eb17ffff0d90bca97581eb6" "7366916327c60fdf17b53b4ac7f565866c38e1b4a27345fe7facbf16b7a4e9e8" "b050365105e429cb517d98f9a267d30c89336e36b109a1723d95bc0f7ce8c11d" "ed0b4fc082715fc1d6a547650752cd8ec76c400ef72eb159543db1770a27caa7" "42b9d85321f5a152a6aef0cc8173e701f572175d6711361955ecfb4943fe93af" "021720af46e6e78e2be7875b2b5b05344f4e21fad70d17af7acfd6922386b61e" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "073dbd38a7ce4f316eba2b0c9be8193d8ba58c0f0a399ce4c02aeda812fecf3f" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(fci-rule-color "#073642")
 '(frame-background-mode (quote dark))
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.9)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (gruvbox-theme typescript-mode yasnippet yaml-mode web-mode typo scss-mode sass-mode rsense rjsx-mode projectile nginx-mode neotree multi-term markdown-mode magit load-relative less-css-mode json-mode jedi helm git-gutter flymake-cursor flycheck exec-path-from-shell editorconfig dockerfile-mode cython-mode color-theme-solarized coffee-mode auctex ac-js2 ac-emoji)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote left))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#b58900")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#859900")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#2aa198")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
