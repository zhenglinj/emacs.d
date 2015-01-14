;; (require-package 'yasnippet '(0 8 0) nil)
(require 'yasnippet)

;; my private snippets
(setq my-snippets (expand-file-name "~/.emacs.d/yasnippet-snippets"))
(if (and  (file-exists-p my-snippets) (not (member my-snippets yas-snippet-dirs)))
    (add-to-list 'yas-snippet-dirs my-snippets))

(yas-global-mode 1)

(require-package 'dropdown-list)
(require 'dropdown-list)
(setq yas-prompt-functions '(yas-dropdown-prompt
                             yas-ido-prompt
                             yas-completing-prompt))

;; use yas-completing-prompt when ONLY when `M-x yas-insert-snippet'
;; thanks to capitaomorte for providing the trick.
(defadvice yas-insert-snippet (around use-completing-prompt activate)
  "Use `yas-completing-prompt' for `yas-prompt-functions' but only here..."
  (let ((yas-prompt-functions '(yas-completing-prompt)))
    ad-do-it))
;; @see http://stackoverflow.com/questions/7619640/emacs-latex-yasnippet-why-are-newlines-inserted-after-a-snippet
(setq-default mode-require-final-newline nil)

(provide 'init-yasnippet)
