(require 'package) (setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(linum-relative-global-mode t)
 '(package-selected-packages
   (quote
    (pdf-tools elpy nav-flash powerline evil-leader neotree ivy color-theme-sanityinc-tomorrow color-theme-tomorrow solaire-mode paredit linum-relative sublime-themes doom-themes evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defmacro use-install-package (name &rest args)
  `(use-package
     ,name
     :ensure t
     ,@args)) 


(defmacro setup-packages (&rest packages)
  `(progn
     ,@(let ((use-install-list '()))
	 (dolist
	     (package packages use-install-list)
	   (setf use-install-list
		 (append (list `(use-install-package ,@package))
			 use-install-list))))))


(setup-packages
 (evil
  :config
  (evil-mode 1))
 (doom-themes
  :config
  (load-theme 'doom-tomorrow-night t)
  (doom-themes-neotree-config)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))
 (linum-relative
  :init
  (setq linum-relative-current-symbol "")
  :config
  (linum-relative-on))
 (paredit
  :config
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode))
 (solaire-mode
  :config
  (add-hook 'after-change-major-mode-hook #'turn-on-solaire-mode)
  (add-hook 'minibuffer-setup-hook #'solaire-mode-in-minibuffer)
  (solaire-mode-swap-bg))
 (ivy
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode 1))
 (neotree
  :init
  (setq neo-smart-open t)
  (setq neotree-open-p nil)
  :config
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "<backtab>") (lambda () (interactive) (neotree-dir ".."))))
 (spaceline
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme)
  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-buffer-position-off)
  (spaceline-toggle-hud-off)
  (spaceline-toggle-buffer-encoding-abbrev-off)
  (spaceline-toggle-line-column-off))
 (elpy
  :config
  (elpy-enable)
  (pyvenv-activate "~/venv/"))
 (pdf-tools)
 (evil-leader
  :config
  (evil-leader/set-leader "<SPC>")
  (global-evil-leader-mode)
  (evil-leader/set-key "f t" 'neotree-show)))

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(global-hl-line-mode 1)

(set-face-attribute
 'default nil
 :family "Fira Mono"
 :height 90)
