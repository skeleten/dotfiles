(autoload 'rust-mode "rust-mode" nil t)
(require 'lsp-mode)
(require 'lsp-rust)
(require 'company-lsp)
(add-to-list 'auto-mode-alist
	     '("\\.rs\\'" . rust-mode))

(setq company-lsp-async t)
(with-eval-after-load 'rust-mode
  (add-hook 'rust-mode-hook #'lsp-rust-enable)
  (add-hook 'rust-mode-hook #'flycheck-mode)
  (add-hook 'rust-mode-hook
	    (lambda ()
	      (setq company-backends
		    '((company-lsp
		       :with company-yasnippet)))))
  (add-hook 'rust-mode-hook 'origami-mode))

(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
