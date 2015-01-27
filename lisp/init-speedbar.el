;; Regular speedbar config
(require 'speedbar)
(setq speedbar-show-unknown-files t)
(setq speedbar-verbosity-level 0)
;; (setq speedbar-frame-parameters (quote
;;                                  ((minibuffer)
;;                                   (width . 35)
;;                                   )))
;; (setq speedbar-use-images nil)

(global-set-key [(meta f11)] 'speedbar-get-focus)

;; ;; Sr-speedbar config
;; (require-package 'sr-speedbar)
;; (require 'sr-speedbar)
;; ;; (autoload 'sr-speedbar-toggle "sr-speedbar")
;; (global-set-key [(meta f11)] 'sr-speedbar-toggle)

;; (setq sr-speedbar-right-side nil)
;; (setq sr-speedbar-skip-other-window-p t)
;; ;; no auto-refresh
;; (setq sr-speedbar-auto-refresh nil)
;; (setq sr-speedbar-width-console 30)
;; (setq sr-speedbar-width-x 30)

;; (global-set-key (kbd "C-c j s") 'sr-speedbar-toggle)
;; (global-set-key (kbd "C-c j r") 'sr-speedbar-refresh-toggle)


(provide 'init-speedbar)
