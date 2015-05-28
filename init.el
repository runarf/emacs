(ido-mode 1)
(setq ido-enable-flex-matching t)
(tool-bar-mode 0)
(setq-default TeX-master nil)
(load-theme 'leuven t)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;(getenv "PATH")
; (setenv "PATH"
;	 (concat
;	  "/usr/local/texlive/2014/bin/x86_64-linux" ":"
;	  (getenv "PATH")))

 (setq ring-bell-function 'ignore)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 
(setq reftex-plug-into-auctex t)

(let ((default-directory "~/.emacs.d/runars/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(global-set-key (kbd "C-c r a") 'rvm-activate-corresponding-ruby)

;;(global-company-mode t)
;;(push 'company-robe company-backends)

(defun turn-on-outline-minor-mode () (outline-minor-mode 1)) (add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode) (add-hook 'latex-mode-hook 'turn-on-outline-minor-mode) (setq outline-minor-mode-prefix "\C-c \C-o")

(add-hook 'ruby-mode-hook 'projectile-on)
(setq magit-last-seen-setup-instructions "1.4.0")

;; Display ido results vertically, rather than horizontally
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)

(defun copy-to-clipboard ()
  (interactive)
  (if (display-graphic-p)
      (progn
	(message "Yanked region to x-clipboard!")
	(call-interactively 'clipboard-kill-ring-save)
	)
    (if (region-active-p)
	(progn
	  (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
	  (message "Yanked region to clipboard!")
	  (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))
  )

(defun paste-from-clipboard ()
  (interactive)
  (if (display-graphic-p)
      (progn
	(clipboard-yank)
	(message "graphics active")
	)
    (insert (shell-command-to-string "xsel -o -b"))
    )
  )

(global-set-key [f8] 'copy-to-clipboard)
(global-set-key [f9] 'paste-from-clipboard)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9fb6da24a680973616017ccabc576a09915884696ba1b0b045d9c33970620731" "6a9606327ecca6e772fba6ef46137d129e6d1888dcfc65d0b9b27a7a00a4af20" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
