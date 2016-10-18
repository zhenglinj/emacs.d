(require-package 'omnisharp)
(require 'omnisharp)

(setq omnisharp-server-executable-path "~/.emacs.d/omnisharp-server/OmniSharp/bin/Release/OmniSharp.exe")
(setq omnisharp-debug t)
(setq omnisharp-auto-complete-want-documentation t)
(setq omnisharp-company-sort-results t)
(setq omnisharp-auto-complete-want-importable-types t)
(setq omnisharp-eldoc-support t)

(define-key omnisharp-mode-map [(control tab)] 'omnisharp-auto-complete)
(define-key omnisharp-mode-map (kbd ".") 'omnisharp-add-dot-and-auto-complete)
(define-key omnisharp-mode-map (kbd "M-.") 'omnisharp-go-to-definition)
(define-key omnisharp-mode-map (kbd "M-,") 'pop-tag-mark)
(define-key omnisharp-mode-map (kbd "<C-f7>") 'omnisharp-build-in-emacs)

(defun my-omnisharp-mode-hook ()
  (auto-complete-mode t)
  (add-to-list 'ac-sources 'ac-source-omnisharp)
  (eldoc-mode t)
  )

(add-hook 'omnisharp-mode-hook 'my-omnisharp-mode-hook)
(add-hook 'csharp-mode-hook 'omnisharp-mode)

(provide 'init-csharp-mode)
