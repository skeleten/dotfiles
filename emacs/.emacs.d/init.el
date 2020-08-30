;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package stuff                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq vc-follow-symlinks t)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))

(if (require 'quelpa nil t)
    (quelpa-self-upgrade)
  (with-temp-buffer
    (url-insert-file-contents
     "https://framagit.org/steckerhalter/quelpa/raw/master/bootstrap.el")
    (eval-buffer)))

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://framagit.org/steckerhalter/quelpa-use-package.git"
   :stable nil))

(require 'use-package-ensure)
(require 'quelpa-use-package)

(setq use-package-always-ensure t
      use-package-ensure-function 'quelpa)

(load-file "~/.emacs.d/config.el")

;; Settings
(setq skeleten/font		"Iosevka 12"
      skeleten/theme	'soothe)
(skeleten/init)

;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default-input-method "TeX")
 '(package-selected-packages
   '(soothe-theme tide typescript-mode neotree visual-fill-column latex-preview-pane yasnippet yaml-mode window-number which-key undo-tree treemacs-projectile treemacs-magit tree-mode toml-mode telephone-line systemd sublimity sourcerer-theme solaire-mode smartparens rustic ranger rainbow-mode rainbow-delimiters quelpa-use-package protobuf-mode paredit origami ob-mermaid multiple-cursors mu4e-conversation mu4e-alert moe-theme modus-vivendi-theme modus-operandi-theme minimal-theme mediawiki magit-popup lsp-ui lsp-java ivy-rich ivy-prescient ivy-posframe highlight-operators highlight-numbers highlight-indent-guides highlight-escape-sequences helm-lsp groovy-mode gradle-mode gdb-mi forge flycheck flx expand-region eglot dracula-theme doom-themes dockerfile-mode docker diminish dashboard dap-mode cyberpunk-theme counsel company-prescient company-lsp centaur-tabs badwolf-theme all-the-icons adoc-mode ace-jump-mode))
 '(send-mail-function 'smtpmail-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
