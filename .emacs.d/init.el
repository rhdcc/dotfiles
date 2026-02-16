;; Set font
(set-frame-font "Iosevka Nerd Font Mono")

;; Set theme
(load "~/.emacs.d/fleury-theme.el")
(load-theme 'fleury t)

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'xenops)
  (package-install 'xenops))
(add-hook 'latex-mode-hook #'xenops-mode)
(add-hook 'LaTeX-mode-hook #'xenops-mode)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

(setq inhibit-startup-message t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(global-display-line-numbers-mode 1)

;; ido
(ido-mode 1)
(ido-everywhere 1)
(setq ido-auto-merge-work-directories-length -1)
;; (ido-ubiquitous-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil xenops)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
