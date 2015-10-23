;; ido-mode
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching
;; don't complete while I'm in dired
(add-hook 'dired-mode-hook
          '(lambda () (setq ido-enable-replace-completing-read nil)))
