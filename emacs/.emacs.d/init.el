;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package stuff                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))

(package-initialize)

;; load use-package

(condition-case nil
    (require 'use-package)
  (file-error
   (package-refresh-contents)
   (package-install 'use-package)
   (require 'use-package)))

(load-file "~/.emacs.d/config.el")

;; Settings

(setq skeleten/font		"Source Code Pro 12"
      skeleten/theme		'ayu)

;;
(skeleten/init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flymake flymake-rust zencoding-mode yasnippet-snippets yaml-mode window-number which-key use-package undo-tree treemacs toml-mode telephone-line swiper-helm sourcerer-theme smartparens slack rainbow-mode rainbow-delimiters racer projectile powershell paredit origami org-mime org-bullets offlineimap ob-rust neotree multiple-cursors mu4e-alert monokai-theme moe-theme mediawiki magit-popup magit lsp-java lsp-intellij ivy-yasnippet ivy-pass ivy-dired-history ivy-bibtex intellij-theme htmlize gruvbox-theme ghub font-lock+ flycheck-rust flatland-theme fish-mode fiplr expand-region eglot edit-server dracula-theme doom-themes dockerfile-mode dashboard cyberpunk-theme counsel-tramp company-restclient company-lsp company-emacs-eclim cargo arduino-mode all-the-icons-ivy all-the-icons-gnus all-the-icons-dired adoc-mode ace-popup-menu ace-jump-mode)))
 '(safe-local-variable-values
   (quote
    ((eval setenv "OPENSSL_INCLUDE_DIR" "/usr/include/openssl-1.0")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
