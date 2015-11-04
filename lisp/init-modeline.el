(require-package 'powerline)
(require 'powerline)
(powerline-default-theme)

;; (require-package 'spaceline)
;; (require 'spaceline-config)
;; (spaceline-spacemacs-theme)

(setq minor-mode-alist
      '(
        ;; (tagedit-mode " Tagedit")
        ;; (sgml-electric-tag-pair-mode "/e")
        ;; (elisp-slime-nav-mode " SliNav")
        (redshank-mode "")
        ;; (aggressive-indent-mode " =>")
        (rainbow-delimiters-mode "")
        (highlight-quoted-mode "")
        (flymake-mode flymake-mode-line)
        (ggtags-mode
         (:eval
          (if ggtags-navigation-mode "" " GG")))
        (ggtags-navigation-mode ggtags-navigation-mode-lighter)
        (highlight-symbol-mode "")
        ;; (hs-minor-mode " hs")
        (diff-hl-dir-mode "")
        (diff-hl-mode "")
        (vc-parent-buffer vc-parent-buffer-name)
        (diff-minor-mode " Diff")
        (bug-reference-prog-mode "")
        (bug-reference-mode "")
        (paredit-everywhere-mode " Par-")
        (paredit-mode " Par")
        (goto-address-prog-mode "")
        (goto-address-mode "")
        (server-buffer-clients " Server")
        (auto-compile-on-load-mode auto-compile-on-load-mode-lighter)
        (auto-compile-mode auto-compile-mode-lighter)
        ;; (eldoc-mode eldoc-minor-mode-string)
        ;; (rinari-minor-mode " Rin")
        ;; (ruby-capistrano-minor-mode " capstrano")
        ;; (ruby-compilation-minor-mode " ruby:comp")
        (inf-ruby-minor-mode "")
        ;; (compilation-minor-mode " Compilation")
        ;; (compilation-shell-minor-mode " Shell-Compile")
        ;; (compilation-in-progress " Compiling")
        ;; (prose-mode " Prose")
        ;; (inferior-js-keys-mode " InfJS")
        (guide-key-mode "")
        (hes-mode "")
        (whole-line-or-region-mode "")
        (page-break-lines-mode "")
        ;; (mc-hide-unmatched-lines-mode " hu")
        ;; (rectangular-region-mode " rr")
        (multiple-cursors-mode mc/mode-line)
        ;; (undo-tree-visualizer-selection-mode "Select")
        (undo-tree-mode "")
        ;; (whitespace-cleanup-mode
        ;;  (:eval
        ;;   (whitespace-cleanup-mode-mode-line)))
        ;; (global-whitespace-newline-mode " NL")
        ;; (global-whitespace-mode " WS")
        ;; (whitespace-newline-mode " nl")
        ;; (whitespace-mode " ws")
        (global-auto-revert-mode global-auto-revert-mode-text)
        (auto-revert-tail-mode auto-revert-tail-mode-text)
        (auto-revert-mode auto-revert-mode-text)
        ;; (cfs-profile-edit-mode " Rem")
        ;; (auto-complete-mode " AC")
        (company-search-mode company-search-lighter)
        (company-mode company-lighter)
        (flycheck-mode flycheck-mode-line)
        (anzu-mode "")
        ;; (yas-minor-mode " yas")
        ;; (outline-minor-mode " Outl")
        ;; (visible-mode " Vis")
        ;; (visual-line-mode " Wrap")
        ;; (next-error-follow-minor-mode " Fol")
        ;; (abbrev-mode " Abbrev")
        (overwrite-mode overwrite-mode)
        ;; (auto-fill-function " Fill")
        ;; (defining-kbd-macro " Def")
        (isearch-mode isearch-mode))
      )

(defun spaceline-spacemacs-theme (&rest additional-segments)
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
     (buffer-modified buffer-size buffer-id remote-host)
     major-mode
     ((flycheck-error flycheck-warning flycheck-info)
      :when active)
     (((minor-modes :separator spaceline-minor-modes-separator)
       process)
      :when active)
     (erc-track :when active)
     (version-control :when active)
     (org-pomodoro :when active)
     (org-clock :when active)
     nyan-cat)

   `((battery :when active)
     selection-info
     ((buffer-encoding-abbrev
       point-position
       line-column)
      :separator " | ")
     (global :when active)
     ,@additional-segments
     buffer-position
     hud)))

;; (custom-set-variables
;;  '(mode-line-format
;;    (quote ("%e"
;;            (:eval (when window-numbering-mode
;;                     (window-numbering-get-number-string)))
;;            mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification
;;            "  " mode-line-position
;;            ;; "  (%02l,%02c) "
;;            (vc-mode vc-mode)
;;            " ("
;;            (:eval (propertize "%m" 'face nil
;;                               'help-echo buffer-file-coding-system))
;;            ("" mode-line-process)
;;            (" " mode-line-misc-info)
;;            ;; (which-func-mode
;;            ;;  ("" which-func-format " "))
;;            minor-mode-alist
;;            ") "
;;            ;; mode-line-modes
;;            mode-line-end-spaces
;;            ))))

(provide 'init-modeline)
