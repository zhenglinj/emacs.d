;; Support for the http://kapeli.com/dash documentation browser

(defun sanityinc/dash-installed-p ()
  "Return t if Dash is installed on this machine, or nil otherwise."
  (let ((lsregister "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"))
    (and (file-executable-p lsregister)
         (not (string-equal
               ""
               (shell-command-to-string
                (concat lsregister " -dump|grep com.kapeli.dash")))))))

(when (and *is-a-mac* (not (package-installed-p 'dash-at-point)))
  (message "Checking whether Dash is installed")
  (when (sanityinc/dash-installed-p)
    (require-package 'dash-at-point)))

(add-to-list 'dash-at-point-mode-alist '(c-mode . "c"))
(add-to-list 'dash-at-point-mode-alist '(c++-mode . "c++"))
(add-to-list 'dash-at-point-mode-alist '(go-mode . "go"))
(add-to-list 'dash-at-point-mode-alist '(perl-mode . "perl"))
(add-to-list 'dash-at-point-mode-alist '(python-mode . "python 3"))
(add-to-list 'dash-at-point-mode-alist '(cmake-mode . "cmake"))
(add-to-list 'dash-at-point-mode-alist '(emacs-lisp-mode . "Emacs_lisp"))
(add-to-list 'dash-at-point-mode-alist '(csharp-mode . ".net framework"))
(add-to-list 'dash-at-point-mode-alist '(ess-mode . "r"))
(add-to-list 'dash-at-point-mode-alist '(inferior-ess-mode . "r"))

(when (package-installed-p 'dash-at-point)
  (global-set-key (kbd "C-c D") 'dash-at-point))

;; Additionally, the buffer-local variable dash-at-point-docset can be set in a specific mode hook (or file/directory local variables) to programmatically override the guessed docset. For example:

(add-hook 'rinari-minor-mode-hook
          (lambda () (setq dash-at-point-docset "rails")))

(provide 'init-dash)
