;; start in server mode
(require 'server)
(unless (server-running-p)
  (server-start))

;; customize cursor
(setq visible-cursor nil)
(setq cursor-type (quote box))

;; no toolbar
(tool-bar-mode -1)

;; no scrollbar
(scroll-bar-mode -1)

;; enable tls support
(require 'tls)

;; add melpa
;; marmalade is still broken
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmelade" . "http://marmalade-repo.org/packages/") t)
  )

;; enable smarter line wripe
(visual-line-mode 1)

;; Emacs.APP does not recognize all the nevironment variables in $PATH
;; This workaround copies $PATH from bash_profile
(if (not (getenv "TERM_PROGRAM"))
       (setenv "PATH"
               (shell-command-to-string "source $HOME/.bash_profile && printf $PATH")))

;; configure clojure stuff
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)
(add-to-list 'same-window-buffer-names "<em>nrepl</em>")

;; configure lisp stuff
(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")

;; configure auto complete
(require 'auto-complete-config)
(setq ac-delay 0.0)
(setq ac-quick-help-delay 0.5)
(ac-config-default)

;; ac-nrepl (Auto-complete for the nREPL)
(require 'ac-nrepl)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-to-list 'ac-modes 'cider-mode)
(add-to-list 'ac-modes 'cider-repl-mode)

;; pop up contextual documentation anywhere using C-c C-d
(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc))

;; use paredit mode in clojure buffers
(add-hook 'clojure-mode-hook 'paredit-mode)
(show-paren-mode 1)

;; we don't want no blinky cursors
(setq blink-cursor-mode nil)

;; window number mode
(require 'window-numbering)

;;
;; org mode customization
;;
;; make sure we have line wrapping enabled in org buffers
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(setq org-default-notes-file (concat org-directory "/refile.org"))
(setq org-log-done t)


(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t)
  (setq ispell-extra-args '("-d en_US")))

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor-type (quote box))
 '(custom-safe-themes
   (quote
    ("fa942713c74b5ad27893e72ed8dccf791c9d39e5e7336e52d76e7125bfa51d4c"
     ("fa942713c74b5ad27893e72ed8dccf791c9d39e5e7336e52d76e7125bfa51d4c" default)
     default)))
 '(excorporate-configuration
   (quote
    ("doehlert@amazon.com" . "https://ex13d03uwc003.ant.amazon.com:444/ews/exchange.asmx")))
 '(exec-path
   (quote
    ("/usr/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_9" "/Applications/Emacs.app/Contents/MacOS/libexec-x86_64-10_9" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin")))
 '(safe-local-variable-values
   (quote
    ((visual-line-mode . 1)
     (line-spacing . 0.4)
     (right-margin-width . 12)
     (left-margin-width . 12)
     (word-wrap . 1)
     (word-wrap quote t)
     (visual-line-mode . t)
     (line-spacing . 0.5)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; switch to bubbleberry theme
(load-theme 'bubbleberry)
