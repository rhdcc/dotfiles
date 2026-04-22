(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(use-package emacs
  :init
  (if (file-exists-p "~/.emacs.d/custom.el") nil
	(make-empty-file "~/.emacs.d/custom.el"))
  (setq custom-file
    (expand-file-name "custom.el" user-emacs-directory))
  (load custom-file)

  (if (file-exists-p "~/.emacs.d/backups/") nil
    (make-directory "~/.emacs.d/backups/"))
  :config
  ;; Backups directory
  (setq backup-directory-alist
    '((".*" . "~/.emacs.d/backups/")))
  
  ;; Font
  (set-frame-font "Iosevka Nerd Font Mono")

  ;; Theme
  ;; (load "~/.emacs.d/fleury-theme.el")
  (load "~/.emacs.d/gruber-darker-theme.el")
  (load-theme 'gruber-darker t)

  ;; General Settings
  (setq inhibit-startup-message t)
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0)
  (column-number-mode 1)
  (global-display-line-numbers-mode 1)
  (setq confirm-kill-emacs 'y-or-n-p)

  (setq-default tab-width 4)          ;; Set the default tab width to 4 spaces
  (setq-default indent-tabs-mode nil) ;; Use spaces instead of tabs
  (setq c-basic-offset 4)             ;; Set C mode indentation to 4 spaces

  (setq scroll-conservatively 101)
  
  ;; Which key
  (which-key-mode 1)

  ;; Ido
  ;; (ido-mode 0)
  ;; (ido-everywhere 0)
  ;; (setq ido-auto-merge-work-directories-length -1)
  ;; (ido-ubiquitous-mode 1)

  ;; Fido
  (fido-mode 1)
  (fido-vertical-mode 1)

    ;; Recentf
  (recentf-mode 1)
  (setq recentf-max-menu-items 25)
  (setq recentf-max-saved-terms 25))

;; Marginalia
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;; LaTeX
(use-package tex
  :ensure auctex)

;; Evil
(use-package evil
  :ensure nil
  :init
  (evil-mode 0))

;; Magit
(use-package magit
  :ensure t)

;; Org Roam
(use-package org-roam
  :ensure t
  :init
  (if (file-exists-p "~/OrgRoam") nil
    (make-directory "~/OrgRoam"))
  :config
  (setq org-roam-directory "~/OrgRoam")
  (org-roam-db-autosync-mode))
