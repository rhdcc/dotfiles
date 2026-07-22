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
  ;; (load "~/.emacs.d/gruber-darker-theme.el")
  (load-theme 'wombat t)
  ;; (load-theme 'gruber-darker t)

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
  (setq cursor-type 'box)

  (defun my-org-preview-all-buffer ()
    "Preview all LaTeX fragments in the buffer."
    (interactive)
    (let ((current-prefix-arg '(16)))
      (call-interactively 'org-latex-preview)))

  (global-set-key (kbd "<f5>") 'my-org-preview-all-buffer)
  (add-hook 'org-mode-hook (lambda () (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.3))))
  
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

  ;; tab bar
  (setq tab-bar-close-button-show nil)
  (with-eval-after-load 'tab-bar
    (set-face-attribute 'tab-bar nil
                        :font (frame-parameter nil 'font)))

  ;; Recentf
  (recentf-mode 1)
  (setq recentf-max-menu-items 25)
  (setq recentf-max-saved-terms 25))

;; Rust
(use-package rust-mode
  :ensure t
  :init
  (add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil))))

;; Elgot
(use-package eglot
  :init
  (setq eglot-inlay-hints-mode 0))

;; Marginalia
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;; LaTeX
(use-package tex
  :ensure auctex)

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

(use-package go-mode
  :ensure t
  :mode "\\.go\\'")

(use-package sage-shell-mode
  :ensure t
  :config
  (setq sage-shell:sage-executable "~/sage_install_make/sage/sage"))

;; ── corfu ────────────────────────────────────────────────────────
(use-package corfu
  :ensure t
  :hook ((sage-shell-mode      . corfu-mode)
         (sage-shell:sage-mode . corfu-mode))
  :custom
  (corfu-auto        t)      ;; trigger automatically
  (corfu-auto-delay  0.3)
  (corfu-auto-prefix 2)
  (corfu-cycle       t)      ;; wrap around candidate list
  (corfu-quit-no-match 'separator))

;; corfu-popupinfo
(use-package corfu-popupinfo
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (setq corfu-popupinfo-delay 0)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-popupinfo-max-height 20)
  (corfu-popupinfo-max-width  70))

;; Sage docstring for corfu-popupinfo
(defun my/sage-doc-buffer (candidate)
  "Return a buffer with CANDIDATE's Sage docstring."
  (when (and (boundp 'sage-shell:process-buffer)
             sage-shell:process-buffer
             (buffer-live-p (get-buffer sage-shell:process-buffer)))
    (let ((doc (sage-shell:send-command-to-string
                (format "%s?" candidate)))
          (buf (get-buffer-create " *corfu-sage-doc*")))
      (with-current-buffer buf
        (erase-buffer)
        (insert (or doc "No documentation found."))
        (goto-char (point-min)))
      buf)))

(defun my/sage-capf-with-doc (capf)
  "Wrap a CAPF function to attach a Sage doc-buffer property."
  (lambda (&rest args)
    (let ((result (apply capf args)))
      (when (and result (listp result))
        (nconc result (list :company-doc-buffer #'my/sage-doc-buffer)))
      result)))

(defun my/sage-setup-corfu ()
  (advice-add 'sage-shell:completion-at-point-func :around
    (lambda (orig &rest args)
      (let ((result (apply orig args)))
        (when (listp result)
          (nconc result (list :company-doc-buffer #'my/sage-doc-buffer)))
        result))))

(add-hook 'sage-shell-mode-hook      #'my/sage-setup-corfu)
(add-hook 'sage-shell:sage-mode-hook #'my/sage-setup-corfu)
(add-hook 'sage-shell-mode-hook      #'eldoc-mode)
(add-hook 'sage-shell:sage-mode-hook #'eldoc-mode)

