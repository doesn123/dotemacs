(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq initial-scratch-message "")
(setq desktop-path '("~/")) 
(desktop-save-mode 1)
(global-set-key (kbd "C-s") (lambda () (interactive) (swiper)))
(find-file "~/.emacs.d/my-org-config.org")
(fset 'yes-or-no-p 'y-or-n-p)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(smooth-scrolling-mode t)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(setq save-abbrevs 'silently)
(put 'narrow-to-region 'disabled nil)
(set-face-attribute 'default nil :height 170)
(setq custom-file null-device)

(use-package gcmh
  :config

  (gcmh-mode 1))
;; Setting garbage collection threshold
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

  (add-hook 'emacs-startup-hook
	(lambda ()
	  (message "*** Emacs loaded in %s with %d garbage collections."
		   (format "%.2f seconds"
			   (float-time
			    (time-subtract after-init-time before-init-time)))
		   gcs-done)))

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

(load-theme 'modus-vivendi t)
  (marginalia-mode t)
  (setq ivy-initial-inputs-alist nil)
  (global-prettify-symbols-mode 1)

  (define-key global-map (kbd "<f5>") #'modus-themes-toggle)
  (set-face-foreground 'mode-line "gray")
  (set-face-background 'mode-line "black")
  (set-face-foreground 'line-number "#565759")
  (set-face-background 'line-number "#000000")

;; (defun fontify-frame (frame)
;; (set-frame-parameter frame 'font "Consolas-19"))

(add-to-list 'load-path "~/.emacs.d/lisp/")
	    (require 'xah-fly-keys)
	    (xah-fly-keys-set-layout "colemak-dhm")
	    (xah-fly-keys 1)
	    (autoload 'xah-elisp-mode "xah-elisp-mode" "xah emacs lisp major mode." t)

	    ;; (define-key xah-fly-command-map (kbd ",") 'xah-backward-left-bracket)
    (define-key xah-fly-command-map (kbd "C-e") 'eval-last-sexp)
    (define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;    (define-key xah-fly-command-map (kbd "4") 'split-window-horizontally)
;    (define-key xah-fly-leader-key-map (kbd "4") 'split-window-vertically)

		  (add-hook 'find-file-hook
			    (lambda ()
			      (when (string= (file-name-extension buffer-file-name) "el")
				(xah-elisp-mode +1))))

		  (add-hook 'find-file-hook
			    (lambda ()
			      (when (string= (file-name-extension buffer-file-name) "el")
				(xah-elisp-mode +1))))
    (global-set-key (kbd "C-d") 'pop-global-mark)
    (define-key xah-fly-leader-key-map (kbd "z") 'jump-to-register)
    (global-set-key (kbd "C-d") 'pop-global-mark)

(dolist (mode '(eshell-mode-hook
			   fundamental-mode-hook))
	     (add-hook mode (lambda () (olivetti-mode))))

(vertico-mode 1)

(use-package orderless
     :ensure t
     :custom
     (completion-styles '(orderless basic))
     (completion-category-overrides '((file (styles basic partial-completion)))))

   (use-package saveplace
     :init (save-place-mode))

     (use-package which-key
     :ensure t
     :config
     (which-key-mode))

     (use-package avy
       :ensure t
       :bind ("M-s" . avy-goto-word-0))

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

(global-set-key (kbd "<f1>") 'check-parens)
(global-set-key (kbd "C-<down>") 'scroll-other-window) 
(global-set-key (kbd "C-<up>") 'scroll-other-window-down)
(define-key minibuffer-local-map (kbd "M-o") 'ivy-dispatching-done)
(global-set-key (kbd "C-x C-x") 'eval-last-sexp)

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      '(("q" "Emacs question" entry
	 (file+headline "notes.org" "Emacs questions")
	 "* text %?") 

	 ;; ("t" "Todooo" entry (file+headline "~/OrgFiles/notes.org" "tototo")
       ;; "* TODO %?\n  %i\n  %a")
      ("j" "Journal" entry (file+datetree "~/OrgFiles/notes.org" "Journal")
       "* %?\nEntered on %U\n  %i\n  %a")

		("f" "Promt for imput" entry
	 (file+headline "demo.org" "our f input")
	 "* %^{aa|bb|cc} %?")

	("p" "Promt for imput" entry
	 (file+headline "demo.org" "our f input")
	 "* %^{Please write here} %?")
	("o" "options for prompt" entry
	 (file+headline "demo.org" "our f heading")
	 "* %^{Select option|ONE|TWO|THREE} %?")))

;; M-S-LEFT (org-table-delete-column)

(define-key org-mode-map (kbd "C-c C-l") 'org-insert-link)
(setq org-directory "~/OrgFiles")

(use-package org-bullets
  :hook (( org-mode ) . org-bullets-mode))

  (setq org-confirm-babel-evaluate nil)
  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

(require 'org-tempo)
  (setq org-structure-template-alist
    '(("a" . "export ascii\n")
      ("el" . "emacs_lisp\n")
      ;; ("C" . "comment\n")
      ;; ("e" . "example\n")
      ;; ("E" . "export")
      ;; ("h" . "export html\n")
      ;; ("l" . "export latex\n")
      ;; ("q" . "quote\n")
      ;; ("s" . "src")
      ("v" . "verse\n")))

(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files
      '("~/Projects/Code/OrgFiles/Tasks.org"
	"~/OrgFiles/notes.org"
	"~/Projects/Code/OrgFiles/Birthdays.org"))
(setq-default org-catch-invisible-edits 'error)

(setq org-catch-invisible-edits 'smart)

  (setq org-list-demote-modify-bullet '(("+" . "-") ("-" . "+")("*" . "-")))

(defun check-cell ()
  (interactive)
  (let ((cell (org-table-get-field)))
    (if (string-match "[[:graph:]]" cell)
	(org-table-blank-field)
      (insert "X")
      (org-table-align))
    (org-table-next-row)))

(define-key org-mode-map (kbd "M-n") 'check-cell)
