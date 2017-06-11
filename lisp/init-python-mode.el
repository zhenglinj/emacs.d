(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq python-indent 4)))

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(require-package 'pip-requirements)

;; (when (maybe-require-package 'anaconda-mode)
;;   (after-load 'python
;;     (add-hook 'python-mode-hook 'anaconda-mode)
;;     (add-hook 'python-mode-hook 'anaconda-eldoc-mode))
;;   ;; (when (maybe-require-package 'company-anaconda)
;;   ;;   (After-load 'company
;;   ;;     (add-hook 'python-mode-hook
;;   ;;               (lambda () (sanityinc/local-push-company-backend 'company-anaconda)))))
;;
;;   ;; (when (maybe-require-package 'ac-anaconda)
;;   ;;   (add-hook 'python-mode-hook 'ac-anaconda-setup))
;;   )


(autoload 'doctest-mode "doctest-mode" "Python doctest editing mode." t)

(setq interpreter-mode-alist
      (cons '("python" . python-mode) interpreter-mode-alist))


;; Elpy, the Emacs Lisp Python Environment
;; https://github.com/jorgenschaefer/elpy
(require-package 'elpy)
(when (require 'elpy nil t)
  ;; disable flymake, company, eldoc modules
  (setq elpy-modules '(elpy-module-sane-defaults
                       ;; elpy-module-company
                       elpy-module-eldoc
                       ;; elpy-module-flymake
                       elpy-module-highlight-indentation
                       elpy-module-pyvenv
                       elpy-module-yasnippet))
  (elpy-enable)
  ;; (setq elpy-rpc-backend "jedi")
  )


;; (require-package 'python-environment)

;; (require-package 'highlight-indentation)
;; (add-hook 'python-mode-hook 'highlight-indentation-mode)

;; jedi (Jedi.el is a Python auto-completion package for Emacs.)
;; http://tkf.github.io/emacs-jedi/latest/#configuration
;; (require-package 'jedi)                 ; use site-list/emacs-jedi
(autoload 'jedi:setup "jedi" nil t)
;; (setq jedi:setup-keys t)
(setq jedi:use-shortcuts t)
(setq jedi:tooltip-method nil)
(add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:key-goto-definition [f12])
;; (setq jedi:key-goto-definition-pop-marker [S-f12])
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "ESC <f12>") 'jedi:goto-definition-pop-marker)))
(setq jedi:complete-on-dot t)           ; optional



;; live-py-plugin
(require-package 'live-py-mode)
(require 'live-py-mode)


;; Emacs IPython Notebook
(require-package 'ein)
(require 'ein)

(setq ein:use-auto-complete t)
;; Or, to enable "superpack" (a little bit hacky improvements):
;; (setq ein:use-auto-complete-superpack t)

(require-package 'ob-ipython)
(require 'ob-ipython)

(provide 'init-python-mode)
