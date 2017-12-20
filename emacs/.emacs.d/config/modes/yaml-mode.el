(add-to-list 'auto-mode-alist
	     '("\\.yml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
	  'linum-mode)
(add-hook 'yaml-mode-hook
	  'smartparens-mode)
