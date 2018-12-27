;;; ayu-theme.el --- an Emacs 24 theme based on ayu (tmTheme)
;;
;;; Author: Auto Converted to Emacs 24 by tmtheme-to-deftheme (tm2deftheme)
;;; Version: 1484521107
;;; Original author: Ike Ku
;;; Url: https://github.com/emacsfodder/tmtheme-to-deftheme
;;; Package-Requires: ((emacs "24.0"))
;;
;;; Commentary:
;;  This theme was automatically generated by tmtheme-to-deftheme (tm2deftheme),
;;  from ayu (tmTheme) by Ike Ku
;;
;;; Code:

(deftheme ayu
  "ayu-theme - Created by tmtheme-to-deftheme - 2017-01-15 15:58:27 -0700")

(custom-theme-set-variables
 'ayu
)

(custom-theme-set-faces
 'ayu
 ;; basic theming.

 '(default ((t (:foreground "#B3B1AD" :background "#0A0E14" ))))
 '(region  ((t (:background "#3D424D"))))
 '(cursor  ((t (:background "#E6B450"))))

 ;; Temporary defaults
 '(linum                               ((t (:foreground "#444444"  :background "#333942" ))))
 '(fringe                              ((t (                       :background "#333942" ))))

 '(minibuffer-prompt                   ((t (:foreground "#39BAE6"  :background nil       :weight bold))))
 '(escape-glyph                        ((t (:foreground "#95C2FF"  :background nil ))))
 '(highlight                           ((t (:foreground "#D4BFFF"  :background nil ))))
 '(shadow                              ((t (:foreground "#3E424D"  :background nil ))))

 '(trailing-whitespace                 ((t (:foreground "#FFFFFF"  :background "#C74000" ))))
 '(link                                ((t (:foreground "#00b7f0"  :background nil       :underline t                                  ))))
 '(link-visited                        ((t (:foreground "#4488cc"                        :underline t :inherit (link)                  ))))
 '(button                              ((t (:foreground "#FFFFFF"  :background "#444444" :underline t :inherit (link)                  ))))
 '(next-error                          ((t (                                             :inherit (region)                             ))))
 '(query-replace                       ((t (                                             :inherit (isearch)                            ))))
 '(header-line                         ((t (:foreground "#EEEEEE"  :background "#444444" :box nil :inherit (mode-line)                 ))))

 '(mode-line-highlight                 ((t (                       :background "#242B38" :box nil                                      ))))
 '(mode-line-emphasis                  ((t (                                             :weight bold                                  ))))
 '(mode-line-buffer-id                 ((t (                                             :box nil :weight bold                         ))))

 '(mode-line-inactive                  ((t (:foreground "#b4b09e"  :background "#333942" :box nil :weight light :inherit (mode-line)   ))))
 '(mode-line                           ((t (:foreground "#EEEEEE"  :background "#333942" :box nil ))))

 '(isearch                             ((t (:foreground "#99ccee"  :background "#444444"                                               ))))
 '(isearch-fail                        ((t (                       :background "#ffaaaa"                                               ))))
 '(lazy-highlight                      ((t (                       :background "#77bbdd"                                               ))))
 '(match                               ((t (                       :background "#3388cc"                                               ))))

 '(tooltip                             ((t (:foreground "black"    :background "LightYellow" :inherit (variable-pitch)                 ))))

 '(js3-function-param-face             ((t (:foreground "#BFC3A9"                                                                      ))))
 '(js3-external-variable-face          ((t (:foreground "#F0B090"  :bold t                                                             ))))

 '(secondary-selection                 ((t (                       :background "#342858"                                               ))))
 '(cua-rectangle                       ((t (:foreground "#E0E4CC"  :background "#342858" ))))

 ;; Magit hightlight
 '(magit-item-highlight                ((t (:foreground "white" :background "#1278A8" :inherit nil ))))

 ;; flyspell-mode
 '(flyspell-incorrect                  ((t (:underline "#AA0000" :background nil :inherit nil ))))
 '(flyspell-duplicate                  ((t (:underline "#009945" :background nil :inherit nil ))))

 ;; flymake-mode
 '(flymake-errline                     ((t (:underline "#AA0000" :background nil :inherit nil ))))
 '(flymake-warnline                    ((t (:underline "#009945" :background nil :inherit nil ))))

 ;;git-gutter
 '(git-gutter:added                    ((t (:foreground "#609f60" :bold t))))
 '(git-gutter:modified                 ((t (:foreground "#3388cc" :bold t))))
 '(git-gutter:deleted                  ((t (:foreground "#cc3333" :bold t))))

 '(diff-added                          ((t (:background "#305030"))))
 '(diff-removed                        ((t (:background "#903010"))))
 '(diff-file-header                    ((t (:background "#362145"))))
 '(diff-context                        ((t (:foreground "#E0E4CC"))))
 '(diff-changed                        ((t (:foreground "#3388cc"))))
 '(diff-hunk-header                    ((t (:background "#242130"))))


 '(font-lock-comment-face ((t (:foreground "#5C6773"  :italic t))))
 '(font-lock-doc-face  ((t (:foreground "#609f70" :italic t))))
 '(font-lock-variable-name-face ((t (:foreground "#D9D7CE"  ))))
 '(font-lock-keyword-face ((t (:foreground "#FFAE57"  ))))
 '(font-lock-constant-face ((t (:foreground "#FFAE57"  ))))
 '(git-gutter:deleted ((t (:foreground "#5CCFE6"  ))))
 '(font-lock-function-name-face ((t (:foreground "#FFD580"  ))))
 '(font-lock-builtin-face ((t (:foreground "#D4BFFF"  ))))
 '(font-lock-string-face ((t (:foreground "#BAE67E"  :normal t))))
 '(font-lock-type-face ((t (:foreground "#5CCFE6"  ))))
 '(font-lock-warning-face ((t (:foreground "#FFFFFF" :background "#FFAE57" ))))
 '(diff-added ((t (:foreground "#BAE67E"  ))))
 '(diff-removed ((t (:foreground "#5CCFE6"  ))))
 '(diff-changed ((t (:foreground "#FFAE57"  ))))
 '(markdown-list-face ((t (:foreground "#D9D7CE"  ))))
 '(markdown-blockquote-face ((t (:foreground "#80D4FF"  :italic t))))
 '(markdown-link-title-face ((t (:foreground "#FFC44C"  :underline t))))
 '(git-gutter:untracked ((t (:foreground "#5C6773"  ))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#5C6773"  :italic t))))

;; Rainbow delimiters
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#4192a1"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#47a0b1"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#55aabb"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#65b2c1"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#75bac7"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#85c2ce"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#95cad4"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#a5d2db"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "#b5dae1"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "#FF0000"))))
) ;; End face definitions

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'ayu)

;; Local Variables:
;; eval: (when (fboundp 'rainbow-mode) (rainbow-mode +1))
;; End:

;;; ayu-theme.el ends here
