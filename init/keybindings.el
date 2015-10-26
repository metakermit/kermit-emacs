;; my custom keybindings
;; - convention based on http://stackoverflow.com/a/5682758/544059

;; a more useful grep (only for versioned files)
(global-set-key (kbd "C-c g") 'projectile-grep)

(global-set-key (kbd "C-c e") 'eval-buffer)

(defun set-solarized-light ()
  (interactive)
  (customize-set-variable 'frame-background-mode 'light)
  (load-theme 'solarized t))

(defun set-solarized-dark ()
  (interactive)
  (customize-set-variable 'frame-background-mode 'dark)
  (load-theme 'solarized t))

;; color theme
(global-set-key (kbd "C-c l") 'set-solarized-light)
(global-set-key (kbd "C-c d") 'set-solarized-dark)
