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

;; Xenops
(unless (package-installed-p 'xenops)
  (package-install 'xenops))
(add-hook 'latex-mode-hook #'xenops-mode)
(add-hook 'LaTeX-mode-hook #'xenops-mode)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)

;; Org Roam
(unless (package-installed-p 'org-roam)
  (package-install 'org-roam))
(require 'org-roam)
(if (file-exists-p "~/OrgRoam") nil
    (make-directory "~/OrgRoam"))
(setq org-roam-directory "~/OrgRoam")
(org-roam-db-autosync-mode)

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

;; Recentf
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-terms 25)
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))
(global-set-key "\C-x\ \C-r" 'recentf-ido-find-file)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/OrgRoam/things_to_do.org" "/home/tau/OrgRoam/hello_roam.org"))
 '(package-selected-packages '(evil org-roam xenops)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
