;; my custom keybindings
;; - convention based on http://stackoverflow.com/a/5682758/544059

;; a more useful grep (only for versioned files)
(global-set-key (kbd "C-c g") 'projectile-grep)

(global-set-key (kbd "C-c e") 'eval-buffer)

(global-set-key (kbd "C-c m s") 'magit-status)
