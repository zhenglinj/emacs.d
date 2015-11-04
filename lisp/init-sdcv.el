(if (executable-find "sdcv")
    (progn
      (require 'sdcv)
      (setq sdcv-dictionary-simple-path '("~/.stardict/dic/stardict-langdao-ec-gb-2.4.2/"))
      (setq sdcv-dictionary-complete-path '("~/.stardict/dic/"))
      (setq sdcv-dictionary-simple-list '("朗道英汉字典5.0"))
      (setq sdcv-dictionary-complete-list
            '("朗道英汉字典5.0"
              ;; "懒虫简明英汉词典"
              "牛津现代英汉双解词典"
              ;; "21世纪英汉汉英双向词典"
              "WordNet"))
      (autoload 'sdcv-search-pointer+ "sdcv" "show word explanation in buffer" t)
      (autoload 'sdcv-search-input "sdcv" "show word explanation in tooltip" t)
      (global-set-key (kbd "C-c ; b") 'sdcv-search-input)
      (global-set-key (kbd "C-c ; t") 'sdcv-search-pointer+)
      )
  (progn
    (require 'ydcv)
    (setq ydcv-py-directory "~/.emacs.d/site-lisp/ydcv-el/")
    (setq ydcv-dictionary-simple-list '("langdao"))
    (setq ydcv-dictionary-complete-list
          '("langdao"
            "21shiji"
            "dictd_www.dict.org_wn"))
    (global-set-key (kbd "C-c ; b") 'ydcv-search-input)
    (global-set-key (kbd "C-c ; t") 'ydcv-search-pointer+)
    ))


(provide 'init-sdcv)
