; start server (if it ain't running already)
;; so that we can use emacsclient for future file-opening
(load "server")
(unless (server-running-p) (server-start))


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
    helm-projectile
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

;; ido-mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching
;; don't complete while I'm in dired
(add-hook 'dired-mode-hook
          '(lambda () (setq ido-enable-replace-completing-read nil)))

;; helm
(require 'helm-config)
(helm-mode 1)

;; projectile
(require 'projectile)
(projectile-global-mode) ;; to enable in all buffers
(setq projectile-enable-caching t) ;; useful for big projects
(global-set-key (kbd "C-c h") 'helm-projectile) ;; find everything

;; pylint
(autoload 'pylint "pylint")
(add-hook 'python-mode-hook 'pylint-add-menu-items)
(add-hook 'python-mode-hook 'pylint-add-key-bindings)

;; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional

;; git-gutter - https://github.com/syohex/emacs-git-gutter
(require 'git-gutter)
(global-git-gutter-mode +1)

;; color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'zenburn t)
(load-theme 'solarized-dark t)

;; sublimity
;;(require 'sublimity-scroll)
;;(require 'sublimity-map)

;; js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
;; js2 autocomplete
;;(require 'ac-js2-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)

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

(if (eq window-system 'X)
    (progn
      ;; enable global clipboard access
      (setq x-select-enable-clipboard t)
      ;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
      (setq interprogram-paste-function 'x-selection-value)
    )
)

;; stop the bell sound
;; only visible alarm
;;(setq visible-bell 1)
;; no alarm
(setq ring-bell-function 'ignore)

;; follow symlinks to VC files automatically
(setq vc-follow-symlinks nil)

;; 80-column rule
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; kill other buffers
(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
          (delq (current-buffer)
                (remove-if-not 'buffer-file-name (buffer-list)))))

;; spaces, not tabs, please!
(setq-default indent-tabs-mode nil)

;; new files modified straight away (so that dired shows them right away)
(add-hook 'find-file-hooks 'assume-new-is-modified)
(defun assume-new-is-modified ()
  (when (not (file-exists-p (buffer-file-name)))
    (set-buffer-modified-p t)))

;; ignore files
;; -------------
(defvar completion-ignored-extensions
  '(
    pyc
    )
  "extensions to ignore")
(defadvice completion--file-name-table (after
                                        ignoring-backups-f-n-completion
                                        activate)
  "Filter out results when they match `completion-ignored-extensions'."
  (let ((res ad-return-value))
(if (and (listp res)
     (stringp (car res))
     (cdr res))                 ; length > 1, don't ignore sole match
    (setq ad-return-value
              (completion-pcm--filename-try-filter res)))))

(eval-after-load "dired"
  '(require 'dired-x))

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)))

;; multi-term
;; ----------
(load "~/.emacs.d/init/multi-term")

;; full screen
;; -----------
(defun switch-fullscreen nil
  (interactive)
  (let* ((modes '(nil fullboth fullwidth fullheight))
         (cm (cdr (assoc 'fullscreen (frame-parameters) ) ) )
         (next (cadr (member cm modes) ) ) )
    (modify-frame-parameters
     (selected-frame)
     (list (cons 'fullscreen next)))))

(define-key global-map [f11] 'switch-fullscreen)

;; yasnippet
;;----------
(add-to-list 'load-path
              "~/.emacs.d/snippets")
(require 'yasnippet)
(yas-global-mode 1)
(add-hook 'term-mode-hook (lambda()
                (yas-minor-mode -1)))

;;----------------

;; zoom in/out
;;-------------

;; http://stackoverflow.com/questions/18783227/emacs-zoom-in-out-globally
;; - first attempt
;; (defun zoom-in()
;;   (interactive)
;;   (set-face-attribute 'default nil :height (
;;         + (face-attribute 'default :height) 8))
;;   )
;; (defun zoom-out()
;;   (interactive)
;;   (set-face-attribute 'default nil :height (
;;         - (face-attribute 'default :height) 8))
;;   )
;; - works, but not for new files
;;(defadvice text-scale-increase (around all-buffers (arg) activate)
;;  (dolist (buffer (buffer-list))
;;    (with-current-buffer buffer
;;      ad-do-it)))

;; http://www.emacswiki.org/emacs/GlobalTextScaleMode
;; (define-globalized-minor-mode
;;     global-text-scale-mode
;;     text-scale-mode
;;     (lambda () (text-scale-mode 1)))

;;   (defun global-text-scale-adjust (inc) (interactive)
;;     (text-scale-set 1)
;;     (kill-local-variable 'text-scale-mode-amount)
;;     (setq-default text-scale-mode-amount (+ text-scale-mode-amount inc))
;;     (global-text-scale-mode 1)
;;   )
;;   (global-set-key (kbd "M-0")
;;                   '(lambda () (interactive)
;;                      (global-text-scale-adjust (- text-scale-mode-amount))
;;                      (global-text-scale-mode -1)))
;;   (global-set-key (kbd "M-+")
;;                   '(lambda () (interactive) (global-text-scale-adjust 1)))
;;   (global-set-key (kbd "M-=")
;;                   '(lambda () (interactive) (global-text-scale-adjust 1)))
;;   (global-set-key (kbd "M--")
;;                   '(lambda () (interactive) (global-text-scale-adjust -1)))

;; stuff specific to OS X
;;--------------------------
(if (eq system-type 'darwin)
  (progn
    ;;(setq solarized-broken-srgb t)
    (setq solarized-use-terminal-theme t)
    ;;(sqtq solarized-termcolors 256)

    ;; default font size (otherwise it's very small)
    (set-face-attribute 'default nil :height 160)

    ;; clipboard on OS X
    (defun copy-from-osx ()
      (shell-command-to-string "pbpaste"))

    (defun paste-to-osx (text &optional push)
      (let ((process-connection-type nil))
        (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
          (process-send-string proc text)
          (process-send-eof proc))))

    (setq interprogram-cut-function 'paste-to-osx)
    (setq interprogram-paste-function 'copy-from-osx)

    ;; OS X - toggle fullscreen
    (defun toggle-fullscreen ()
      "Toggle full screen"
      (interactive)
      (set-frame-parameter
         nil 'fullscreen
         (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
    ;; default font size (1/10pt)
    (set-face-attribute 'default nil :height 180)
    ;; font
    ;;(set-face-attribute 'default nil :family "Consolas")
    (when (member "Ubuntu Mono derivative Powerline" (font-family-list))
      (set-face-attribute 'default nil :family
                          "Ubuntu Mono derivative Powerline")
    )

    ;; multi-term special chars
    (setq system-uses-terminfo nil)
    ;; have to run this after installing:
    ;; tic -o ~/.terminfo /Applications/Emacs.app/Contents/Resources/etc/e/eterm-color.ti

    ;; end specific to OS X
  )
)

;;--------------------------

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
