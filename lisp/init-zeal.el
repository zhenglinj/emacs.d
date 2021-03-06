(require-package 'zeal-at-point)
;; Run zeal-at-point to search the word at point (or string in region), then Zeal is launched and search the word. Use prefix argument C-u to edit the search string first.

;; There is no default keymap defined, but you could setup your own binding like this:

;; (global-set-key "\C-cd" 'zeal-at-point)

;; Zeal queries can be narrowed down with a docset prefix. You can customize the relations between docsets and major modes.
(when (not (*is-a-mac*))
  (when (not (package-installed-p 'zeal-at-point))
    (require-package 'zeal-at-point)))

(add-to-list 'zeal-at-point-mode-alist '(c-mode . "c"))
(add-to-list 'zeal-at-point-mode-alist '(c++-mode . "c++"))
(add-to-list 'zeal-at-point-mode-alist '(go-mode . "go"))
(add-to-list 'zeal-at-point-mode-alist '(perl-mode . "perl"))
(add-to-list 'zeal-at-point-mode-alist '(python-mode . "python 3"))
(add-to-list 'zeal-at-point-mode-alist '(cmake-mode . "cmake"))
(add-to-list 'zeal-at-point-mode-alist '(emacs-lisp-mode . "Emacs_lisp"))
(add-to-list 'zeal-at-point-mode-alist '(csharp-mode . ".net framework"))
(add-to-list 'zeal-at-point-mode-alist '(ess-mode . "r"))
(add-to-list 'zeal-at-point-mode-alist '(inferior-ess-mode . "r"))

(global-set-key (kbd "C-c D") 'zeal-at-point)

;; Additionally, the buffer-local variable zeal-at-point-docset can be set in a specific mode hook (or file/directory local variables) to programmatically override the guessed docset. For example:

(add-hook 'rinari-minor-mode-hook
          (lambda () (setq zeal-at-point-docset "rails")))

;; You are also possible to set docset for current buffer with zeal-at-point-set-docset

(provide 'init-zeal)
