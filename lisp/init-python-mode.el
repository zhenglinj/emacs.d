(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(require-package 'pip-requirements)


(autoload 'doctest-mode "doctest-mode" "Python doctest editing mode." t)

(setq interpreter-mode-alist
      (cons '("python" . python-mode) interpreter-mode-alist))


(require 'python-mode)
(custom-set-variables
 '(py-shell-name "/usr/bin/python3")
 ;; '(py-shell-name "/usr/bin/X11/ipython3")
 '(py-which-bufname "Python3")
 ;; '(py-which-bufname "IPython3")
 '(py-which-shell "/usr/bin/python3")
 '(py-python-command "/usr/bin/python3")
 '(python-shell-interpreter "/usr/bin/python3")
 )

;; ;; use the wx backend, for both mayavi and matplotlib
;; (setq py-python-command-args
;;   '("--gui=wx" "--pylab=wx" "-colors" "Linux"))

;; ;; switch to the interpreter after executing code
;; (setq py-shell-switch-buffers-on-execute-p nil)
;; (setq py-switch-buffers-on-execute-p t)
;; try to automagically figure out indentation
(setq py-smart-indentation t)

(define-key py-shell-map [(control tab)] 'py-shell-complete)

;; "C-c C-e" py-help-at-point is useless, so rebind it.
(define-key python-mode-map (kbd "C-c C-e") 'py-execute-region-default)

(defun my-py-execute-buffer-python (pythonver)
  "Call the python interpreter."
  (interactive "sExecute with Python[2-3]? (Default 3):")
  (save-buffer)
  (if (string-equal pythonver "2")
      (py-execute-buffer)
    (py-execute-buffer-python3)))

(define-key python-mode-map (kbd "C-c C-c") #'my-py-execute-buffer-python)



;; use pymacs + rope + ropemacs code refactoring
(setq py-load-pymacs-p nil)
(require 'pymacs)
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)



;; jedi (Jedi.el is a Python auto-completion package for Emacs.)
;; http://tkf.github.io/emacs-jedi/latest/#configuration
;; needed by jedi
(require-package 'python-environment)
;; (defun YOUR-PLUGIN-install-python-dependencies ()
;;   (interactive)
;;   (python-environment-run "pip" "install" "epc"))
(require-package 'epc)

(require-package 'jedi)
(autoload 'jedi:setup "jedi" nil t)
(setq jedi:setup-keys t)
(setq jedi:use-shortcuts t)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key [f12] 'jedi:goto-definition)
             (local-set-key [S-f12] 'jedi:goto-definition-pop-marker)
             (local-set-key (kbd "ESC <f12>") 'jedi:goto-definition-pop-marker)))
(setq jedi:complete-on-dot t)           ; optional



;; pdee (Python Development Emacs Environment)


(provide 'init-python-mode)
