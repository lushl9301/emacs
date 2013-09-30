;; path setting
(add-to-list 'load-path "~/.emacs.d/")

;;############################################################
;;## EDITING & FORMATING FUNCTIONALITY

;;key binding
(global-set-key (kbd "C-\;") 'async-shell-command)

;;autopair
(require 'autopair)
(autopair-global-mode)
(put 'upcase-region 'disabled nil)

;;add < autopair in c mode
(add-hook 'c-mode-hook
          #'(lambda ()
              (push '(?< . ?>)
                    (getf autopair-extra-pairs :code))))

;; paren-pair
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; open last file
(desktop-save-mode 0)

;;display current file path
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/Users/Derek/.emacs.d/ac-dict")
(ac-config-default)

;;google c style
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(add-hook 'c-mode-common-hook 'google-set-c-style)

;;smart compile
(require 'smart-compile)
(global-set-key (kbd "C-'") 'smart-compile)

;; indentation
;; (global-set-key "\C-m" 'newline-and-indent)
;; (global-set-key (kbd "C-<return>") 'newline)

;; show line number
(setq column-number-mode t)
(setq line-number-mode t)

;; use y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; display time
(display-time-mode 1)  
(setq display-time-24hr-format t)  
(setq display-time-day-and-date t)  
(transient-mark-mode t) 

;; indentation setting
(setq c-basic-offset 4)
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq tab-stop-list ())
;;(loop for x downfrom 40 to 1 do (setq tab-stop-list (cons (* x 4) tab-stop-list)))

;; 80-column 
(setq fill-column 80) 

;;highlight current line
(require 'hl-line)
(global-hl-line-mode t)
;; (set-face-background hl-line-face "gray13")

;;show line number in the left of buffer
(global-linum-mode t)

;;disable tool bar and scroll bar
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))

;;############################################################
;;## THEME

;;theme setting

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'hickey t)

;; (require 'color-theme)
;; (color-theme-initialize)
;; (load-file "~/.emacs.d/myTheme.el")
;; (myTheme)

;; font
(set-face-attribute 'default nil :font "Consolas-16")

;;c highlight
;; (require 'highlight)
;; (require 'region-list-edit)
;; (require 'bigD-hl)
;; (bigD-hl-enable-global-all-modes);(bigD-hl-disable-global-all-modes)


;;############################################################
;;## ADD-ON

;; ;;Load CEDET.
;; ;; See cedet/common/cedet.info for configuration details.
;; ;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; ;; CEDET component (including EIEIO) gets activated by another 
;; ;; package (Gnus, auth-source, ...).
;; (load-file "~/.emacs.d/cedet-1.1/common/cedet.el")

;; ;; Enable EDE (Project Management) features
;; (global-ede-mode 1)

;; ;; Enable EDE for a pre-existing C++ project
;; ;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; ;; Enabling Semantic (code-parsing, smart completion) features
;; ;; Select one of the following:

;; ;; * This enables the database and idle reparse engines
;; (semantic-load-enable-minimum-features)

;; ;; * This enables some tools useful for coding, such as summary mode,
;; ;;   imenu support, and the semantic navigator
;; (semantic-load-enable-code-helpers)

;; ;; * This enables even more coding tools such as intellisense mode,
;; ;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;;  (semantic-load-enable-gaudy-code-helpers)

;; ;; * This enables the use of Exuberant ctags if you have it installed.
;; ;;   If you use C++ templates or boost, you should NOT enable it.
;; ;; (semantic-load-enable-all-exuberent-ctags-support)
;; ;;   Or, use one of these two types of support.
;; ;;   Add support for new languages only via ctags.
;; ;; (semantic-load-enable-primary-exuberent-ctags-support)
;; ;;   Add support for using ctags as a backup parser.
;; ;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; ;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)


;;graphviz
;; (load-file "~/.emacs.d/graphviz-dot-mode.el")

;; palette
;; (require 'hexrgb)
;; (require 'palette)


;;############################################################
;;##  ENVIRONMENT SUPPORT

;; MIX
(setq load-path (cons "/opt/local/var/macports/software/mdk" load-path))
(autoload 'mixal-mode "mixal-mode" t)
(add-to-list 'auto-mode-alist '("\\.mixal\\'" . mixal-mode))
(autoload 'mixvm "mixvm" "mixvm/gud interaction" t)

;; Common Lisp
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/opt/local/bin/sbcl")


;; Django
(load-file "/Users/Derek/.emacs.d/python-django.el")
(require 'python-django)
(global-set-key (kbd "C-x j") 'python-django-open-project)

;; Mumamo
(autoload 'django-html-mumamo-mode "~/.emacs.d/nxhtml/autostart.el")
(setq auto-mode-alist
      (append '(("\\.html?$" . django-html-mumamo-mode)) auto-mode-alist))
(setq mumamo-background-colors nil) 
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

(when (and (>= emacs-major-version 24)
           (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
    '(setq mumamo-per-buffer-local-vars
           (delq 'buffer-file-name mumamo-per-buffer-local-vars)))
    (eval-after-load "bytecomp"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function))
;;  tramp-compat.el clobbers this variable!
  (eval-after-load "tramp-compat"
    '(add-to-list 'byte-compile-not-obsolete-vars
                  'font-lock-beginning-of-syntax-function)))


;; CSS and Rainbow modes 
(defun all-css-modes() (css-mode) (rainbow-mode)) 

;; Load both major and minor modes in one call based on file type 
(add-to-list 'auto-mode-alist '("\\.css$" . all-css-modes)) 
