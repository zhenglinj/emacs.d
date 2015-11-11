(require 'popup)

(if (not (or (eq system-type 'ms-dos)
             (eq system-type 'windows-nt)
             (eq system-type 'cygwin)))
    (require 'popup-pos-tip)
  (defadvice popup-tip
      (around popup-pos-tip-wrapper (string &rest args) activate)
    (if (eq window-system 'x)
        (apply 'popup-pos-tip string args)
      ad-do-it))
  )

(provide 'init-popup)
