(require-package 'popup)
(require 'popup)

(require-package 'popwin)
(require-package 'pos-tip)
(if (not (or (eq system-type 'ms-dos)
             (eq system-type 'windows-nt)
             (eq system-type 'cygwin)))
    (progn
      (require 'popwin)
      (require 'pos-tip)
      (popwin-mode 1))
  )

(provide 'init-popup)
