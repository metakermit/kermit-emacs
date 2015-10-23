;; Control the information that gets displayed in the editor
;; (line numbers, highlihgt line etc.)

;; title with file path
;;---------------------
;;(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))
(setq frame-title-format '("%b (%f)"))

(if (eq window-system 'X)
    (progn
      ;; enable global clipboard access
      (setq x-select-enable-clipboard t)
      ;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
      (setq interprogram-paste-function 'x-selection-value)
    )
)

;; 80-column rule
;;---------------
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; line numbers
;;-------------
(global-linum-mode t)
(add-hook 'term-mode-hook (lambda()
                (linum-mode 0)))

;; highlight current line
;;-----------------------
(global-hl-line-mode 1)


;; flymake messages in minibuffer
;;-------------------------------
(custom-set-variables
 '(help-at-pt-timer-delay 0.9)
 '(help-at-pt-display-when-idle '(flymake-overlay)))
