;; stuff specific to OS X
;;--------------------------
(if (eq system-type 'darwin)
  (progn
    ;;(setq solarized-broken-srgb t)
    (setq solarized-use-terminal-theme t)
    ;;(sqtq solarized-termcolors 256)

    ;; default font size (otherwise it's very small)
    (set-face-attribute 'default nil :height 160)

    ;; clipboard on OS X
    (defun copy-from-osx ()
      (shell-command-to-string "pbpaste"))

    (defun paste-to-osx (text &optional push)
      (let ((process-connection-type nil))
        (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
          (process-send-string proc text)
          (process-send-eof proc))))

    (setq interprogram-cut-function 'paste-to-osx)
    (setq interprogram-paste-function 'copy-from-osx)

    ;; OS X - toggle fullscreen
    (defun toggle-fullscreen ()
      "Toggle full screen"
      (interactive)
      (set-frame-parameter
         nil 'fullscreen
         (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
    (global-set-key (kbd "s-F") 'toggle-fullscreen)

    ;; default font size (1/10pt)
    (set-face-attribute 'default nil :height 180)
    ;; font
    ;;(set-face-attribute 'default nil :family "Consolas")
    (when (member "Ubuntu Mono derivative Powerline" (font-family-list))
      (set-face-attribute 'default nil :family
                          "Ubuntu Mono derivative Powerline")
    )

    ;; multi-term special chars
    (setq system-uses-terminfo nil)
    ;; have to run this after installing:
    ;; tic -o ~/.terminfo /Applications/Emacs.app/Contents/Resources/etc/e/eterm-color.ti

    ;; cmd + , to switch between frames
    (setq mac-command-modifier 'meta)
    ;;(global-set-key "\M-`" 'other-frame)
    (global-set-key (kbd "s-`") 'other-frame)

    ;; OS X emoji settings
    (set-fontset-font
     t 'symbol
     (font-spec :family "Apple Color Emoji") nil 'prepend)


    ;; end specific to OS X
  )
)

;;--------------------------
