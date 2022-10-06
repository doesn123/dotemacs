(add-to-list 'default-frame-alist '(fullscreen . maximized))

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '(("melpa" . "https://melpa.org/packages/")
	      ("org" . "https://orgmode.org/elpa/")
	      ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))



(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(load-theme 'modus-vivendi t)
(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

  ;; (defun fontify-frame (frame)
    ;; (set-frame-parameter frame 'font "Consolas-19"))

(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'xah-fly-keys)
(xah-fly-keys-set-layout "colemak-dhm")

(xah-fly-keys 1)

(fset 'yes-or-no-p 'y-or-n-p)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(vertico-mode 1)
  (set-face-foreground 'mode-line "gray")
  (set-face-background 'mode-line "black")
  (set-face-foreground 'line-number "#565759")
(set-face-background 'line-number "#000000")

	(global-set-key (kbd "<f1>") 'check-parens)

(use-package which-key
:ensure t
:config
(which-key-mode))

(define-key xah-fly-command-map (kbd ",") 'xah-backward-left-bracket)
(define-key xah-fly-command-map (kbd "C-e") 'eval-last-sexp)

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(autoload 'xah-elisp-mode "xah-elisp-mode" "xah emacs lisp major mode." t)

  (define-key dired-mode-map (kbd "DEL") 'dired-up-directory)
  (setq dired-dwim-target t)
  (setq dired-hide-details-mode 1)

  (setq dired-recursive-copies 'top)

  (setq dired-recursive-deletes 'top)
  (defun xah-dired-mode-setup ()
    "to be run as hook for `dired-mode'."
    (dired-hide-details-mode 1))

  (add-hook 'dired-mode-hook 'xah-dired-mode-setup)

  (require 'dired )
  (define-key dired-mode-map (kbd "DEL") 'dired-up-directory)
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))

(setq save-abbrevs 'silently)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("183dfa34e360f5bc2ee4a6b3f4236e6664f4cfce40de1d43c984e0e8fc5b51ae" default))
 '(package-selected-packages
   '(modus-themes xclip which-key wc-mode vertico-posframe use-package undo-tree try smooth-scrolling rainbow-delimiters paredit orderless olivetti marginalia magit key-chord ivy-rich helpful helm-core general gcmh evil-collection counsel-projectile consult command-log-mode all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))


;; (use-package org-bullets		
;; :ensure t
;; :config
;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
