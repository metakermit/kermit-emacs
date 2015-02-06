;;(require 'auctex)

(require 'reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
;; integrate RefTeX
(setq reftex-plug-into-AUCTeX t)
;; Automatically insert non-breaking space before citation
(setq reftex-format-cite-function
          '(lambda (key fmt)
             (let ((cite (replace-regexp-in-string "%l" key fmt)))
               (if (or (= ?~ (string-to-char fmt))
                       (member (preceding-char) '(?\ ?\t ?\n ?~)))
                   cite
                 (concat "~" cite)))))
