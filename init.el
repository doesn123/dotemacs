;appearance 
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :height 140)
(global-hl-line-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode)
(blink-cursor-mode -1)
(add-hook 'window-setup-hook 'toggle-frame-maximized)
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; this prevents completely the logging of the warnings
 ;; (setq native-comp-async-report-warnings-errors nil)
(load custom-file)
;; (ef-themes-load-random 'dark)
;; (if (time-less-p nil (format-time-string "%Y"))) ;SORT
;; (1+ (string-to-number (format-time-string "%Y")))
(global-visual-line-mode)
;; (setq desktop-path '("~/")) 
;; (desktop-save-mode 1)
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(setq display-time-format " %a %e %b %H:%M ")
(setq display-time-default-load-average nil)

(display-time-mode 1)

;world clock
(setq display-time-world-time-format "%R // %z %Z	%A %d %B")
(setq zoneinfo-style-world-list
      '(("America/Los_Angeles" "Lance (LA)")
	("America/New_York" "Chris (NY)")
        ("Europe/Amsterdam" "Amsterdam")))

;package management
(setq package-archives
      '(("gnu-elpa" . "https://elpa.gnu.org/packages/")
        ("gnu-elpa-devel" . "https://elpa.gnu.org/devel/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

;my package management
(defun gh/package-management (package)
  (unless (package-installed-p package)
    (unless package-archive-contents
  (package-refresh-contents))
    (package-install package)))

(gh/package-management 'xah-fly-keys)
(gh/package-management 'orderless)
;keybinding - -= (and shift+keys)
(require 'xah-fly-keys)
(xah-fly-keys-set-layout "colemak-dhm")
(xah-fly-keys 1)


;basic setup
(add-to-list 'load-path '"~/.emacs.d/lisp/")
(savehist-mode 1)
(find-file "~/.emacs.d/init.el")
(setq large-file-warning-threshold nil)

(put 'narrow-to-region 'disabled t)

;; Highest number gets priority (what is not mentioned has priority 0)
(setq package-archive-priorities
      '(("gnu-elpa" . 3)
        ("melpa" . 2)
        ("nongnu" . 1)))


(keymap-set key-translation-map "<escape>" "C-g")
(keymap-set xah-fly-command-map "," 'crux-other-window-or-switch-buffer)
(keymap-set xah-fly-command-map "8" 'er/expand-region)

(keymap-set xah-fly-leader-key-map "t" 'consult-buffer)
(keymap-set xah-fly-leader-key-map "SPC" 'embark-dwim)
(keymap-set xah-fly-command-map "'" 'consult-line)

;; (keymap-global-set "C-|" (lambda () (interactive) (insert "~")))
(keymap-global-set "<f2>" 'rename-file)
(keymap-global-set "s-v" 'helpful-variable)
(keymap-global-set "s-f" 'helpful-callable)
(keymap-global-set "<f12>" 'dabbrev-expand)
(keymap-global-set "C-x C-s" #'eval-expression)
(keymap-global-set "C-x C-x" #'eval-defun)
(keymap-global-set "s-b" #'eval-buffer)
(keymap-global-set "C-x C-a" #'eval-expression)
(keymap-global-set "C-v" #'xah-paste-or-paste-previous)
(keymap-global-set "s-d" #'duplicate-line)
(keymap-global-set "C-n" #'scratch-buffer)

(keymap-global-set "M-<up>" (lambda () (interactive)(funcall #'scroll-other-window-down 1)))
(keymap-global-set "M-<down>" (lambda () (interactive)(funcall #'scroll-other-window 1)))

;orderless
(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))
;dired
(keymap-set dired-mode-map "DEL" 'dired-up-directory)

  (define-key dired-mode-map (kbd "1") #'dired-do-shell-command)

(defun gh/dired-setup ()
  (all-the-icons-dired-mode 1))

(add-hook 'dired-mode-hook #'dired-hide-details-mode)
(add-hook 'dired-mode-hook #'all-the-icons-dired-mode)
(setq dired-dwim-target t)
(setq dired-kill-when-opening-new-dired-buffer t)
(setq delete-by-moving-to-trash t)
(setq dired-listing-switches "-AGgFhlv --group-directories-first --time-style=long-iso")

(keymap-set dired-mode-map "<f10>" (lambda () (interactive) (dired default-directory "-lR")))

(defun dired-mark-or-xah-beginning-of-line-or-block ()
  (interactive)
  (if (eq major-mode 'dired-mode)
      (dired-mark 1)
    (xah-beginning-of-line-or-block)))

(defun gh/double-command (mode mode-command other-command)
  (interactive)
  (if (eq major-mode mode)
      mode-command
    other-command))

;packages
(gh/package-management 'crux)
(gh/package-management 'smooth-scrolling)
(gh/package-management 'helpful)
(gh/package-management 'all-the-icons-dired)
(gh/package-management 'expand-region)
(gh/package-management 'ef-themes)
(gh/package-management 'embark)
(gh/package-management 'embark-consult)
(gh/package-management 'jinx)
(gh/package-management 'magit)
(gh/package-management 'marginalia)
(gh/package-management 'modus-themes)
(gh/package-management 'orderless)
(gh/package-management 'try)
(gh/package-management 'vertico)
(gh/package-management 'vertico)
(gh/package-management 'xah-fly-keys)
(gh/package-management 'substitute)
(gh/package-management 'battery-notifier)
(gh/package-management 'rainbow-delimiters)
(gh/package-management 'fancy-battery)


(smooth-scrolling-mode 1)

(when (display-graphic-p)
  (require 'all-the-icons))
;; or
;substitute
(require 'substitute)

(setq substitute-fixed-letter-case t)

;; If you want a message reporting the matches that changed in the
;; given context.  We don't do it by default.
(add-hook 'substitute-post-replace-functions #'substitute-report-operation)

(let ((map global-map))
   (keymap-set map "M-s" #'substitute-target-below-point)
   (keymap-set map "M-r" #'substitute-target-above-point)
   (keymap-set map "M-d" #'substitute-target-in-defun)
   (keymap-set map "M-b" #'substitute-target-in-buffer))

(dolist (hook '(text-mode-hook prog-mode-hook conf-mode-hook))
  (add-hook hook #'jinx-mode))

;(keymap-global-set "C-/" #'jinx-correct)
(vertico-mode)
(marginalia-mode)
(battery-notifier-mode)

(add-hook 'after-init-hook #'fancy-battery-mode)
(add-hook 'after-init-hook #'ef-themes-load-random)
(setq fancy-battery-show-percentage t)

(keymap-global-set "<f7>" 'eshell)
(keymap-global-set "C-." 'embark-act)

					;abbrev mode
(setq-default abbrev-mode t)


(defun tilde-symbol-insert ()
  (interactive)
  (insert "~"))

(defun backquote-symbol-insert ()
  (interactive)
  (insert "`"))

;consult
;helpful
(global-set-key (kbd "C-h f") #'helpful-callable)

(keymap-global-set "C-h v" #'helpful-variable)
(keymap-global-set "C-h k" #'helpful-key)
(keymap-global-set "C-h k" #'helpful-key)
(keymap-global-set "C-h x" #'helpful-command)

;isearch
(setq isearch-repeat-on-direction-change t)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq isearch-wrap-pause nil)

;vertico
(define-key vertico-map (kbd "C-<up>") 'previous-history-element)
(define-key vertico-map (kbd "C-<down>") 'next-history-element)
(define-key vertico-map (kbd "C-v") 'xah-paste-or-paste-previous)
(define-key vertico-map (kbd "C-`") (lambda () (interactive) (insert "~/")))

(add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy) ;clears previous file path after typing '~/'

;openwith
    (when (require 'openwith nil 'noerror)
      (setq openwith-associations
            (list
             (list (openwith-make-extension-regexp
                    '("mpg" "mpeg" "mp3" "mp4"
                      "avi" "wmv" "wav" "mov" "flv"
                      "ogm" "ogg" "mkv"))
                   "mpv"
                   '(file))
             (list (openwith-make-extension-regexp
                    '("xbm" "pbm" "pgm" "ppm" "pnm"
                      "png" "gif" "bmp" "tif" "jpeg" "jpg"))
                   "geeqie"
                   '(file))
             (list (openwith-make-extension-regexp
                    '("doc" "xls" "ppt" "odt" "ods" "odg" "odp"))
                   "libreoffice"
                   '(file))
             '("\\.lyx" "lyx" (file))
             '("\\.chm" "kchmviewer" (file))
             (list (openwith-make-extension-regexp
                    '("pdf" "ps" "ps.gz" "dvi"))
                   "okular"
                   '(file))
             ))
      (openwith-mode 1))
