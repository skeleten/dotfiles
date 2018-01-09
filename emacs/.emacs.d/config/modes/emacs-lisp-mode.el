(add-to-list 'auto-mode-alist	     
	     '("\\.el\\'" . emacs-lisp-mode))
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
