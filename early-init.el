(defun prot-emacs-re-enable-frame-theme (_frame)
  "Re-enable active theme, if any, upon FRAME creation.
Add this to `after-make-frame-functions' so that new frames do
not retain the generic background set by the function
`prot-emacs-avoid-initial-flash-of-light'."
  (when-let ((theme (car custom-enabled-themes)))
    (enable-theme theme)))

  (defun prot-emacs-avoid-initial-flash-of-light ()
       "Avoid flash of light when starting Emacs, if needed.
     ;; New frames are instructed to call `prot-emacs-re-enable-frame-theme'."
	 (setq mode-line-format nil)
	 (set-face-attribute 'default nil :background "#000000" :foreground "#ffffff")
	 (set-face-attribute 'mode-line nil :background "#000000" :foreground "#ffffff" :box 'unspecified)
	     (add-hook 'after-make-frame-functions #'prot-emacs-re-enable-frame-theme))

    (prot-emacs-avoid-initial-flash-of-light)
