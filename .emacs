; locale coding
(setq locale-coding-system'utf-8)
(prefer-coding-system'utf-8)
(set-keyboard-coding-system'utf-8)
(set-terminal-coding-system'utf-8)
; locale coding
(setq locale-coding-system'utf-8)
(prefer-coding-system'utf-8)
(set-keyboard-coding-system'utf-8)
(set-terminal-coding-system'utf-8)
(set-selection-coding-system'utf-8)
(set-clipboard-coding-system 'ctext)
(set-buffer-file-coding-system 'utf-8)

(global-set-key(kbd "C-x l") 'windmove-left)
(global-set-key(kbd "C-x r") 'windmove-right)
(global-set-key(kbd "C-x p") 'windmove-up)
(global-set-key(kbd "C-x d") 'windmove-down)
(global-set-key(kbd "M-o") 'ace-window)

;; (setq package-check-signature nil) 

;; (setq configuration-layer--elpa-archives
;;       '(("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;; 	("org"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
;; 	("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))


;; (setq auto-mode-alist
;;       (append
;;        '(("\\.cpp\\'" . c++-mode))
;;        '(("\\.h\\'" . c++-mode))
;;        auto-mode-alist))

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
		       hungry-delete
		       swiper
		       counsel
		       smartparens
		       neotree
		       ace-window
		       elpy
                       irony
                       company-irony-c-headers
                       company-irony
                       lsp-mode
                       yasnippet
                       treemacs
                       lsp-treemacs
                       helm-lsp
                       projectile
                       hydra
                       avy
                       which-key
                       helm-xref
                       dap-mode
                       py-autopep8
                       company-jedi
                       flycheck
                       magit
                       yaml-mode
                       doom-modeline
                       use-package
                       clang-format
                       ghub
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

;; (package-initialize)
(load-theme 'monokai t)


(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))


(add-hook 'c++-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'clang-format-buffer nil 'local)))


(defun my-c++-mode-hook ()
  ;; 设置 namespace 不缩进
  (c-set-offset 'innamespace 0))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)


;;(setq flymake-log-level 3)
(require 'elpy)
(elpy-enable)
(setq elpy-rpc-python-command "/home/junjie.jiangjjj/anaconda3/envs/py38/bin/python3")
(setq elpy-rpc-backend "jedi")
;; (add-hook 'elpy-mode-hook 'flycheck-mode)

;; (require 'pyvenv)

;; (require 'py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;; (setq py-autopep8-options '("--max-line-length=150"))


(when (display-graphic-p)
  (require 'all-the-icons))

(use-package doom-modeline
  :ensure t
  :hook (emacs-startup . doom-modeline-mode)
  :config
  (display-time-mode 1)
  (display-battery-mode 1)
  )

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-center-content t)
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 9)
                        (bookmarks . 5)
                        ;(projects . 5)
                        (agenda . 5)
                        (registers . 5)))
  )

(use-package all-the-icons
  :ensure t
  )

(setq custom-safe-themes t)

(require 'hungry-delete)
(global-hungry-delete-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'c++-mode-hook  'show-paren-mode)
(add-hook 'emacs-lisp-mode-hook  'show-paren-mode)


;; (add-hook 'find-file-hook 'flymake-find-file-hook)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

;; (require 'rtags)
;; (require 'company-rtags)
;; (setq rtags-completions-enabled t)
;; (eval-after-load 'company
;;   '(add-to-list
;;     'company-backends 'company-rtags))
;; (setq rtags-autostart-diagnostics t)
;; (rtags-enable-standard-keybindings)



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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#bcbcbc" "#d70008" "#5faf00" "#875f00" "#268bd2" "#800080" "#008080" "#5f5f87"])
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(compilation-message-face 'default)
 '(custom-enabled-themes '(tango))
 '(custom-safe-themes
   '("78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "aff12479ae941ea8e790abb1359c9bb21ab10acd15486e07e64e0e10d7fdab38" "d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default))
 '(fci-rule-color "#3C3D37")
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   '(("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100)))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   '(protobuf-mode dockerfile-mode solarized-theme cmake-mode counsel swiper monokai-theme company yapfify yaml-mode ws-butler window-numbering which-key volatile-highlights vi-tilde-fringe uuidgen toc-org spacemacs-theme spaceline restart-emacs request rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-isort popwin pip-requirements persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum live-py-mode linum-relative link-hint info+ indent-guide ido-vertical-mode hy-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump define-word cython-mode column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile anaconda-mode aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip ((t (:foreground "blue"))))
 '(company-tooltip-scrollbar-track ((t (:background "green")))))
(set-selection-coding-system'utf-8)
