;; Config taken from:
;; https://github.com/pyr/dot.emacs/blob/master/customizations/40-theme.el
;;
;; Globally map C-c t to a light/dark theme switcher
;; Also pull-in graphene for better fonts

;; metakermit: modified to be more similar to official README instructions
;; for changing the theme


;; (custom-set-variables '(solarized-termcolors 256))

;; previous favurite theme - solarized - disabled for now
;; (setq solarized-default-background-mode 'dark)
;; (load-theme 'solarized t)

;; (defun set-background-mode (frame mode)
;;   ;; (set-frame-parameter frame 'background-mode mode)
;;   ;; (when (not (display-graphic-p frame))
;;   ;;   (set-terminal-parameter (frame-terminal frame) 'background-mode mode))
;;   (customize-set-variable 'frame-background-mode mode)
;;   (enable-theme 'solarized))

;; (defun switch-theme ()
;;   (interactive)
;;   (let ((mode  (if (eq (frame-parameter nil 'background-mode) 'dark)
;;                    'light 'dark)))
;;     (set-background-mode nil mode)))

;; (add-hook 'after-make-frame-functions
;;           (lambda (frame) (set-background-mode frame solarized-default-background-mode)))

;; (set-background-mode nil solarized-default-background-mode)


;; (defun switch-theme ()
;;   (interactive)
;;   (let ((mode  (if (eq (frame-parameter nil 'background-mode) 'dark)
;;                    'light 'dark)))
;;     (set-background-mode nil mode)))

;; (global-set-key (kbd "C-c t") 'switch-theme)

(load-theme 'gruvbox-dark-medium t)
