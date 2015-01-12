(setq-default compilation-scroll-output t)

(require-package 'alert)

;; Customize `alert-default-style' to get messages after compilation

(defun sanityinc/alert-after-compilation-finish (buf result)
  "Use `alert' to report compilation RESULT if BUF is hidden."
  (let ((buf-is-visible nil))
    (walk-windows (lambda (w)
                    (when (eq (window-buffer w) buf)
                      (setq buf-is-visible t))))
    (unless buf-is-visible
      (alert (concat "Compilation " result)
             :buffer buf
             :category 'compilation))))

(after-load 'compile
  (add-hook 'compilation-finish-functions
            'sanityinc/alert-after-compilation-finish))


(require-package 'smart-compile)
(require 'smart-compile)
(global-set-key [C-f7] 'smart-compile)
(custom-set-variables
 '(smart-compile-alist
   (quote
    (quote
     ((emacs-lisp-mode emacs-lisp-byte-compile)
      (html-mode browse-url-of-buffer)
      (nxhtml-mode browse-url-of-buffer)
      (html-helper-mode browse-url-of-buffer)
      (octave-mode run-octave)
      ("\\.c\\'" . "gcc -std=c11 -g %f -lm -o %n")
      ("\\.[Cc]+[Pp]*\\'" . "g++ -std=c++11 -g %f -lm -o %n")
      ("\\.m\\'" . "gcc -O2 %f -lobjc -lpthread -o %n")
      ("\\.java\\'" . "javac %f")
      ("\\.php\\'" . "php -l %f")
      ("\\.f90\\'" . "gfortran %f -o %n")
      ("\\.[Ff]\\'" . "gfortran %f -o %n")
      ("\\.cron\\(tab\\)?\\'" . "crontab %f")
      ("\\.tex\\'" tex-file)
      ("\\.texi\\'" . "makeinfo %f")
      ("\\.mp\\'" . "mptopdf %f")
      ("\\.pl\\'" . "perl -cw %f")
      ("\\.rb\\'" . "ruby -cw %f"))))))

(provide 'init-compile)
