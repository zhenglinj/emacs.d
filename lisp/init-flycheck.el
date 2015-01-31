(when (maybe-require-package 'flycheck)
  (require 'flycheck)
  (add-hook 'after-init-hook 'global-flycheck-mode)

  ;; Override default flycheck triggers
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.8)

  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)

  ;; DONOT highlight whole line with error
  (setq flycheck-highlighting-mode nil)

  ;; C/C++
  ;; Define a poor c/c++ checker (it fails when errors affect other files,
  ;; not the one being being checked actually)
  (defmacro flycheck-define-clike-checker (name command modes)
    `(flycheck-define-checker ,(intern (format "%s" name))
       ,(format "A %s checker using %s" name (car command))
       :command (,@command source-inplace)
       :error-patterns
       ((warning line-start (file-name) ":" line ":" column
                 ": warning: " (message) line-end)
        (error line-start (file-name) ":" line ":" column
               ": error: " (message) line-end))
       :modes ',modes))
  (flycheck-define-clike-checker c-gcc
                                 ("gcc" "-fsyntax-only" "-Wall" "-Wextra" "-std=c11")
                                 c-mode)
  (add-to-list 'flycheck-checkers 'c-gcc)
  (flycheck-define-clike-checker c++-g++
                                 ("g++" "-fsyntax-only" "-Wall" "-Wextra" "-std=c++11")
                                 c++-mode)
  (add-to-list 'flycheck-checkers 'c++-g++)

  ;; Python
  ;; (add-hook 'python-mode-hook
  ;;           '(lambda ()
  ;;              (flycheck-select-checker 'python-pylint)))

  ;; (flycheck-define-checker python-pyflakes
  ;;   "A Python syntax and style checker using the pyflakes utility.
  ;; See URL `http://pypi.python.org/pypi/pyflakes'."
  ;;   :command ("pyflakes" source-inplace)
  ;;   :error-patterns
  ;;   ((error line-start (file-name) ":" line ":" (message) line-end))
  ;;   :modes python-mode)
  ;; (add-to-list 'flycheck-checkers 'python-pyflakes)
  )

(require-package 'flycheck-pos-tip)
(eval-after-load 'flycheck
  ;; flycheck-pos-tip
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))
  )


(provide 'init-flycheck)
