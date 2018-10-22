;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package stuff                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))

(package-initialize)

(load-file "~/.emacs.d/secrets.el")

(defun skeleten/load-init ()
  (interactive)
  (org-babel-load-file "~/.emacs.d/config.org"))

(skeleten/load-init)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(package-selected-packages
   (quote
    (lsp-rust treemacs lsp-java lsp-intellij intellij-theme company-lsp company-emacs-eclim eclim ob-sagemath telephone-line zencoding-mode yasnippet-snippets yaml-mode window-number which-key use-package undo-tree toml-mode swiper-helm sourcerer-theme smartparens slack rainbow-mode rainbow-delimiters racer powershell paredit origami org-mime org-bullets offlineimap ob-rust neotree multiple-cursors mu4e-alert monokai-theme moe-theme mediawiki magit jdee ivy-yasnippet ivy-pass ivy-dired-history ivy-bibtex htmlize gruvbox-theme font-lock+ flycheck-rust flatland-theme fish-mode fiplr expand-region eglot dracula-theme doom-themes dockerfile-mode dashboard cyberpunk-theme counsel-tramp company-restclient cargo all-the-icons-ivy all-the-icons-gnus all-the-icons-dired ace-popup-menu ace-jump-mode)))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
