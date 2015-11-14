(require-package 'projectile)
(require 'projectile)
(delight '((projectile-mode nil "projectile")))

(projectile-global-mode)
(setq projectile-completion-system 'default)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)

(provide 'init-projectile)
