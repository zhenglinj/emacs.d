;; Shorten minor-mode-alist in the modeline
(delight '((eldoc-mode nil "eldoc")
           (global-whitespace-newline-mode nil "whitespace")
           (global-whitespace-mode nil "whitespace")
           (whitespace-newline-mode nil "whitespace")
           (whitespace-mode nil "whitespace")
           (global-whitespace-cleanup-mode nil "whitespace-cleanup-mode")
           (whitespace-cleanup-mode nil "whitespace-cleanup-mode")
           (global-auto-revert-mode nil "autorevert")
           (auto-revert-mode nil "autorevert")
           (abbrev-mode nil "abbrev")
           ))

(require-package 'powerline)
(require 'powerline)
(custom-set-faces
 '(powerline-inactive1 ((t (:inherit mode-line-inactive))))
 '(powerline-inactive2 ((t (:inherit mode-line-inactive)))))
(custom-set-variables
 '(powerline-default-separator nil))

;; (add-hook 'after-init-hook
;;           (lambda ()
;;             (powerline-default-theme)))

(require-package 'spaceline)
(require 'spaceline-config)

(spaceline-define-segment z/buffer-mule-info
  "Buffer mule info."
  (powerline-raw mode-line-mule-info nil 'l)
  :when powerline-display-mule-info)

(spaceline-define-segment z/which-function
  "Which funciton."
  (powerline-raw which-func-format)
  :when (and active (bound-and-true-p which-func-mode)))

(defun z/truncate-buffer-name (buf-name)
  (let ((len (length buf-name)))
    (cond ((> len 30)
           (concat (substring buf-name 0 10)
                   "..."
                   (substring buf-name (- len 7) len)))
          (t buf-name))))

(advice-add 'powerline-buffer-id :filter-return 'z/truncate-buffer-name)

(add-hook 'after-init-hook
          (lambda ()
            (spaceline-spacemacs-theme)
            ))

(provide 'init-modeline)
