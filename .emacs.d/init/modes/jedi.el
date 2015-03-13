;; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional

;; check spelling in comments
(add-hook 'python-mode-hook 'flyspell-prog-mode)
