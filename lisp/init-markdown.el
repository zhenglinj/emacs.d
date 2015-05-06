(require-package 'markdown-mode)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\)\\'" . markdown-mode) auto-mode-alist))

;; Latex support: --mathjax
;; Syntax highlight: --highlight-style pygments|kate|monochrome|espresso|zenburn|haddock|tango
;; Use CSS: -c /home/zhenglj/.emacs.d/site-lisp/emacs-mkdown/mkdown.css
(setq markdown-command "pandoc -f markdown -t html -s --mathjax --highlight-style espresso")

(provide 'init-markdown)
