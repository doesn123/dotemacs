(require 'package)
(package-initialize)

(setq user-emacs-directory "~/.emacs.d/.emacs.d-vanilla")

(setq package-archives
			    '(("gnu-elpa" . "https://elpa.gnu.org/packages/")
			      ("gnu-elpa-devel" . "https://elpa.gnu.org/devel/")
			      ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			      ("melpa" . "https://melpa.org/packages/")))

(add-to-list 'load-path '"~/.emacs.d/.emacs.d-vanilla/lisp/")

(setq package-user-dir "~/.emacs.d/.emacs.d-vanilla/elpa/")

(package-initialize)
(vertico-mode)


(require 'xah-fly-keys)
(xah-fly-keys-set-layout "colemak-dhm")
(xah-fly-keys 1)


(keymap-set key-translation-map "<escape>" "C-g")

(setq initial-buffer-choice "~/.emacs.d/.emacs.d-vanilla/init.el")

(add-hook 'window-setup-hook 'toggle-frame-maximized)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

(keymap-global-set "<f10>" 'menu-bar-mode)
	      ; Themes
(defvar gh-modus-themes-light
  '(modus-operandi
    modus-operandi-tritanopia
    modus-operandi-deuteranopia
    modus-operandi-tinted))

(defvar gh-modus-themes-dark
  '(modus-vivendi
    modus-vivendi-tinted
    modus-vivendi-deuteranopia
    modus-vivendi-tritanopia))

(defun gh-load-random-ef-theme-variant-dep-on-time-of-day ()
  (let ((now (string-to-number (format-time-string "%H" (current-time)))))
    (if (and (<= now 19)
	     (>= now 7))
	(ef-themes-load-random 'light)
      (ef-themes-load-random 'dark))))

(gh-load-random-ef-theme-variant-dep-on-time-of-day)

(set-face-attribute 'default nil :height 140)

(setq-default mode-line-format
	      '("%e" mode-line-front-space
		(:propertize
		 (" VANILLA EMACS - FOR TESTING ONLY " mode-line-mule-info mode-line-client mode-line-modified mode-line-remote)
		 display
		 (min-width
		  (5.0)))
		mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position
		(vc-mode vc-mode)
		"  " mode-line-modes mode-line-misc-info mode-line-end-spaces))


