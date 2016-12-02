;; js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;; rjsx-mode for React's .jsx
(require 'rjsx-mode)
;; (add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

;; 2-space indent - set through .editorconfig
;; (setq-default js2-basic-offset 2)

;; js2 autocomplete
(require 'ac-js2)
;;(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)

;;; auto complete mode
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; jshint notifications
(require 'flycheck)
(add-hook 'js2-mode-hook
          (lambda () (flycheck-mode t)))
