(if (eq system-type 'gnu/linux)
    ;; something for Linux if true
    (progn
      ;; emoji font
      (set-fontset-font
       t 'symbol
       (font-spec :family "Symbola") nil 'prepend)

      ;; end Linux-specific
      )
  ;; optional something if not
)
