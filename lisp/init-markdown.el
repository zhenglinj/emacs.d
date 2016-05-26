(when (maybe-require-package 'markdown-mode)
  (after-load 'whitespace-cleanup-mode
    (push 'markdown-mode whitespace-cleanup-mode-ignore-modes)))


;; Latex support: --mathjax
;; Syntax highlight: --highlight-style pygments|kate|monochrome|espresso|zenburn|haddock|tango
;; Use CSS: -c /home/zhenglj/.emacs.d/site-lisp/emacs-mkdown/mkdown.css
(setq markdown-command "pandoc -f markdown -t html -s --mathjax --highlight-style espresso")

;; http://stackoverflow.com/questions/14275122/editing-markdown-pipe-tables-in-emacs
(require 'org-table)
(defun cleanup-org-tables ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "-+-" nil t) (replace-match "-|-"))
    ))
(add-hook 'markdown-mode-hook 'orgtbl-mode)
(add-hook 'markdown-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'cleanup-org-tables  nil 'make-it-local)
            (define-key markdown-mode-map (kbd "C-c RET") 'org-table-hline-and-move)
            ))

(provide 'init-markdown)
