(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message "george")  
(setq enable-recursive-minibuffers t)

	  (menu-bar-mode -1)
	  (tool-bar-mode -1)
	  (scroll-bar-mode -1)
	  (blink-cursor-mode -1)

	  (mapc
	   (lambda (command)
		   (put command 'disabled nil))
	   '(narrow-to-region upcase-region downcase-region))

	  ;; Make native compilation silent and prune its cache.
	  (when (native-comp-available-p)
		  (setq native-compile-prune-cache t))

	  (add-hook 'after-init-hook (lambda () (set-frame-name "home")))

	  (set-face-attribute 'default nil :height 140)
	  (fset 'yes-or-no-p 'y-or-n-p)
	  (show-paren-mode 1)
	  (add-hook 'window-setup-hook 'toggle-frame-maximized)

	  (setq custom-file (make-temp-file "emacs-custom-"))

	  (global-visual-line-mode)

	  (setq display-time-default-load-average nil)

	  (setq kill-buffer-query-functions
		  (remq 'process-kill-buffer-query-function
			 kill-buffer-query-functions))

	  ;; (display-time-mode -1)

	  (defun gh-toggle-menu-bar-mode ()
		  (interactive)
		  (menu-bar-mode 'toggle))


	  (keymap-global-set "<f10>" 'gh-toggle-menu-bar-mode)
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

		  (add-hook 'after-init-hook #'gh-load-random-ef-theme-variant-dep-on-time-of-day)

		  (setq consult-themes
			'("ef-\\|modus.*"))

(setq package-archives
			  '(("gnu-elpa" . "https://elpa.gnu.org/packages/")
			    ("gnu-elpa-devel" . "https://elpa.gnu.org/devel/")
			    ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			    ("melpa" . "https://melpa.org/packages/")))
(setq test "t1")
		    ;; Highest number gets priority (what is not mentioned has priority 0)
		    (setq package-archive-priorities
			  '(("gnu-elpa" . 3)
			    ("melpa" . 2)
			    ("nongnu" . 1)))

		    ; package management
		    (defun gh-package-management (package)
		      (unless (package-installed-p package)
			(unless package-archive-contents
		      (package-refresh-contents))
			(package-install package)))

		    (gh-package-management 'xah-fly-keys)
		    (gh-package-management 'orderless)
; keybinding - -= (and shift+keys)
		    (require 'xah-fly-keys)
		    (xah-fly-keys-set-layout "colemak-dhm")
		    (xah-fly-keys 1)

(add-to-list 'load-path '"~/.emacs.d/lisp/")

(setq savehist-file (locate-user-emacs-file "savehist"))
(setq history-length 100)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history t)
(setq savehist-additional-variables '(register-alist kill-ring))
(savehist-mode 1)

(rainbow-delimiters-mode 1)
(find-file "~/.emacs.d/george-config.org")
(setq large-file-warning-threshold nil)

(put 'narrow-to-region 'disabled t)

  (setq kill-read-only-ok t)

(setq display-time-world-time-format "%R // %z %Z	%A %d %B")
(setq zoneinfo-style-world-list
      '(("America/Los_Angeles" "Lance (LA)")
	("America/New_York" "Chris (NY)")
	("Europe/Amsterdam" "Amsterdam")))

(keymap-set key-translation-map "<escape>" "C-g")
(keymap-set xah-fly-command-map "." 'crux-other-window-or-switch-buffer)
(keymap-set xah-fly-command-map "," 'ignore)
;; (keymap-set xah-fly-command-map ">" (lambda () (interactive) (switch-to-buffer (other-buffer (current-buffer)))))

(keymap-set xah-fly-command-map "8" 'er/expand-region)

(keymap-set xah-fly-leader-key-map "t" 'consult-buffer)
(keymap-set xah-fly-leader-key-map "SPC" 'embark-dwim)

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
(keymap-global-set "s-d" (lambda () (interactive) (duplicate-line) (next-line)))
(keymap-global-set "C-n" #'scratch-buffer)

(keymap-global-set "M-<up>" (lambda () (interactive) (scroll-other-window-down 1)))
(keymap-global-set "M-<down>" (lambda () (interactive) (scroll-other-window 1)))

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

(keymap-set dired-mode-map "DEL" 'dired-up-directory)

	      (define-key dired-mode-map (kbd "1") #'dired-do-shell-command)

	    (defun gh-dired-setup ()
	      (all-the-icons-dired-mode 1))
	    (global-hl-line-mode)
	    (add-hook 'dired-mode-hook #'dired-hide-details-mode)
	    (add-hook 'dired-mode-hook #'all-the-icons-dired-mode)
	    (add-hook 'dired-mode-hook #'hl-line-mode)
	    (setq dired-dwim-target t)
	    (setq dired-kill-when-opening-new-dired-buffer t)
	    (setq delete-by-moving-to-trash t)
	    (setq dired-listing-switches "-AGgFhlv --group-directories-first --time-style=long-iso")
	    (setq dired-recursive-copies 'always)
	    (setq dired-recursive-deletes 'always)

	    (keymap-set dired-mode-map "<f10>" (lambda () (interactive) (dired default-directory "-lR")))

	    (defun dired-mark-or-xah-beginning-of-line-or-block ()
	      (interactive)
	      (if (eq major-mode 'dired-mode)
		  (dired-mark 1)
		(xah-beginning-of-line-or-block)))

(defun dired-revert-buffer-or-xah-delete-current-text-block ()
	    (interactive)
	    (if (eq major-mode 'dired-mode)
		(revert-buffer)
	      (xah-delete-current-text-block)))

	    ;; (defun gh-dired-goto-file-or-undo (&opt file)
	      ;; (interactive)
	      ;; (or (eq major-mode 'dired-mode)
	    ;; 
	      ;; (if (eq major-mode 'dired-mode)
		  ;; (gh-dired-goto-file (file))
		;; (undo))))

	    ;; (defun gh-dired-goto-file (file)
	      ;; (interactive "f")
	      ;; (dired-goto-file (expand-file-name file)))

	    (defun gh-double-command (mode mode-command other-command)
	      (interactive)
	      (if (eq major-mode mode)
		  mode-command
		other-command))

	    (keymap-set xah-fly-command-map "m" 'dired-mark-or-xah-beginning-of-line-or-block)
	    (keymap-set xah-fly-command-map "g" 'dired-revert-buffer-or-xah-delete-current-text-block)
	    ;; (keymap-set xah-fly-command-map "j" 'gh-dired-goto-file-or-undo)

(gh-package-management 'crux)
(gh-package-management 'hydra)
(gh-package-management 'visual-regexp)
(gh-package-management 'denote)
(gh-package-management 'smooth-scrolling)
(gh-package-management 'helpful)
(gh-package-management 'all-the-icons-dired)
(gh-package-management 'expand-region)
(gh-package-management 'ef-themes)
(gh-package-management 'embark)
(gh-package-management 'embark-consult)
(gh-package-management 'jinx)
(gh-package-management 'magit)
(gh-package-management 'marginalia)
(gh-package-management 'modus-themes)
(gh-package-management 'orderless)
(gh-package-management 'try)
(gh-package-management 'vertico)
(gh-package-management 'vertico)
(gh-package-management 'xah-fly-keys)
(gh-package-management 'substitute)
(gh-package-management 'battery-notifier)
(gh-package-management 'rainbow-delimiters)
(gh-package-management 'fancy-battery)
;; (gh-package-management 'savekill)

(smooth-scrolling-mode 1)
;; (require 'savekill)
(setq savehist-additional-variables '(register-alist kill-ring))

(when (display-graphic-p)
  (require 'all-the-icons))

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

(dolist (hook '(text-mode-hook))
  (add-hook hook #'jinx-mode))

;(keymap-global-set "C-/" #'jinx-correct)
(vertico-mode)
(marginalia-mode)
(battery-notifier-mode)

(add-hook 'after-init-hook #'fancy-battery-mode)

(setq fancy-battery-show-percentage t)

(keymap-global-set "<f7>" 'eshell)
(keymap-global-set "C-." 'embark-act)

(setq-default abbrev-mode t)


(defun tilde-symbol-insert ()
  (interactive)
  (insert "~"))

(defun backquote-symbol-insert ()
  (interactive)
  (insert "`"))

;; (keymap-set xah-fly-command-map "F" #'consult-locate)
  (keymap-set xah-fly-command-map "%" #'consult-buffer-other-frame)
  (keymap-set xah-fly-command-map "I" #'consult-org-heading)
  (keymap-set xah-fly-command-map "R" #'consult-ripgrep)
  (keymap-set xah-fly-command-map "M" #'consult-mark)
  (keymap-set xah-fly-command-map "B" #'consult-bookmark)
  (keymap-set xah-fly-command-map "G" #'consult-register-load)
  (keymap-set xah-fly-command-map "?" #'consult-info)
  (keymap-set xah-fly-command-map "E" #'consult-register)
  (keymap-set xah-fly-command-map "'" #'consult-line)
  (keymap-set xah-fly-command-map "O" #'occur)
  ;; (keymap-set xah-fly-command-map "" 'consult-line-multi) ;use '"' 

  ;;consult find commands (use hydra)
;fd,locate,grep

  ;; consult-narrow
  ;; consult-org-agenda
  ;; consult-focus-lines
  ;; consult-global-mark
  ;; consult-org-heading
  ;; consult-complex-command
  (keymap-global-set "s-a" 'consult-yank-from-kill-ring)

(keymap-global-set "C-h f" #'helpful-callable)

(keymap-global-set "C-h v" #'helpful-variable)
(keymap-global-set "C-h k" #'helpful-key)
(keymap-global-set "C-h k" #'helpful-key)
(keymap-global-set "C-h x" #'helpful-command)

(setq isearch-repeat-on-direction-change t)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq isearch-wrap-pause nil)
(setq isearch-lax-whitespace nil)

(define-key vertico-map (kbd "C-<up>") 'previous-history-element)
(define-key vertico-map (kbd "C-<down>") 'next-history-element)
(define-key vertico-map (kbd "C-v") 'xah-paste-or-paste-previous)

(add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy) ;clears previous file path after typing '~/'

(keymap-set dired-mode-map "M-RET" 'browse-url-of-dired-file)

(defun umount-other-docs 
    ()
  (interactive)
  (shell-command "sudo umount ~/other-docs&")
  (dired "~/other-docs"))

(defun mount-other-docs ()
    (interactive)
    (shell-command "sudo mount -t ecryptfs ~/other-docs ~/other-docs -o key=passphrase,ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_passthrough=no,ecryptfs_enable_filename_crypto=yes,ecryptfs_sig=$(sudo cat /root/.ecryptfs/sig-cache.txt)&")

    (switch-to-buffer "*Async Shell Command*")
    (delete-other-windows)
    (xah-fly-insert-mode-init)
    (dired "~/other-docs")
    (revert-buffer)
    )

(defun hydra-ex-point-mark ()
	  "Exchange point and mark."
	  (interactive)
	  (if rectangle-mark-mode
	      (rectangle-exchange-point-and-mark)
	    (let ((mk (mark)))
	      (rectangle-mark-mode 1)
	      (goto-char mk))))

	  (defhydra hydra-rectangle (:body-pre (rectangle-mark-mode 1)
					       :color pink
					       :post (deactivate-mark))
		"
	    _s_tring _d_:yank _b_:reset _c_opy _j_:undo _e_xchange _x_kill _n_umbers _o_pen c_l_ear _w_hitespace re_g_ister
		      "
		("e" hydra-ex-point-mark nil)
		  ("o" open-rectangle nil)
		("c" copy-rectangle-as-kill nil)
		("b" (if (region-active-p)
			 (deactivate-mark)
		       (rectangle-mark-mode 1)) nil)
		("d" yank-rectangle nil)
		("g" copy-rectangle-to-register nil)
		("w" delete-whitespace-rectangle nil)
		("n" rectangle-number-lines nil)
		("l" clear-rectangle nil)
		("j" undo nil)
		("s" string-rectangle nil)
		("x" kill-rectangle nil)
		("<left>" rectangle-left-char nil :color pink)
		("<right>" rectangle-right-char nil :color pink)
		("C-g" nil)
		("RET" nil)
		)
(keymap-global-set "C-x SPC" 'hydra-rectangle/body)

	    (defun gh-paste-clipboard-into-buffer ()
	      "Paste contents of clipboard into current buffer"
	      (interactive)
	      (xah-new-empty-buffer)
	      (yank))

(keymap-global-set "C-S-n" #'gh-paste-clipboard-into-buffer)

	    (defun gh-no-kill-ring-if-blank (str)
	      "DOCSTRING"
	      (interactive)
	      (unless (string-blank-p str) str))

	    (setq kill-transform-function #'gh-no-kill-ring-if-blank)


    ;; 	(defun my-q-insert-or-quit-window (&optional n)
    ;; 	  (interactive "p")
    ;; 	  (unless (and (equal (buffer-name) "george-config.org")
    ;; 		       buffer-read-only
    ;; 		       (not (eq major-mode 'dired-mode))
    ;; 		       (quit-window))))

    ;; (define-key xah-fly-command-map (kbd "q") #'my-q-insert-or-quit-window)

	  ;; (defun my-q-insert-or-quit-window (&optional n) (interactive "p") (if buffer-read-only (quit-window) (xah-reformat-lines)))


	  (defun newline-without-break-of-line ()
			(interactive)
			(save-excursion
			  (let ((oldpos (point)))
			  (end-of-line)
			  (newline-and-indent))))

	  (define-key xah-fly-command-map (kbd "r") #'newline-without-break-of-line)


	  (defun narrow-or-widen-dwim (p)
	    "Widen if buffer is narrowed, narrow-dwim otherwise.
	  Dwim means: region, org-src-block, org-subtree, or
	  defun, whichever applies first. Narrowing to
	  org-src-block actually calls `org-edit-src-code'.

	  With prefix P, don't widen, just narrow even if buffer
	  is already narrowed."
	    (interactive "P")
	    (declare (interactive-only))
	    (cond ((and (buffer-narrowed-p) (not p)) (widen))
		  ((region-active-p)
		   (narrow-to-region (region-beginning)
				     (region-end)))
		  ;; ((derived-mode-p 'org-mode)
		   ;; `org-edit-src-code' is not a real narrowing
		   ;; command. Remove this first conditional if
		   ;; you don't want it.
		   ;; (cond ((ignore-errors (org-edit-src-code) t)
			  ;; (delete-other-windows))
			 ;; ((ignore-errors (org-narrow-to-block) t))
			 ;; (t (org-narrow-to-subtree))))
		  ((derived-mode-p 'latex-mode)
		   (LaTeX-narrow-to-environment))
		  (t (narrow-to-defun))))

	  ;; (define-key endless/toggle-map "n"
	  ;; #'narrow-or-widen-dwim)

	  ;; This line actually replaces Emacs' entire narrowing
	  ;; keymap, that's how much I like this command. Only
	  ;; copy it if that's what you want.
	  (define-key ctl-x-map "n" #'narrow-or-widen-dwim)
	  (add-hook 'LaTeX-mode-hook
		    (lambda ()
		      (define-key LaTeX-mode-map "\C-xn"
				  nil)))

	  (keymap-global-set "C-c n" #'narrow-or-widen-dwim)

	(defhydra hydra-artist (:pre (artist-mode) :color pink :post (artist-mode-off))
	  ("C-p" artist-select-op-pen-line "pen")
	  ("C-r" artist-select-op-rectangle "rect")
	  ("C-l" artist-select-op-line "line")
	  ("C-c" artist-select-op-circle "circle")
	  ("C-s" artist-select-op-square "square")
	  ("C-s" artist-select-op-square "square")
	  ("C-e" artist-select-op-ellipse "ellipse")
	  ("C-y" artist-select-op-poly-line "poly line")
	  ("C-z" artist-select-op-spray-con "spray can")
	  ("C-q" nil "quit")
	  ("C-h" backward-char "back"))

	(keymap-global-set "M-a" #'hydra-artist/body)

(defhydra hydra-consult-find (:color blue)
       ("f" consult-fd "fd")
       ("l" consult-locate "locate")
       ("g" consult-grep "grep")
       ("G" consult-git-grep "git-grep")
       ("r" consult-ripgrep "ripgrep")
       ("m" consult-line-multi "line-multi")
       ("m" consult-global-mark "global-mark")
       ("k" consult-keep-lines "keep-lines")
       ("F" consult-focus-lines "focus-lines"))

   (keymap-set xah-fly-command-map "F" #'hydra-consult-find/body)

	(defhydra hydra-register (:color blue)
	  ("i" insert-register "insert")
	  ("c" copy-to-register "copy")
	  ("p" point-to-register "point")
	  ("a" append-register "append")
	  ("+" increment-register "increment")
	  ("m" kmacro-register "macro")
	  ("n" number-to-register "number")
	  ("e" prepend-to-register "prepent")
	  ("r" consult-register "consult")
	  ("R" copy-rectangle-to-register "rect")
	  ("f"   frameset-to-register "frameset")
	  ("w" window-configuration-to-register "win"))

	(defhydra hydra-kmacro (:color blue)
	  ("v" kmacro-view-macro "view")
	  ;; ("o" kmacro-pop-ring "pop")
	  ;; ("p" kmacro-push-ring "push")
	  ;; ("h" kmacro-ring-head "ring head")
	  ("w" kmacro-swap-ring "swap")
	  ("e" kmacro-edit-macro "edit")
	  ("b" kmacro-bind-to-key "bind")
	  ("s" kmacro-set-counter "set counter")
	  ("a" kmacro-add-counter "add counter")
	  ("i" kmacro-insert-counter "insert counter")
	  ("r" kmacro-to-register "reg")
	  ("d" kmacro-display-counter "display counter")
	  ("n" kmacro-name-last-macro "name last"))

	;; (defhydra hydra-kmacro (:color blue)
	;; ("v" kmacro-view-macro "view")
	;; ;; ("o" kmacro-pop-ring "pop")
	;; ;; ("p" kmacro-push-ring "push")
	;; ;; ("h" kmacro-ring-head "ring head")
	;; ("w" kmacro-swap-ring "swap")
	;; ("e" kmacro-edit-macro "edit")
	;; ("b" kmacro-bind-to-key "bind")
	;; ("s" kmacro-set-counter "set counter")
	;; ("a" kmacro-add-counter "add counter")
	;; ("i" kmacro-insert-counter "insert counter")
	;; ("r" kmacro-to-register "reg")
	;; ("d" kmacro-display-counter "display counter")
	;; ("n" kmacro-name-last-macro "name last"))

(keymap-global-set "M-w" #'hydra-window/body)
(keymap-global-set "M-r" #'hydra-register/body)


(defun ora-ex-point-mark ()
  (interactive)
  (if rectangle-mark-mode
      (exchange-point-and-mark)
    (let ((mk (mark)))
      (rectangle-mark-mode 1)
      (goto-char mk))))

(defun ora-ex-point-mark ()
  (interactive)
  (if rectangle-mark-mode
      (exchange-point-and-mark)
    (let ((mk (mark)))
      (rectangle-mark-mode 1)
      (goto-char mk))))

(keymap-global-set "<left-fringe> <mouse-1>" #'display-line-numbers-mode)
(keymap-global-set "<mouse-3>" #'eval-last-sexp)


(defun emacs-Q ()
  "DOCSTRING"
  (interactive)
  (start-process "my-emacs-process" nil "emacs" "-Q"))

(setq-default mode-line-format
				  '("%e"
				    " "
				    gh-my-mode-line-buffer-name
				    gh-mode-line-padding
				    gh-mode-line-narrowing
				    gh-mode-line-kmacro
				    gh-mode-line-buffer-read-only
				    gh-mode-line-major-mode
				    gh-mode-line-padding
				    ;; gh-mode-line-git
				    gh-mode-line-time-and-date
				    ))

		    (defvar-local gh-my-mode-line-buffer-name
			'(:eval
			    (format "%s "
				    (propertize (buffer-name) 'face 'alert-normal-face))
			    ))

		    ;; (defvar-local gh-mode-line-git
		    ;;     '(:eval
		    ;;       (when (mode-line-window-selected-p)
		    ;; 	(format "%s"
		    ;; 		(propertize vc-mode 'face 'warning)))))

		    (defvar-local gh-mode-line-major-mode
			'(:eval
			  (when (mode-line-window-selected-p)
			  (format " %s "
				  (propertize (symbol-name major-mode) 'face 'bold)))))

		    (defvar-local gh-mode-line-time-and-date
			'(:eval
			  (when (mode-line-window-selected-p)
			    (propertize (format-time-string " %a%e %b, %H:%M") 'face 'abbrev-table-name))))

(defvar-local gh-mode-line-buffer-read-only
		      '(:eval
			(when buffer-read-only
			  (if (mode-line-window-selected-p)
			  (propertize " \(ro\)" 'face 'all-the-icons-blue)
			  (propertize " \(ro\)" 'face 'shadow)))))

		    (defvar-local gh-mode-line-padding
			'(:eval
			  (when (mode-line-window-selected-p)
			    "---")))

		    (defvar-local gh-mode-line-narrowing
			'(:eval
			  ;; (setq gh-mode-line-padding nil)
			  (when (buffer-narrowed-p)
			    (if (mode-line-window-selected-p)
			    (propertize " \(narrowed\)" 'face 'error)
			    (propertize " \(narrowed\)" 'face 'shadow)))))


		    (defvar gh-mode-line-kmacro
		      '(:eval
			(when (and (mode-line-window-selected-p)
				   defining-kbd-macro)
			  " KMacro ")))

		    (dolist (construct
			     '(gh-mode-line-major-mode
			       gh-mode-line-padding
			       gh-mode-line-kmacro
			       gh-mode-line-narrowing
			       gh-mode-line-buffer-read-only
			       gh-mode-line-time-and-date
			       gh-my-mode-line-buffer-name))
		      (put construct 'risky-local-variable t))

;to add: **-,  line nums, % through document, Git, battery, get rid of padding when narrowed    534:		    ;buffer ;management


		    ;buffer management

		    (defun gh-make-window-current (window)
		      (select-window window))

		    (setq display-buffer-alist
			  '(
			    ("\\*Occur\\*"
			     (display-buffer-reuse-window
			      display-buffer-below-selected)
			     (window-height . fit-window-to-buffer)
			     (dedicated . t)
			    (body-function . gh-make-window-current))
			    ("\\*helpful.*"
			     (display-buffer-reuse-window
			      display-buffer-below-selected)
			     )))

      ;org
	    (setq org-use-speed-commands t)
		    (setq org-structure-template-alist
			  '(
			    ("a" . "export ascii")
		     ("e" . "src emacs-lisp")
		     ("t" . "src emacs-lisp :tangle \" \"")
		     ("l" . "src lua")
		     ("v" . "verse")))

		    (keymap-global-set "C-c C-," 'org-insert-structure-template)

(setq-default mode-line-format
				  '("%e"
				    " "
				    gh-my-mode-line-buffer-name
				    gh-mode-line-padding
				    gh-mode-line-narrowing
				    gh-mode-line-kmacro
				    gh-mode-line-buffer-read-only
				    gh-mode-line-major-mode
				    gh-mode-line-padding
				    ;; gh-mode-line-git
				    gh-mode-line-time-and-date
				    ))

		    (defvar-local gh-my-mode-line-buffer-name
			'(:eval
			    (format "%s "
				    (propertize (buffer-name) 'face 'alert-normal-face))
			    ))

		    ;; (defvar-local gh-mode-line-git
		    ;;     '(:eval
		    ;;       (when (mode-line-window-selected-p)
		    ;; 	(format "%s"
		    ;; 		(propertize vc-mode 'face 'warning)))))

		    (defvar-local gh-mode-line-major-mode
			'(:eval
			  (when (mode-line-window-selected-p)
			  (format " %s "
				  (propertize (symbol-name major-mode) 'face 'bold)))))

		    (defvar-local gh-mode-line-time-and-date
			'(:eval
			  (when (mode-line-window-selected-p)
			    (propertize (format-time-string " %a%e %b, %H:%M") 'face 'abbrev-table-name))))

(defvar-local gh-mode-line-buffer-read-only
		      '(:eval
			(when buffer-read-only
			  (if (mode-line-window-selected-p)
			  (propertize " \(ro\)" 'face 'all-the-icons-blue)
			  (propertize " \(ro\)" 'face 'shadow)))))

		    (defvar-local gh-mode-line-padding
			'(:eval
			  (when (mode-line-window-selected-p)
			    "---")))

		    (defvar-local gh-mode-line-narrowing
			'(:eval
			  ;; (setq gh-mode-line-padding nil)
			  (when (buffer-narrowed-p)
			    (if (mode-line-window-selected-p)
			    (propertize " \(narrowed\)" 'face 'error)
			    (propertize " \(narrowed\)" 'face 'shadow)))))


		    (defvar gh-mode-line-kmacro
		      '(:eval
			(when (and (mode-line-window-selected-p)
				   defining-kbd-macro)
			  " KMacro ")))

		    (dolist (construct
			     '(gh-mode-line-major-mode
			       gh-mode-line-padding
			       gh-mode-line-kmacro
			       gh-mode-line-narrowing
			       gh-mode-line-buffer-read-only
			       gh-mode-line-time-and-date
			       gh-my-mode-line-buffer-name))
		      (put construct 'risky-local-variable t))

;to add: **-,  line nums, % through document, Git, battery, get rid of padding when narrowed    534:		    ;buffer ;management


		    ;buffer management

		    (defun gh-make-window-current (window)
		      (select-window window))

		    (setq display-buffer-alist
			  '(
			    ("\\*Occur\\*"
			     (display-buffer-reuse-window
			      display-buffer-below-selected)
			     (window-height . fit-window-to-buffer)
			     (dedicated . t)
			    (body-function . gh-make-window-current))
			    ("\\*helpful.*"
			     (display-buffer-reuse-window
			      display-buffer-below-selected)
			     )))

      ;org
	    (setq org-use-speed-commands t)
		    (setq org-structure-template-alist
			  '(
			    ("a" . "export ascii")
		     ("e" . "src emacs-lisp")
		     ("t" . "src emacs-lisp :tangle \" \"")
		     ("l" . "src lua")
		     ("v" . "verse")))

		    (keymap-global-set "C-c C-," 'org-insert-structure-template)

(keymap-set occur-mode-map "M-<up>" ' previous-error-no-select)
	  (keymap-set occur-mode-map "M-<down>" ' next-error-no-select)

      (keymap-global-set "M-<left>" #'reb-prev-match)
      (keymap-global-set "M-<right>" #'reb-next-match)


    ;regex
    (setq reb-re-syntax 'string)
    (keymap-set xah-fly-leader-key-map "p" #'vr/query-replace)
    (keymap-set xah-fly-leader-key-map "p" #'vr/replace)

;magit
;; keys to pass through to magit: l,d,s,x


;; (defun mode-command-or-xfk-command (mode mode-command xfk-command)
;; 		    (interactive)
;; 		    (if (eq major-mode 'mode)
;; 			(mode-command)
;; 		      xfk-command))

;; (keymap-set xah-fly-command-map "g"
;; 	    (lambda () (interactive)
;; 	      (mode-command-or-xfk-command 'magit-status-mode 'magit-refresh            'dired-revert-buffer-or-xah-delete-current-text-block)))
