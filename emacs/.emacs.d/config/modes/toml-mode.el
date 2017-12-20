(add-to-list 'auto-mode-alist
	     '("\\.toml\\'" . toml-mode))
(add-hook 'toml-mode-hook
	  'linum-mode)
(add-hook 'toml-mode-hook
	  'smartparens-mode)
