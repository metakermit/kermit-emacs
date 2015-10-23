;; stop the bell sound
;; only visible alarm
;;(setq visible-bell 1)
;; no alarm
(setq ring-bell-function 'ignore)

;; follow symlinks to VC files automatically
(setq vc-follow-symlinks nil)

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

;; move between windows
;;---------------------
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'meta))

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
