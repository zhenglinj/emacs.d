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
  (defmacro flycheck-define-python-checker (name command)
    `(flycheck-define-checker ,(intern (format "%s" name))
       ,(format "A %s checker using %s" name (car command))
       :command (,@command
                 (config-file "--config" flycheck-flake8rc)
                 (option "--max-complexity" flycheck-flake8-maximum-complexity nil
                         flycheck-option-int)
                 (option "--max-line-length" flycheck-flake8-maximum-line-length nil
                         flycheck-option-int)
                 source)
       :error-patterns
       ((error line-start
               (file-name) ":" line ":" (optional column ":") " "
               (id "E" (one-or-more digit)) " "
               (message (one-or-more not-newline))
               line-end)
        (warning line-start
                 (file-name) ":" line ":" (optional column ":") " "
                 (id  (or "F"                ; Pyflakes in Flake8 >= 2.0
                          "W"                ; Pyflakes in Flake8 < 2.0
                          "C")               ; McCabe in Flake >= 2.0
                      (one-or-more digit)) " "
                      (message (one-or-more not-newline))
                      line-end)
        (info line-start
              (file-name) ":" line ":" (optional column ":") " "
              (id "N" (one-or-more digit)) " " ; pep8-naming in Flake8 >= 2.0
              (message (one-or-more not-newline))
              line-end)
        ;; Syntax errors in Flake8 < 2.0, in Flake8 >= 2.0 syntax errors are caught
        ;; by the E.* pattern above
        (error line-start (file-name) ":" line ":" (message) line-end))
       :modes python-mode))
  (flycheck-define-python-checker python-flake8-py2
                                  ("python2" "-m" "flake8"))
  (add-to-list 'flycheck-checkers 'python-flake8-py2)
  (flycheck-define-python-checker python-flake8-py3
                                  ("python3" "-m" "flake8"))
  (add-to-list 'flycheck-checkers 'python-flake8-py3)

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
