;; init.el- yay!

;; line numbers:
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; undo, backups, and autosave
(auto-save-visited-mode)
(setq
 undo-tree-auto-save-history t
 undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))
 auto-save-visited-interval 1
 make-backup-files nil
)

;; Mouse stuff
(xterm-mouse-mode 1)
(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)

;; Tabs/spaces
(setq-default
 c-basic-offset 4
 tab-width 4
 indent-tabs-mode t
)

;; Etc emacs stuff
(menu-bar-mode -1)
(column-number-mode 1)
(show-paren-mode 1)
(setq inhibit-startup-screen t
	  mode-line-end-spaces nil
)

;; Extensions
(setq load-path (cons "~/.config/emacs/extensions" load-path))

;; simpc-mode
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; melpa and use-package setup
(require 'package)
(setq package-archives '(
  ("melpa" . "https://melpa.org/packages/")
  ("gnu" . "https://elpa.gnu.org/packages/")
  ("melpa-stable" . "https://stable.melpa.org/packages/")
))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
)
(eval-and-compile
  (setq use-package-always-ensure t
	use-package-expand-minimally t
  )
)

(use-package use-package-ensure-system-package)
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t
	    auto-package-update-hide-results t)
  (auto-package-update-maybe)
  )

;; pretty colors
(use-package vscode-dark-plus-theme
  :config (load-theme 'vscode-dark-plus t)
)
(set-background-color "#000000")
(add-to-list 'default-frame-alist '(background-color . "#000000"))

(use-package magit
  :pin melpa)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit use-package-ensure-system-package auto-package-update vscode-dark-plus-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
