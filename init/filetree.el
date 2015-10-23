;;the settings for the file tree of choice
;;currently, it's neotree

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; docs - http://www.emacswiki.org/emacs/NeoTree


;; projectile integration
(setq projectile-switch-project-action 'neotree-projectile-action)


;; theme choices - classic, ascii, arrow, nerd

;; look settings from http://seancribbs.com/emacs.d/
(setq neo-theme 'nerd)
;; (custom-set-faces
;;  '(neo-banner-face ((t . (:inherit shadow))) t)
;;  '(neo-header-face ((t . (:inherit shadow))) t)
;;  '(neo-root-dir-face ((t . (:inherit link-visited :underline nil))) t)
;;  '(neo-dir-link-face ((t . (:inherit dired-directory))) t)
;;  '(neo-file-link-face ((t . (:inherit default))) t)
;;  '(neo-button-face ((t . (:inherit dired-directory))) t)
;;  '(neo-expand-btn-face ((t . (:inherit button))) t))
