; locale coding
(setq locale-coding-system'utf-8)
(prefer-coding-system'utf-8)
(set-keyboard-coding-system'utf-8)
(set-terminal-coding-system'utf-8)
(set-selection-coding-system'utf-8)
(set-clipboard-coding-system 'ctext)
(set-buffer-file-coding-system 'utf-8)

(global-set-key  (kbd "C-x l") 'windmove-left)
(global-set-key  (kbd "C-x r") 'windmove-right)
(global-set-key  (kbd "C-x p") 'windmove-up)
(global-set-key  (kbd "C-x d") 'windmove-down)
(global-set-key (kbd "M-o") 'ace-window)


;; (setq configuration-layer--elpa-archives
;;       '(("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;; 	("org"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
;; 	("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))


(setq auto-mode-alist
      (append
       '(("\\.cpp\\'" . c++-mode))
       '(("\\.h\\'" . c++-mode))
       auto-mode-alist))

(setq make-backup-files nil)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")t)
  ;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")t)
  (package-initialize)
  (package-refresh-contents)
  )

(require 'cl)

(defvar jjj/packages '(
		       company
		       monokai-theme
               company-racer
		       hungry-delete
		       swiper
		       counsel
		       smartparens
		       neotree
		       ace-window
		       elpy
		       google-c-style
		       flymake-google-cpplint
               flycheck
               flycheck-rust
               ;; rtags
               ;; company-rtags
               ;; clang-format
               ;; cmake-ide
               ;; irony
               ;; company-irony
               ;; company-irony-c-headers
               ;; flycheck
               ;; flycheck-irony
               ;; flycheck-rtags
               ;; flycheck-irony
		       ) "Default packages")

(defun jjj/package-installed-p ()
  (loop for pkg in jjj/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (jjj/package-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg jjj/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(package-initialize)
(elpy-enable)
(setq flymake-log-level 3)

(require 'hungry-delete)
(global-hungry-delete-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'c++-mode-hook  'show-paren-mode)
(add-hook 'emacs-lisp-mode-hook  'show-paren-mode)


(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(require 'rust-mode)
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))
(setq rust-format-on-save t)
(define-key rust-mode-map (kbd "C-c C-c") 'rust-run)

(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)


(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(require 'smartparens-config)
(add-hook 'c-mode-hook 'smartparens-mode)
(add-hook 'c++-mode-hook 'smartparens-mode)
(add-hook 'json-mode-hook 'smartparens-mode)

(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "cpplint")
   '(flymake-google-cpplint-verbose "3")
   '(flymake-google-cpplint-linelength "120")
   (flymake-google-cpplint-load)
   ))
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)


(setq auto-save-default nil)
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)
(setq c-default-style "linux")
(setq default-tab-width 4)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#bcbcbc" "#d70008" "#5faf00" "#875f00" "#268bd2" "#800080" "#008080" "#5f5f87"])
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(package-selected-packages
   (quote
    (racer rust-mode go-mode go cmake-mode counsel swiper monokai-theme company yapfify yaml-mode ws-butler window-numbering which-key volatile-highlights vi-tilde-fringe uuidgen toc-org spacemacs-theme spaceline restart-emacs re\
           quest rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-isort popwin pip-requirements persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum li\
           ve-py-mode linum-relative link-hint info+ indent-guide ido-vertical-mode hy-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-\
           swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-fr\
           om-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plu\
           s evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump define-word cython-mode column-enforce-mode clean-aindent-mode auto-highlight-symbol aut\
           o-compile anaconda-mode aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "green"))))
 '(company-tooltip ((t (:foreground "blue")))))
