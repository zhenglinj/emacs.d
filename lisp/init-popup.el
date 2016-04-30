(require-package 'popup)
(require 'popup)

(require-package 'popwin)
(require 'popwin)
(popwin-mode 1)

(require-package 'pos-tip)
(if (not (or (eq system-type 'ms-dos)
             (eq system-type 'windows-nt)
             (eq system-type 'cygwin)))
    (require 'pos-tip)
  )

(provide 'init-popup)
