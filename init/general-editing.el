;; General editing behaviour
;; (auto-indentation etc.)

(define-key global-map (kbd "RET") 'newline-and-indent)

(add-hook 'markdown-mode-hook 'ac-emoji-setup)
(add-hook 'git-commit-mode-hook 'ac-emoji-setup)


;; editorconfig
(require 'editorconfig)
(editorconfig-mode 1)
