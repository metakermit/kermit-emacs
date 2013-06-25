;; start server (if it ain't running already)
;; so that we can use emacsclient for future file-opening
(load "server")
(unless (server-running-p) (server-start))


;; activate package.el
(require 'package)
(package-initialize)

;; set the package repositories - so far only melpa after reading http://batsov.com/articles/2012/04/06/melpa-homebrew-emacs-edition/
(setq package-archives '(;;("gnu" . "http://elpa.gnu.org/packages/")
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
    sublimity
    git-gutter
    web-mode
    )
    
    ;; rainbow-mode
    ;; fill-column-indicator
    ;; clojure-mode
    ;; cursor-chg
    ;; highlight-indentation
    ;; highlight-symbol
    ;; markdown-mode
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

;; ido-mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;; pylint
(autoload 'pylint "pylint")
(add-hook 'python-mode-hook 'pylint-add-menu-items)
(add-hook 'python-mode-hook 'pylint-add-key-bindings)

;; git-gutter - https://github.com/syohex/emacs-git-gutter
(require 'git-gutter)
(global-git-gutter-mode t)

;; color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

;; sublimity
(require 'sublimity-scroll)
(require 'sublimity-map)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; title with file path
;;(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))
(setq frame-title-format '("%b (%f)"))

;; enable global clipboard access
(setq x-select-enable-clipboard t)
;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
(setq interprogram-paste-function 'x-selection-value)

;; stop the bell sound
;; only visible alarm
;;(setq visible-bell 1)
;; no alarm
(setq ring-bell-function 'ignore)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote left)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
