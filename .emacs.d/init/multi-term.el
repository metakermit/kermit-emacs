(require 'multi-term)
(setq multi-term-program-switches "--login")

;; got most of this from:
;; http://paralambda.org/2012/07/02/using-gnu-emacs-as-a-terminal-emulator/

;; start F5, ctrl+page up/down switches tabs
(when (require 'multi-term nil t)
  (global-set-key (kbd "<f5>") 'multi-term)
  (global-set-key (kbd "<C-next>") 'multi-term-next)
  (global-set-key (kbd "<C-prior>") 'multi-term-prev)
  (setq multi-term-buffer-name "term"
        multi-term-program "/bin/zsh"))

;; keybindings to let through to multi-term
(when (require 'term nil t) ; only if term can be loaded..
  (setq term-bind-key-alist
        (list (cons "C-c C-c" 'term-interrupt-subjob)
;;              (cons "C-p" 'previous-line)
              (cons "C-p" 'term-send-up)
;;              (cons "C-n" 'next-line)
              (cons "C-n" 'term-send-down)
              (cons "M-f" 'term-send-forward-word)
              (cons "M-b" 'term-send-backward-word)
              (cons "C-c C-j" 'term-line-mode)
              (cons "C-c C-k" 'term-char-mode)
              (cons "M-DEL" 'term-send-backward-kill-word)
              (cons "M-d" 'term-send-forward-kill-word)
              (cons "<C-left>" 'term-send-backward-word)
              (cons "<C-right>" 'term-send-forward-word)
              (cons "C-r" 'term-send-reverse-search-history)
              (cons "M-p" 'term-send-raw-meta)
              (cons "M-y" 'term-send-raw-meta)
              (cons "C-y" 'term-send-raw))))

;; scroll to bottom on output
(when (require 'multi-term nil t)
  (setq multi-term-scroll-to-bottom-on-output "all"))
