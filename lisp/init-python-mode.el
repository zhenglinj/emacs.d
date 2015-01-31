(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(require-package 'pip-requirements)


(autoload 'doctest-mode "doctest-mode" "Python doctest editing mode." t)

(setq interpreter-mode-alist
      (cons '("python" . python-mode) interpreter-mode-alist))


;; Elpy, the Emacs Lisp Python Environment
;; https://github.com/jorgenschaefer/elpy
(when (require 'elpy nil t)
  ;; disable flymake, company, eldoc modules
  (setq elpy-modules '(elpy-module-sane-defaults
                       ;; elpy-module-company
                       ;; elpy-module-eldoc
                       ;; elpy-module-flymake
                       elpy-module-highlight-indentation
                       elpy-module-pyvenv
                       elpy-module-yasnippet))
  (elpy-enable)
  ;; (setq elpy-rpc-backend "jedi")
  )


;; jedi (Jedi.el is a Python auto-completion package for Emacs.)
;; http://tkf.github.io/emacs-jedi/latest/#configuration

(require-package 'jedi)
(autoload 'jedi:setup "jedi" nil t)
(setq jedi:setup-keys t)
(setq jedi:use-shortcuts t)
(setq jedi:tooltip-method nil)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:key-goto-definition [f12])
(setq jedi:key-goto-definition-pop-marker [S-f12])
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "ESC <f12>") 'jedi:goto-definition-pop-marker)))
(setq jedi:complete-on-dot t)           ; optional


(provide 'init-python-mode)
