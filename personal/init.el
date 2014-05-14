;; Steve yegge tips
;;; Replacement for using backspace
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
;; Full screen
(toggle-frame-fullscreen)
;; Remove Toolbar
(tool-bar-mode -1)

;; Don't backup files Emacs.
(setq make-backup-files nil)

;; Set Pager
;; http://david.rothlis.net/emacs/customize_general.html
;; (setenv "PAGER" "/bin/cat")Save previously opened files
(desktop-save-mode 1)
;;; visual bell
(setq visible-bell t)

;; (add-hook 'html-mode-hook
;;           (lambda ()
;;             ;; Default indentation is usually 2 spaces, changing to 4.
;;             (set (make-local-variable 'sgml-basic-offset) 4))
;;           (set (make-local-variable 'tab-width) 4))

(prelude-ensure-module-deps '(column-marker multiple-cursors auto-complete smex))

(set-default-font "Monaco-14")

;; (disable-theme 'zenburn)
;; (load-theme 'monokai)

(setq pop-up-windows nil)
(setq use-dialog-box nil)

(require 'column-marker)
(column-marker-1 80)

(scroll-bar-mode -1)
(global-linum-mode t)

(display-time)
(setq require-final-newline t)

(add-hook 'html-mode-hook
          (lambda ()
            ;; Default indentation is usually 2 spaces, changing to 4.
            (set (make-local-variable 'sgml-basic-offset) 4))
          (set (make-local-variable 'tab-width) 4))

(add-hook 'html-mode-hook (lambda () (interactive) (column-marker-1 100)))
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))

;; M-n
(global-set-key "\M-n" 'next-line)
(global-set-key "\M-p" 'previous-line)
;; Attach emacs to existing window
(setq ns-pop-up-frames nil)

;; Autocomplete
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'jedi:ac-setup)
;(add-hook 'after-init-hook 'company-mode)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;(require 'auto-complete-config)
;(ac-config-detail)

;; org mode binding
(add-hook 'org-mode-hook 'turn-on-font-lock)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Spell check
;; (add-hook 'text-mode-hook 'flyspell-mode)
;; (add-hook 'prog-mode-hook 'flyspell-prog-mode)

(setq org-hierarchical-todo-statistics nil)

;Ipython
(require 'python)
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args "--pylab"
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
 "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
 "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
 "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

; New line
(setq require-final-newline t)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

; open sudo files
(require 'tramp)

;; Activate smex
(autoload 'smex "smex")
(global-set-key (kbd "M-x") 'smex)

;; ido
(require 'ido)
(ido-mode t)

;;
(add-hook 'prog-mode-hook 'flycheck-mode)
(add-hook 'text-mode-hook 'flycheck-mode)
