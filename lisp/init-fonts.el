;;; Character sets

;; https://github.com/tumashu/chinese-fonts-setup
;; 中文字体配置工具
(require-package 'chinese-fonts-setup)
(require 'chinese-fonts-setup)

(setq cfs-profiles
      '("program" "org-mode" "read-book"))

(defun sanityinc/maybe-adjust-visual-fill-column ()
  "Readjust visual fill column when the global font size is modified.
This is helpful for writeroom-mode, in particular."
  (if visual-fill-column-mode
      (add-hook 'after-setting-font-hook 'visual-fill-column--adjust-window nil t)
    (remove-hook 'after-setting-font-hook 'visual-fill-column--adjust-window t)))

(add-hook 'visual-fill-column-mode-hook
          'sanityinc/maybe-adjust-visual-fill-column)



(provide 'init-fonts)
