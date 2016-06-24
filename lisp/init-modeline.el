;; Shorten minor-mode-alist in the modeline
(delight '((eldoc-mode nil "eldoc")
           (global-whitespace-newline-mode nil "whitespace")
           (global-whitespace-mode nil "whitespace")
           (whitespace-newline-mode nil "whitespace")
           (whitespace-mode nil "whitespace")
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
    (cond ((> len 20)
           (concat (substring buf-name 0 10)
                   "..."
                   (substring buf-name (- len 7) len)))
          (t buf-name))))

(advice-add 'powerline-buffer-id :filter-return 'z/truncate-buffer-name)

(defun z/spaceline-spacemacs-theme (&rest additional-segments)
  "Install the modeline used by Spacemacs.
ADDITIONAL-SEGMENTS are inserted on the right, between `global' and
`buffer-position'."
  (spaceline-install

   '(((workspace-number window-number)
      :fallback evil-state
      :separator "|"
      :face highlight-face)
     (anzu
      auto-compile
      z/buffer-mule-info buffer-modified buffer-id z/which-function remote-host)
     major-mode
     (((flycheck-error flycheck-warning flycheck-info)
       :when active)
      (version-control :when active))
     (((minor-modes :separator " ")
       process)
      :when active)
     (erc-track :when active)
     (org-pomodoro :when active)
     (org-clock :when active)
     nyan-cat)

   `((battery :when active)
     selection-info
     ((
       ;; buffer-encoding-abbrev
       point-position
       line-column
       buffer-size)
      :separator " | ")
     (global :when active)
     ,@additional-segments
     buffer-position
     hud)))

(add-hook 'after-init-hook
          (lambda ()
            ;; (spaceline-spacemacs-theme)
            (z/spaceline-spacemacs-theme)
            ))

(provide 'init-modeline)
