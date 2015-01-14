(require-package 'bm)
(setq bm-restore-repository-on-load t)
(when (require 'bm nil 'noerror)
  ;; make bookmarks persistent as default
  (setq-default bm-buffer-persistence t)

  ;; (setq bm-cycle-all-buffers t)

  ;; Loading the repository from file when on start up.
  (add-hook' after-init-hook 'bm-repository-load)

  ;; Restoring bookmarks when on file find.
  (add-hook 'find-file-hooks 'bm-buffer-restore)

  ;; Saving bookmark data on killing a buffer
  (add-hook 'kill-buffer-hook 'bm-buffer-save)

  ;; Saving the repository to file when on exit.
  ;; kill-buffer-hook is not called when emacs is killed, so we
  ;; must save all bookmarks first.
  (add-hook 'kill-emacs-hook '(lambda nil
                                (bm-buffer-save-all)
                                (bm-repository-save)))

  (setq bm-highlight-style
        'bm-highlight-only-fringe
        ;; 'bm-highlight-only-line
        )
  (setq bm-marker 'bm-marker-right)
  (defun bm-next-or-previous (&optional previous)
    (interactive "P")
    (if previous
        (bm-previous)
      (bm-next)))
  (global-set-key (kbd "<C-f2>") 'bm-toggle)
  (global-set-key (kbd "<f2>")   'bm-next-or-previous)
  (global-set-key (kbd "<S-f2>") 'bm-previous)
  (global-set-key (kbd "ESC <f2>") 'bm-previous)
  (global-set-key [f14] 'bm-previous)   ; S-f2
  (global-set-key (kbd "<C-S-f2>") 'bm-remove-all-current-buffer)
  (defadvice bm-next (after pulse-advice activate)
    "After bm-next, pulse the line the cursor lands on."
    (when (and (boundp 'pulse-command-advice-flag) pulse-command-advice-flag
               (called-interactively-p))
      (pulse-momentary-highlight-one-line (point))))
  (defadvice bm-previous (after pulse-advice activate)
    "After bm-previous, pulse the line the cursor lands on."
    (when (and (boundp 'pulse-command-advice-flag) pulse-command-advice-flag
               (called-interactively-p))
      (pulse-momentary-highlight-one-line (point))))
  (defadvice bm-next-or-previous (after pulse-advice activate)
    "After bm-next-or-previous, pulse the line the cursor lands on."
    (when (and (boundp 'pulse-command-advice-flag) pulse-command-advice-flag
               (called-interactively-p))
      (pulse-momentary-highlight-one-line (point))))
  )

(provide 'init-bm)
