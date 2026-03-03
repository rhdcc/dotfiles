(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(use-package emacs
  :init
  (setq custom-file
    (expand-file-name "custom.el" user-emacs-directory))
  (load custom-file)
  :config
  ;; Font
  (set-frame-font "Iosevka Nerd Font Mono")

  ;; Theme
  (load "~/.emacs.d/fleury-theme.el")
  (load-theme 'fleury t)

  ;; General Settings
  (setq inhibit-startup-message t)
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0)
  (column-number-mode 1)
  (global-display-line-numbers-mode 1)

  (setq-default tab-width 4)  ; Set the default tab width to 4 spaces
  (setq-default indent-tabs-mode nil)  ; Use spaces instead of tabs
  (setq c-basic-offset 4)  ; Set C mode indentation to 4 spaces


  ;; Which key
  (which-key-mode 1)

  ;; Ido
  ;; (ido-mode 1)
  ;; (ido-everywhere 1)
  ;; (setq ido-auto-merge-work-directories-length -1)
  ;; (ido-ubiquitous-mode 1)

  ;; Fido
  (fido-mode 1)
  (fido-vertical-mode 1)

  ;; Recentf
  (recentf-mode 1)
  (setq recentf-max-menu-items 25)
  (setq recentf-max-saved-terms 25))

;; Xenops
(use-package xenops
  :if nil
  :init
  ;; (add-hook 'latex-mode-hook #'xenops-mode)
  ;; (add-hook 'LaTeX-mode-hook #'xenops-mode)
  :config
  ;; (xenops-mode 1))

;; LaTeX
(use-package tex
  :ensure auctex)

;; Evil
(use-package evil
  :config
  (evil-mode 1))

;; Org Roam
(use-package org-roam
  :init
  (if (file-exists-p "~/OrgRoam") nil
      (make-directory "~/OrgRoam"))
  :config
  (setq org-roam-directory "~/OrgRoam")
  (org-roam-db-autosync-mode))
