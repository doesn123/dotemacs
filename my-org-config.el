(add-to-list 'default-frame-alist '(fullscreen . maximized))
(desktop-save-mode 1)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '(("melpa" . "https://melpa.org/packages/")
	      ("org" . "https://orgmode.org/elpa/")
	      ("elpa" . "https://elpa.gnu.org/packages/")))


(global-set-key (kbd "C-s") 'swiper)

(find-file "~/.emacs.d/my-org-config.org")

(package-initialize)
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

(marginalia-mode t)
(setq ivy-initial-inputs-alist nil)

(load-theme 'modus-vivendi t)

(dolist (mode '(eshell-mode-hook
                fundamental-mode-hook))
  (add-hook mode (lambda () (olivetti-mode))))

  ;; Using garbage magic hack.
  (use-package gcmh
    :config
    (gcmh-mode 1))
  ;; Setting garbage collection threshold
  (setq gc-cons-threshold 402653184
	gc-cons-percentage 0.6)

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))


(use-package saveplace
  :init (save-place-mode))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (message "*** Emacs loaded in %s with %d garbage collections."
		     (format "%.2f seconds"
			     (float-time
			      (time-subtract after-init-time before-init-time)))
		     gcs-done)))

(setq org-directory "~/OrgFiles")

(smooth-scrolling-mode t)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
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

;; (define-key xah-fly-command-map (kbd ",") 'xah-backward-left-bracket)
(define-key xah-fly-command-map (kbd "C-e") 'eval-last-sexp)

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
;(add-to-list 'load-path "~/.emacs.d/lisp/")
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
   '(avy modus-themes xclip which-key vertico-posframe use-package try smooth-scrolling rainbow-delimiters orderless olivetti marginalia magit key-chord helpful gcmh consult)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)


;; (use-package org-bullets		
;; :ensure t
;; :config
;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-confirm-babel-evaluate nil)
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-word-0)) 

(define-key org-mode-map (kbd "C-c C-l") 'org-insert-link)

(set-face-attribute 'default nil :height 170)

(add-hook 'find-file-hook
          (lambda ()
            (when (string= (file-name-extension buffer-file-name) "el")
              (xah-elisp-mode +1))))

(add-hook 'find-file-hook
          (lambda ()
            (when (string= (file-name-extension buffer-file-name) "el")
              (xah-elisp-mode +1))))
(global-set-key (kbd "C-<down>") 'scroll-other-window) 
(global-set-key (kbd "C-<up>") 'scroll-other-window-down)

(define-key minibuffer-local-map (kbd "M-o") 'ivy-dispatching-done)

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      '(("d" "Demo template" entry
	 (file+headline "demo.org" "our f heading")
	 "* DEMO text %?")
("p" "Promt for imput" entry
	 (file+headline "demo.org" "our f input")
	 "* %^{Please write here} %?")
("o" "options for prompt" entry
	 (file+headline "demo.org" "our f heading")
	 "* %^{Select option|ONE|TWO|THREE} %?")))

;; M-S-LEFT (org-table-delete-column)

(global-prettify-symbols-mode 1)
(global-set-key (kbd "C-c a") 'org-agenda)


      (setq org-agenda-files
	    '("~/Projects/Code/OrgFiles/Tasks.org"
	      "~/notes.org"
	      "~/Projects/Code/OrgFiles/Birthdays.org"))
(setq-default org-catch-invisible-edits 'error) 

;; (setq org-todo-keywords
;; '((sequence "TODO(t)" "|" "DONE(d)")
;;   (sequence "REPORT(r)" "BUG(b)" "KNO
