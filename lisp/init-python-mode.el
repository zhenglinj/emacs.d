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
  (elpy-enable)
  (setq elpy-rpc-backend "jedi"))
(add-hook 'python-mode-hook
          '(lambda ()
             (auto-complete-mode -1)))

(provide 'init-python-mode)
