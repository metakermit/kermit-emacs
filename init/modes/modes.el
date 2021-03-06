;; load and configure the various modes

(load-relative "./ido")

;; helm
(require 'helm-config)
(helm-mode 1)

;; projectile
(require 'projectile)
(projectile-global-mode) ;; to enable in all buffers
(setq projectile-enable-caching t) ;; useful for big projects
(global-set-key (kbd "C-c h") 'helm-projectile) ;; find everything



;; git-gutter - https://github.com/syohex/emacs-git-gutter
(require 'git-gutter)
(global-git-gutter-mode +1)

;; sublimity
;;(require 'sublimity-scroll)
;;(require 'sublimity-map)

(load-relative "./python")
(load-relative "./yasnippet")
(load-relative "./web-mode")
(load-relative "./js")
(load-relative "./coffee")
(load-relative "./yaml-mode")
(load-relative "./latex"
)(load-relative "./magit")


;; ruby
(load-relative "./ruby")
