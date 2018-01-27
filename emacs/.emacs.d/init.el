;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package stuff                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package) 
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(org-babel-load-file "~/.emacs.d/config.org")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(package-selected-packages
   (quote
    (undo-tree yasnippet-snippets yasnippet ob-rust org-mime org-bullets zencoding-mode yaml-mode window-number which-key toml-mode swiper-helm smartparens rainbow-mode rainbow-delimiters racer powershell powerline paredit origami offlineimap neotree multiple-cursors monokai-theme moe-theme mediawiki markdown-mode magit lsp-rust ht flycheck-rust flatland-theme fish-mode expand-region doom-themes dashboard counsel company-restclient company-lsp all-the-icons-gnus all-the-icons-dired ace-popup-menu ace-jump-mode)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
