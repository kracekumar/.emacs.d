;; Steve yegge tips
;;; Replacement for using backspace
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
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
(load-theme 'sanityinc-tomorrow-eighties)

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
;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:complete-on-dot t)
;(add-hook 'python-mode-hook 'jedi:ac-setup)
(add-hook 'after-init-hook 'company-mode)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
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
(setq flx-ido-threshold 1000)
;;
(add-hook 'prog-mode-hook 'flycheck-mode)
(add-hook 'text-mode-hook 'flycheck-mode)


;; Enable projectile mode
(projectile-global-mode)

;; occur key binding
(global-set-key (kbd "C-c C-l") 'occur)
(global-set-key (kbd "C-c C-o") 'occur)

(defun insert-ipdb()
  (interactive)
  (insert "import ipdb;ipdb.set_trace()"))
(global-unset-key (kbd "C-x ;"))
(global-set-key (kbd "C-x ;") 'insert-ipdb)

;; Make this intelligent
(defun insert-encoding()
  (interactive)
  (insert "# -*- coding: utf-8 -*-"))
(global-unset-key (kbd "C-3"))
(global-set-key (kbd "C-3") 'insert-encoding)

;; Insert unittest class
(defun insert-python-unittest-skel()
  (interactive)
  (insert "class FooTest(unittest.TestCase):

    def test_foo(self):
        self.assertTrue(1)"))

(provide 'init)


(defcustom python-autoflake-path (executable-find "autoflake")
  "Autoflake executable path.

Allows working with a virtualenv without actually adding support
for it."
  :group 'python
  :type 'string)

(defun python-remove-unused-imports ()
  "Use Autoflake to remove unused function.

$ autoflake --remove-all-unused-imports -i unused_imports.py"
  (interactive)
  (when (eq major-mode 'python-mode)
    (shell-command (format "%s --remove-all-unused-imports --remove-unused-variables -i %s"
                           python-autoflake-path
                           (shell-quote-argument (buffer-file-name))))
    (revert-buffer t t t))
  nil)

;; (eval-after-load 'python
;;   '(if python-autoflake-path
;;        (add-hook 'after-save-hook 'python-remove-unused-imports)
;;      (message "Unable to find autoflake. Configure `python-autoflake-path`")))

;; custom go mode hook
(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq tab-width 4)
            (setq indent-tabs-mode nil)
            (setq whitespace-style '(face empty trailing lines-tail))))

;; Remove unused imports in go-mode
(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))


;; load missing-python-mode files
;; (load-file "/Users/kracekumar/code/missing-python-mode/auto-format.el")

;; Venv support in eshell
;; Put cur directory name when venv is deactivated
(require 'eshell)
(setq eshell-prompt-function
      (lambda ()
        (concat (if (s-blank? venv-current-name)
                    ""
                  (concat "(" venv-current-name ") "))
                (car (last (s-split "/" (eshell/pwd)))) " $ ")))

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "/Users/kracekumar/Envs")

; ansi color setuo
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'eshell-preoutput-filter-functions 'ansi-color-filter-apply)
(add-hook 'eshell-preoutput-filter-functions 'ansi-color-apply)
;; rope
(setq ropemacs-global-prefix "C-c r")
(setq ropemacs-local-prefix "C-c r")

;; ;; Add rope to path
(add-to-list 'load-path "/Users/kracekumar/code/pymacs")
(add-to-list 'load-path "/Library/Python/2.7/site-packages/rope/")
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

;; Rope autoimport
(setq ropemacs-enable-autoimport 't)
(setq ropemacs-autoimport-modules '("os" "shutil" "django" "requests" "recruiterbox.*"))

;; sphinx docs mode
(add-hook 'python-mode-hook (lambda ()
                              (require 'sphinx-doc)
                              (sphinx-doc-mode t)))
;; ;; Full screen
(toggle-frame-fullscreen)

;; Add django-model.el

(load-file "~/.emacs.d/personal/python-django.el")
(require 'python-django)

;; Django Pony Mode
(add-to-list 'load-path "~/code/pony-mode/src")
(require 'pony-mode)

;; Add emmet mode
(require 'emmet-mode)
