(require-package 'powerline)
(require 'powerline)
(custom-set-faces
 '(powerline-inactive1 ((t (:inherit mode-line-inactive))))
 '(powerline-inactive2 ((t (:inherit mode-line-inactive)))))

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

(defun z/spaceline-spacemacs-theme (&rest additional-segments)
  "Install the modeline used by Spacemacs.
ADDITIONAL-SEGMENTS are inserted on the right, between `global' and
`buffer-position'."
  (spaceline-install

   '(((workspace-number window-number)
      :fallback evil-state
      :separator "|"
      :face highlight-face)
     anzu
     auto-compile
     (z/buffer-mule-info buffer-modified buffer-id z/which-function remote-host)
     major-mode
     ((flycheck-error flycheck-warning flycheck-info)
      :when active)
     (((minor-modes :separator " ")
       process)
      :when active)
     (version-control :when active)
     (erc-track :when active)
     (org-pomodoro :when active)
     (org-clock :when active)
     nyan-cat)

   `((battery :when active)
     selection-info
     ((
       ;; buffer-encoding-abbrev
       buffer-size
       point-position
       line-column)
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
