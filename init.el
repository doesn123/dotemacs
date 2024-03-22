;appearance 
(setq inhibit-startup-screen t)
(hl-line-mode)
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
  (unless package-archive-contents
    (package-refresh-contents))
  (unless (package-installed-p package)
    (package-install package)))

(gh/package-management 'xah-fly-keys)
(gh/package-management 'orderless)
;keybinding
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

(define-key key-translation-map (kbd "<escape>") (kbd "C-g"))

(define-key xah-fly-command-map (kbd ",") 'crux-other-window-or-switch-buffer)
(define-key xah-fly-command-map (kbd "8") 'er/expand-region)
(define-key xah-fly-command-map (kbd "'") 'consult-line)
;; (keymap-global-set "<f12>" 'dabbrev-expand)
(global-set-key (kbd "C-x C-x") #'eval-last-sexp)
;orderless
(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

;dired
(define-key dired-mode-map (kbd "DEL") 'dired-up-directory)

;packages
(gh/package-management 'crux)
(gh/package-management 'expand-region)
(gh/package-management 'centered-cursor-mode)
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

;substitute
(require 'substitute)

(setq substitute-fixed-letter-case t)

;; If you want a message reporting the matches that changed in the
;; given context.  We don't do it by default.
(add-hook 'substitute-post-replace-functions #'substitute-report-operation)

(let ((map global-map))
   (define-key map (kbd "M-s") #'substitute-target-below-point)
   (define-key map (kbd "M-r") #'substitute-target-above-point)
   (define-key map (kbd "M-d") #'substitute-target-in-defun)
   (define-key map (kbd "M-b") #'substitute-target-in-buffer))

(dolist (hook '(text-mode-hook prog-mode-hook conf-mode-hook))
  (add-hook hook #'jinx-mode))
;(keymap-global-set "C-/" #'jinx-correct)
(vertico-mode)
(marginalia-mode)
(battery-notifier-mode)

(add-hook 'after-init-hook #'fancy-battery-mode)
(add-hook 'after-init-hook #'ef-themes-load-random)
(setq fancy-battery-show-percentage t)

(global-set-key (kbd "<f7>") 'eshell)
(global-set-key (kbd "C-.") 'embark-act)

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

					;abbrev mode
(setq-default abbrev-mode t)


(defun pipe-symbol-insert ()
  (interactive)
  (insert "|"))

(defun backquote-symbol-insert ()
  (interactive)
  (insert "`"))
