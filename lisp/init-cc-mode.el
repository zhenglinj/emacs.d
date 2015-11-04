;; Irony-mode
(require-package 'irony)
(require 'irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(require-package 'irony-eldoc)
(require 'irony-eldoc)

;; (require 'ac-irony)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async)
  ;; irony-eldoc
  (irony-eldoc)
  ;; ;; ac-irony
  ;; (add-to-list 'ac-sources 'ac-source-irony)
  )
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(require-package 'flycheck-irony)
(require 'flycheck-irony)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


;; Auto-complete SECTION
(require-package 'auto-complete-clang)
(require 'auto-complete-clang)

(defun my-ac-cc-mode-setup ()
  (setq ac-clang-flags
        (mapcar(lambda (item)(concat "-I" item))
               (split-string
                "
 /usr/include/c++/4.8
 /usr/include/i386-linux-gnu/c++/4.8
 /usr/include/c++/4.8/backward
 /usr/lib/gcc/i686-linux-gnu/4.8/include
 /usr/local/include
 /usr/lib/gcc/i686-linux-gnu/4.8/include-fixed
 /usr/include/i386-linux-gnu
 /usr/include
"
                )))
  (setq ac-clang-flags (append '("-std=c++11") ac-clang-flags))
  (setq ac-sources (append '(ac-source-clang
                             ac-source-gtags
                             ;; ac-source-yasnippet
                             )
                           ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)


;; Flycheck SECTION
(add-hook 'c-mode-hook
          '(lambda ()
             (setq flycheck-clang-language-standard "c11")
             (flycheck-select-checker 'c/c++-clang)
             ))

(add-hook 'c++-mode-hook
          '(lambda ()
             (setq flycheck-clang-language-standard "c++11")
             (flycheck-select-checker 'c/c++-clang)
             ))


(require 'cc-mode)
(require-package 'srefactor)
;; (require 'srefactor)
(autoload 'srefactor-refactor-at-point "srefactor")

;; OPTIONAL: ADD IT ONLY IF YOU USE C/C++.
;; (semantic-mode 1)
(define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
(define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)


;; C/C++ SECTION
(add-to-list 'auto-mode-alist '("\\.[cC]\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.[hH]\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.[cC][pP][pP]\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.[hH][pP][pP]\\'" . c++-mode))


;; ===============================================================
;; gdb (gud)
;; ===============================================================
;; (require 'gdb-ui nil 'noerror)
(require 'gdb-mi nil 'noerror)

(defadvice gdb-setup-windows (after my-setup-gdb-windows activate)
  "my gdb ui,fix sizes of every buffer"
  (gdb-get-buffer-create 'gdb-locals-buffer)
  (gdb-get-buffer-create 'gdb-stack-buffer)
  (gdb-get-buffer-create 'gdb-breakpoints-buffer)
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)
  (setq gud-gdb-buffer-width (/ (* (window-width) 3) 4)) ;for input/output buffer and locals buffer of gud mode
  (let ((win0 (selected-window))
        (win1 (split-window nil (/ (* (window-height) 8) 10)))
        (win2 (split-window nil (/ (* (window-height) 3) 8)))
        ;; (win3 (split-window nil (- (/ (* (window-width) 2) 3) 1) 'right))
        (win3 (split-window nil gud-gdb-buffer-width 'right)) ;input/output
	)
    (gdb-set-window-buffer (gdb-get-buffer-create 'gdb-inferior-io) nil win3)
    (select-window win2)
    (set-window-buffer
     win2
     (if gud-last-last-frame
         (gud-find-file (car gud-last-last-frame))
       (if gdb-main-file
           (gud-find-file gdb-main-file)
         ;; Put buffer list in window if we
         ;; can't find a source file.
         (list-buffers-noselect))))
    (setq gdb-source-window (selected-window))
    (let ((win4 (split-window nil gud-gdb-buffer-width 'right))) ;locals
      (gdb-set-window-buffer (gdb-locals-buffer-name) nil win4))
    (select-window win1)
    (gdb-set-window-buffer (gdb-stack-buffer-name))
    (let ((win5 (split-window-right)))
      (gdb-set-window-buffer (if gdb-show-threads-by-default
                                 (gdb-threads-buffer-name)
                               (gdb-breakpoints-buffer-name))
                             nil win5))
    (select-window win0)))

(defun gud-break-or-remove (&optional force-remove)
  "Set/clear breakpoin."
  (interactive "P")
  (save-excursion
    (if (or force-remove
            (eq (car (fringe-bitmaps-at-pos (point))) 'breakpoint))
        (gud-remove nil)
      (gud-break nil))))

(defun gud-enable-or-disable ()
  "Enable/disable breakpoint."
  (interactive)
  (let ((obj))
    (save-excursion
      (move-beginning-of-line nil)
      (dolist (overlay (overlays-in (point) (point)))
        (when (overlay-get overlay 'put-break)
          (setq obj (overlay-get overlay 'before-string))))
      (if  (and obj (stringp obj))
          (cond ((featurep 'gdb-ui)
                 (let* ((bptno (get-text-property 0 'gdb-bptno obj)))
                   (string-match "\\([0-9+]\\)*" bptno)
                   (gdb-enqueue-input
                    (list
                     (concat gdb-server-prefix
                             (if (get-text-property 0 'gdb-enabled obj)
                                 "disable "
                               "enable ")
                             (match-string 1 bptno) "\n")
                     'ignore))))
                ((featurep 'gdb-mi)
                 (gud-basic-call
                  (concat
                   (if (get-text-property 0 'gdb-enabled obj)
                       "-break-disable "
                     "-break-enable ")
                   (get-text-property 0 'gdb-bptno obj))))
                (t (error "No gud-ui or gui-mi?")))
        (message "May be there isn't have a breakpoint.")))))

(defun gud-kill ()
  "Kill gdb process."
  (interactive)
  (with-current-buffer gud-comint-buffer (comint-skip-input))
  ;; (set-process-query-on-exit-flag (get-buffer-process gud-comint-buffer) nil)
  ;; (kill-buffer gud-comint-buffer)
  (dolist (buffer '(gdba gdb-stack-buffer gdb-breakpoints-buffer
                         gdb-threads-buffer gdb-inferior-io
                         gdb-registers-buffer gdb-memory-buffer
                         gdb-locals-buffer gdb-assembler-buffer))
    (when (gdb-get-buffer buffer)
      (let ((proc (get-buffer-process (gdb-get-buffer buffer))))
        (when proc (set-process-query-on-exit-flag proc nil)))
      (kill-buffer (gdb-get-buffer buffer)))))

(defadvice gdb (before ecb-deactivate activate)
  "if ecb activated, deactivate it."
  (when (and (boundp 'ecb-minor-mode) ecb-minor-mode)
    (ecb-deactivate)))

;; (defun gdb-tooltip-hook ()
;;   (gud-tooltip-mode 1)
;;   (let ((process (ignore-errors (get-buffer-process (current-buffer)))))
;;     (when process
;;       (set-process-sentinel process
;;                             (lambda (proc change)
;;                               (let ((status (process-status proc)))
;;                                 (when (or (eq status 'exit)
;;                                           (eq status 'signal))
;;                                   (gud-tooltip-mode -1))))))))
;; (add-hook 'gdb-mode-hook 'gdb-tooltip-hook)
(add-hook 'gdb-mode-hook (lambda () (gud-tooltip-mode 1)))
(defadvice gud-kill-buffer-hook (after gud-tooltip-mode activate)
  "After gdb killed, disable gud-tooltip-mode."
  (gud-tooltip-mode -1))

(setq gdb-many-windows t)
(setq gdb-use-separate-io-buffer nil)
;; (gud-tooltip-mode t)
(define-key c-mode-base-map [f5] 'gdb)
(eval-after-load "gud"
  '(progn
     (define-key gud-minor-mode-map [f5] (lambda (&optional kill)
                                           (interactive "P")
                                           (if kill
                                               (gud-kill)
                                             (gud-go))))
     (define-key gud-minor-mode-map [f5] 'gud-go)
     (define-key gud-minor-mode-map [S-f5] 'gud-kill)
     (define-key gud-minor-mode-map (kbd "ESC <f5>") 'gud-kill)
     (define-key gud-minor-mode-map [f17] 'gud-kill) ; S-f5
     (define-key gud-minor-mode-map [f8] 'gud-print)
     (define-key gud-minor-mode-map [C-f8] 'gud-pstar)
     (define-key gud-minor-mode-map [f9] 'gud-break-or-remove)
     (define-key gud-minor-mode-map [C-f9] 'gud-enable-or-disable)
     (define-key gud-minor-mode-map [S-f9] 'gud-watch)
     (define-key gud-minor-mode-map [f10] 'gud-next)
     (define-key gud-minor-mode-map [C-f10] 'gud-until)
     (define-key gud-minor-mode-map [C-S-f10] 'gud-jump)
     (define-key gud-minor-mode-map [f11] 'gud-step)
     (define-key gud-minor-mode-map [S-f11] 'gud-finish)
     (define-key gud-minor-mode-map (kbd "ESC <f11>") 'gud-finish)))


;; Added C++98 keywords, and C++11 keywords
;; http://stackoverflow.com/questions/8549351/c11-mode-or-settings-for-emacs
(require 'font-lock)

(defun --copy-face (new-face face)
  "Define NEW-FACE from existing FACE."
  (copy-face face new-face)
  (eval `(defvar ,new-face nil))
  (set new-face new-face))

(--copy-face 'font-lock-label-face  ; labels, case, public, private, proteced, namespace-tags
             'font-lock-keyword-face)
(--copy-face 'font-lock-doc-markup-face ; comment markups such as Javadoc-tags
             'font-lock-doc-face)
(--copy-face 'font-lock-doc-string-face ; comment markups
             'font-lock-comment-face)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(add-hook 'c++-mode-hook
          '(lambda()
             (font-lock-add-keywords
              nil '(;; complete some fundamental keywords
                    ("\\<\\(void\\|unsigned\\|signed\\|char\\|short\\|bool\\|int\\|long\\|float\\|double\\)\\>" . font-lock-keyword-face)
                    ;; add the new C++11 keywords
                    ("\\<\\(alignof\\|alignas\\|constexpr\\|decltype\\|noexcept\\|nullptr\\|static_assert\\|thread_local\\|override\\|final\\)\\>" . font-lock-keyword-face)
                    ("\\<\\(char[0-9]+_t\\)\\>" . font-lock-keyword-face)
                    ;; PREPROCESSOR_CONSTANT
                    ("\\<[A-Z]+[A-Z_]+\\>" . font-lock-constant-face)
                    ;; hexadecimal numbers
                    ("\\<0[xX][0-9A-Fa-f]+\\>" . font-lock-constant-face)
                    ;; integer/float/scientific numbers
                    ("\\<[\\-+]*[0-9]*\\.?[0-9]+\\([ulUL]+\\|[eE][\\-+]?[0-9]+\\)?\\>" . font-lock-constant-face)
                    ;; user-types (customize!)
                    ("\\<[A-Za-z_]+[A-Za-z_0-9]*_\\(t\\|type\\|ptr\\)\\>" . font-lock-type-face)
                    ("\\<\\(xstring\\|xchar\\)\\>" . font-lock-type-face)
                    ))
             ) t)

(defun my-c-mode-hook ()
  ;; @see http://stackoverflow.com/questions/3509919/ \
  ;; emacs-c-opening-corresponding-header-file
  (local-set-key (kbd "C-x C-o") 'ff-find-other-file)
  (setq cc-search-directories '("." "/usr/include" "/usr/local/include/*" "../*/include"))
                                        ;give me NO newline automatically after electric expressions are entered
  (setq c-auto-newline nil)

                                        ; @see http://xugx2007.blogspot.com.au/2007/06/benjamin-rutts-emacs-c-development-tips.html
  (setq compilation-window-height 15)
  (setq compilation-finish-function
        (lambda (buf str)
          (if (string-match "exited abnormally" str)
              ;;there were errors
              (message "compilation errors, press C-x ` to visit")
            ;;no errors, make the compilation window go away in 0.5 seconds
            (when (string-match "*compilation*" (buffer-name buf))
              ;; @see http://emacswiki.org/emacs/ModeCompile#toc2
              (bury-buffer "*compilation*")
              (winner-undo)
              (message "NO COMPILATION ERRORS!")
              ))))

                                        ;syntax-highlight aggressively
                                        ;(setq font-lock-support-mode 'lazy-lock-mode)
  (setq lazy-lock-defer-contextually t)
  (setq lazy-lock-defer-time 0)

                                        ;make DEL take all previous whitespace with it
  (c-toggle-hungry-state 1)

                                        ;make a #define be left-aligned
  (setq c-electric-pound-behavior (quote (alignleft)))

                                        ;do not impose restriction that all lines not top-level be indented at least
                                        ;1 (was imposed by gnu style by default)
  (setq c-label-minimum-indentation 0)
  )

(require-package 'google-c-style)
(require 'google-c-style)
;; donot use c-mode-common-hook or cc-mode-hook because many major-modes use this hook
(dolist (hook '(c-mode-hook
                c++-mode-hook))
  (add-hook hook '(lambda ()
                    (my-c-mode-hook)
                    (google-set-c-style)
                    (google-make-newline-indent)

                    (setq tab-width 4 indent-tabs-mode nil)
                    (setq c-basic-offset 4)
                    )))

(provide 'init-cc-mode)
