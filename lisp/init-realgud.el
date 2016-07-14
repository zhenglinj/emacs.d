(require-package 'realgud)
(require 'realgud)

(define-key realgud:shortkey-mode-map [mouse-3] 'realgud:tooltip-eval) ; right button / double finger touchpad

(provide 'init-realgud)
