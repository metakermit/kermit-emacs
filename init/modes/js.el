;; sources:
;; - js2-mode - http://elpa.gnu.org/packages/js2-mode.html
;; - rjsx-mode - https://github.com/felipeochoa/rjsx-mode
;; - flycheck + eslint - http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html

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

;;; auto complete mode
;; ------------------
;; js2 autocomplete
(require 'ac-js2)
;;(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)

;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; lint notifications
;; ------------------
(require 'flycheck)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

(flycheck-add-mode 'javascript-eslint 'js2-mode)

(add-hook 'js2-mode-hook
          (lambda () (flycheck-mode t)))
