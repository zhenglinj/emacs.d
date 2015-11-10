(require-package 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode t)
              )))
(add-hook 'ggtags-mode-hook
          (lambda ()
            (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)))

(provide 'init-gtags)
