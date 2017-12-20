(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

(add-hook 'latex-mode-hook 'linum-mode)
(add-hook 'latex-mode-hook 'company-mode)
(add-hook 'latex-mode-hook 'smartparens-mode)
(add-hook 'LaTeX-mode-hook 'linum-mode)
(add-hook 'LaTeX-mode-hook 'company-mode)
(add-hook 'LaTeX-mode-hook 'smartparens-mode)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
; (setq TeX-PDF-mode t)
