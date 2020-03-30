; ---- Setup ------
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

; ----- Packages and Advanced Settings ------
(global-company-mode 1)
(setq company-idle-delay 0.1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :config
  (evil-collection-init))

(use-package general
  :ensure t
  :config
  (general-create-definer leader-def :prefix "SPC")
  (general-create-definer project-def :prefix "SPC p")
  (general-create-definer search-def :prefix "SPC /")
  (general-create-definer git-def :prefix "SPC g"))

(set-face-attribute 'default nil
		    :family "Hack Nerd Font"
		    :height 128
		    :weight 'medium
		    :width 'medium)

(use-package swiper-helm
  :ensure t
  :init
  (search-def :states '(normal visual)
    "b" 'swiper-helm))

(use-package helm
  :ensure t
  :after (general)
  :config
  (helm-mode 1)
  (general-define-key
  	   "M-x" 'helm-M-x
  	   "C-x C-f" 'helm-find-files)
  (leader-def :states 'normal
    "," 'helm-mini
    "." 'helm-find-files))

(use-package projectile
  :ensure t)

(use-package helm-rg
  :ensure t)

(use-package magit
  :ensure t
  :config
  (git-def :states 'normal
   "g" 'magit))

(use-package evil-magit
  :ensure t)

(use-package helm-projectile
  :ensure t
  :after (projectile general helm-rg)
  :init
  (project-def :states '(normal)
    "p" 'helm-projectile-switch-project
    "/" 'helm-projectile-find-file-dwim
    "r" 'helm-projectile-recentf
    "b" 'helm-projectile-switch-to-buffer)
  (search-def :states '(normal visual)
    "p" 'helm-projectile-rg))

(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-pyls-server-command '("python3" "-m" "pyls"))
  (add-hook 'python-mode-hook 'lsp)
  :commands lsp)

(use-package smart-mode-line-atom-one-dark-theme
  :ensure t)

(use-package smart-mode-line
  :ensure t
  :after (smart-mode-line-atom-one-dark-theme)
  :config
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'atom-one-dark)
  (sml/setup))

(use-package doom-themes
  :ensure t
  :config (load-theme 'doom-spacegrey t))

(use-package ggtags
  :ensure t
  :config
  (add-hook 'c-mode-hook 'ggtags-mode)
  (add-hook 'c++-mode-hook 'ggtags-mode))

(use-package evil-numbers
  :ensure t
  :after (evil general)
  :init (general-define-key
	 "C-c a" 'evil-numbers/inc-at-pt
	 "C-c x" 'evil-numbers/dec-at-pti))

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :config (push 'company-lsp company-backends))

(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)

; ----- Garbage ------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "855eb24c0ea67e3b64d5d07730b96908bac6f4cd1e5a5986493cbac45e9d9636" "7f791f743870983b9bb90c8285e1e0ba1bf1ea6e9c9a02c60335899ba20f3c94" default)))
 '(package-selected-packages
   (quote
    (evil-collection evil-magit magit helm-gtags evil-numbers minions moody swiper-helm helm-rg helm evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "#232830" :box (:line-width 3 :color "#2C323C"))))))
