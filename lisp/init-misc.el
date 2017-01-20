;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------
(add-auto-mode 'tcl-mode "Portfile\\'")
(fset 'yes-or-no-p 'y-or-n-p)

(when (fboundp 'prog-mode)
  (add-hook 'prog-mode-hook 'goto-address-prog-mode))
(setq goto-address-mail-face 'link)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(setq-default regex-tool-backend 'perl)

(add-auto-mode 'conf-mode "Procfile")


(add-to-list 'auto-mode-alist '("/[mM]ake\\." . makefile-gmake-mode))
(dolist (hook '(makefile-mode-hook
                makefile-gmake-mode-hook))
  (add-hook hook
            '(lambda ()
               (when (fboundp 'whitespace-mode)
                 (whitespace-mode -1)))))


(provide 'init-misc)
