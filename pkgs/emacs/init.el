(setq inhibit-startup-message t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(global-hl-line-mode t)

(global-display-line-numbers-mode t)
(setq frame-resize-pixelwise t) ;; fix emacs on tiling wm

(setq nerd-icons-font-family "FantasqueSansM Nerd Font")
(add-to-list 'default-frame-alist '(font . "FantasqueSansM Nerd Font-16"))

(require 'nerd-icons)

(unicode-fonts-setup)

(setq custom-tab-width 4)
(setq-default tab-width custom-tab-width)

(defun my/disable-tabs ()
  (interactive)
  (setq indent-tabs-mode nil)) ;; write spaces
(defun my/enable-tabs ()
  (interactive)
  (setq indent-tabs-mode t)) ;; write tabs

(add-hook 'prog-mode-hook 'my/disable-tabs)

(setq backward-delete-char-untabify-method 'hungry)

(setq-default electric-indent-inhibit nil)

(setq-default evil-shift-width custom-tab-width)

;; display tabs
(setq whitespace-style '(face tabs tab-mark trailing))
(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9])))
(add-hook 'before-save-hook 'whitespace-cleanup)
(global-whitespace-mode)

(dolist (char/ligature-re
          `((?-  . ,(rx (or (or "-->" "-<<" "->>" "-|" "-~" "-<" "->") (+ "-"))))
             (?/  . ,(rx (or (or "/==" "/=" "/>" "/**" "/*") (+ "/"))))
             (?*  . ,(rx (or (or "*>" "*/") (+ "*"))))
             (?<  . ,(rx (or (or "<<=" "<<-" "<|||" "<==>" "<!--" "<=>" "<||" "<|>" "<-<"
                               "<==" "<=<" "<-|" "<~>" "<=|" "<~~" "<$>" "<+>" "</>"
                               "<*>" "<->" "<=" "<|" "<:" "<>"  "<$" "<-" "<~" "<+"
                               "</" "<*")
                           (+ "<"))))
             (?:  . ,(rx (or (or ":?>" "::=" ":>" ":<" ":?" ":=") (+ ":"))))
             (?=  . ,(rx (or (or "=>>" "==>" "=/=" "=!=" "=>" "=:=") (+ "="))))
             (?!  . ,(rx (or (or "!==" "!=") (+ "!"))))
             (?>  . ,(rx (or (or ">>-" ">>=" ">=>" ">]" ">:" ">-" ">=") (+ ">"))))
             (?&  . ,(rx (+ "&")))
             (?|  . ,(rx (or (or "|->" "|||>" "||>" "|=>" "||-" "||=" "|-" "|>"
                               "|]" "|}" "|=")
                           (+ "|"))))
             (?.  . ,(rx (or (or ".?" ".=" ".-" "..<") (+ "."))))
             (?+  . ,(rx (or "+>" (+ "+"))))
             (?\[ . ,(rx (or "[<" "[|")))
             (?\{ . ,(rx "{|"))
             (?\? . ,(rx (or (or "?." "?=" "?:") (+ "?"))))
             (?#  . ,(rx (or (or "#_(" "#[" "#{" "#=" "#!" "#:" "#_" "#?" "#(")
                           (+ "#"))))
             (?\; . ,(rx (+ ";")))
             (?_  . ,(rx (or "_|_" "__")))
             (?~  . ,(rx (or "~~>" "~~" "~>" "~-" "~@")))
             (?$  . ,(rx "$>"))
             (?^  . ,(rx "^="))
             (?\] . ,(rx "]#"))))
  (let ((char (car char/ligature-re))
         (ligature-re (cdr char/ligature-re)))
    (set-char-table-range composition-function-table char
      `([,ligature-re 0 font-shape-gstring]))))

(require 'ef-themes)
(load-theme 'ef-winter t)

(require 'doom-modeline)
(setq doom-modeline-height 30)
(add-hook 'after-init-hook 'doom-modeline-mode)

(require 'vertico)
(setq vertico-count 10)
(vertico-mode)

(require 'orderless)
(setq completion-styles '(orderless basic))
(setq completion-category-overrides '((file (styles basic partial-completion))))

(setq dashboard-banner-logo-title "Welcome to Emacs")
(setq dashboard-startup-banner 'official)
(setq dashboard-display-icons-p t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-heading-icons t)
(setq dashboard-icon-type 'nerd-icons)
(setq dashboard-show-shortcuts t)
(setq dashboard-center-content t)
(setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))

(require 'dashboard)

(dashboard-setup-startup-hook)

(set-language-environment 'utf-8)

(setq custom-file "~/.emacs.d/custom.el")
;; (load custom-file)

(setq backup-directory-alist `((".*" . "~/emacs_backups")))

(setq ring-bell-function 'ignore)

(run-at-time (current-time) 300 'recentf-save-list)

;; (setq warning-minimum-level :emergency)

(add-hook 'prog-mode-hook 'electric-pair-mode)
(add-hook 'prog-mode-hook 'electric-indent-mode)

(global-auto-revert-mode)

;; (setq tab-always-indent 'complete)
;; (setq text-mode-ispell-word-completion nil)
(setq read-extended-command-predicate #'command-completion-default-include-p)

(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)

(setq evil-default-cursor t)
(setq evil-default-state 'normal)
(setq evil-split-window-below t)
(setq evil-vsplit-window-right t)
(setq evil-want-c-i-jump nil) ;; fixes indent in org mode
(setq evil-want-integration t)
(setq evil-want-keybinding nil)

(setq evil-collection-mode-list '(dashboard dired ibuffer magit calc))

(require 'evil)
;; (define-key evil-insert-state-map (kbd "DEL") #'backward-delete-char-untabify)
(evil-mode)

(require 'evil-collection)
(evil-collection-init)

(require 'evil-commentary)
(evil-commentary-mode)

(require 'evil-vimish-fold)
(evil-vimish-fold-mode)

(require 'evil-anzu)
(global-anzu-mode)

(setq dired-listing-switches "-DAhlv --group-directories-first")

(require 'dired)

;; prevent dired from creating new buffers
(put 'dired-find-alternate-file 'disabled nil)
(evil-define-key 'normal dired-mode-map (kbd "h")
  (lambda () (interactive) (find-alternate-file "..")))
(evil-define-key 'normal dired-mode-map (kbd "l") 'dired-find-alternate-file)

(require 'nerd-icons-dired)
(add-hook 'dired-mode-hook 'nerd-icons-dired-mode)

(require 'diredfl)
(diredfl-global-mode)

(require 'peep-dired)
(define-key dired-mode-map (kbd "M-p") 'peep-dired)
(evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
(evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)

(defun disable-all-themes ()
  "disable all active themes."
  (dolist (i custom-enabled-themes)
    (disable-theme i)))

(defadvice load-theme (before disable-themes-first activate)
  (disable-all-themes))

(defadvice load-theme (after style-org activate)
  (my/style-org))

(defadvice next-buffer (after avoid-anoying-buffers activate)
  (when (or (string-match-p "^\*" (buffer-name))
          (string-match-p "^magit" (buffer-name)))
    (next-buffer)))

(defadvice previous-buffer (after avoid-anoying-buffers activate)
  (when (or (string-match-p "^\*" (buffer-name))
          (string-match-p "^magit" (buffer-name)))
    (previous-buffer)))

(setq eldoc-echo-area-use-multiline-p nil)
(setq eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider))

(require 'eglot)

(setq corfu-cycle t)
(setq corfu-auto t)
(setq corfu-auto-prefix 2)
(setq corfu-auto-delay 0.25)
(setq corfu-quit-at-boundary 'separator)
(setq corfu-preview-current 'insert)
(setq corfu-preselect-first nil)
(setq corfu-popupinfo-mode t)

(require 'corfu)
(require 'nerd-icons-corfu)

(add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)

(define-key corfu-map (kbd "M-SPC") #'corfu-insert-separator)
(define-key corfu-map (kbd "RET") nil)
(define-key corfu-map (kbd "TAB") #'corfu-next)
(define-key corfu-map (kbd "<tab>") #'corfu-next)
(define-key corfu-map (kbd "S-TAB") #'corfu-previous)
(define-key corfu-map (kbd "<backtab>") #'corfu-previous)
(define-key corfu-map (kbd "S-<return>") #'corfu-insert)
(global-corfu-mode)

(require 'cape)
(global-set-key (kbd "C-c p") 'cape-prefix-map)
(add-hook 'completion-at-point-functions #'cape-dabbrev)
(add-hook 'completion-at-point-functions #'cape-file)
(add-hook 'completion-at-point-functions #'cape-elisp-block)

(setq treesit-font-lock-level 4)
;; (setq treesit-language-source-alist
;;   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
;;      (c "https://github.com/tree-sitter/tree-sitter-c")
;;      (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
;;      (css "https://github.com/tree-sitter/tree-sitter-css")
;;      (elisp "https://github.com/Wilfred/tree-sitter-elisp")
;;      (html "https://github.com/tree-sitter/tree-sitter-html")
;;      (lua "https://github.com/tree-sitter-grammars/tree-sitter-lua")
;;      (js . ("https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
;;      (json "https://github.com/tree-sitter/tree-sitter-json")
;;      (nix "https://github.com/nix-community/tree-sitter-nix")
;;      (python "https://github.com/tree-sitter/tree-sitter-python")
;;      (rust "https://github.com/tree-sitter/tree-sitter-rust")
;;      (toml "https://github.com/tree-sitter/tree-sitter-toml")
;;      (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
;;      (typst . ("https://github.com/uben0/tree-sitter-typst" "master" "src"))
;;      (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
;;      (yaml "https://github.com/ikatyang/tree-sitter-yaml")
;;      (cmake "https://github.com/uyha/tree-sitter-cmake")))

(require 'tempel)

(define-key global-map (kbd "M-*") #'tempel-insert)
(define-key tempel-map (kbd "TAB") #'tempel-next)
(define-key tempel-map (kbd "<backtab>") #'tempel-previous)

(add-to-list 'completion-at-point-functions #'tempel-complete)

(global-tempel-abbrev-mode)

(setq org-startup-folded t)
(setq org-hidden-keywords '(title))
(setq org-return-follows-link t)

(setq org-todo-keywords
  (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
           (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))

(setq-default org-enforce-todo-dependencies t)

(setq org-todo-keyword-faces
  (quote (("TODO" :foreground "indian red" :weight bold)
           ("NEXT" :foreground "light blue" :weight bold)
           ("DONE" :foreground "light green" :weight bold)
           ("WAITING" :foreground "chocolate" :weight bold)
           ("CANCELLED" :foreground "dim gray" :weight bold))))

(setq-default org-export-with-todo-keywords nil)

(setq org-hide-leading-stars nil)
(setq org-indent-mode-turns-on-hiding-stars nil)

(setq org-ellipsis " ▼ ")

(setq org-hide-emphasis-markers t)

(defun my/buffer-face-mode-variable ()
  "Set font to a variable width (proportional) fonts in current buffer"
  (interactive)
  (setq buffer-face-mode-face '(:family "FantasqueSansM Nerd Font"
                                 :height 160
                                 :width normal))
  (buffer-face-mode))

(defun my/set-faces-org ()
  (setq org-hidden-keywords '(title))
  (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)

  (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-4 nil :inherit 'org-level-8)

  (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.2) ;\large
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.44) ;\Large
  (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.728) ;\LARGE

  (setq org-cycle-level-faces nil)
  (setq org-n-level-faces 4)

  (set-face-attribute 'org-document-title nil
    :height 2.074
    :foreground 'unspecified
    :inherit 'org-level-8))

(defun my/set-keyword-faces-org ()
  (mapc (lambda (pair) (push pair prettify-symbols-alist))
    '(;; Syntax
       ("TODO" .     "")
       ("DONE" .     "")
       ("WAITING" .  "")
       ("HOLD" .     "")
       ("NEXT" .     "")
       ("CANCELLED" . "")
       ("#+begin_quote" . "“")
       ("#+end_quote" . "”")))
  )

(defun my/style-org ()
  (my/set-faces-org)
  (my/set-keyword-faces-org))


;; prevent org capture from saving bookmarks
(setq org-bookmark-names-plist nil)

(setq org-superstar-item-bullet-alist
  '((?* . ?•)
     (?+ . ?➤)
     (?- . ?•)))

(setq org-superstar-leading-bullet ?\s)
(setq org-superstar-headline-bullets-list
  '("◉" "◈" "○" "▷"))

(require 'org)
(require 'org-superstar)
(org-superstar-restart)

(add-hook 'org-mode-hook 'org-superstar-mode)

(add-hook 'org-mode-hook 'my/style-org)
(add-hook 'org-mode-hook 'org-indent-mode)

(org-babel-do-load-languages
  'org-babel-load-languages (quote ((emacs-lisp . t)
                                     (sqlite . t)
                                     (python . t))))

(require 'org-src)
(define-key org-src-mode-map (kbd "C-c C-c") #'org-edit-src-exit)

(require 'evil-org)
(require 'evil-org-agenda)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-agenda-set-keys)

(setq org-roam-directory (file-truename "~/Documents/org/roam"))
(setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

(require 'org-roam)
(require 'org-roam-protocol)
(org-roam-db-autosync-mode)

(setq org-roam-ui-sync-theme t)
(setq org-roam-ui-follow t)
(setq org-roam-ui-update-on-save t)
(setq org-roam-ui-open-on-start nil)
(require 'org-roam-ui)

(setq-default lisp-indent-offset 2)
;; (setq evil-shift-width 2)

(setq-default rust-ts-mode-indent-offset custom-tab-width)

(setq rust-mode-treesitter-derive t)
(setq rust-format-on-save t)
(setq rust-format-show-buffer nil)
(setq eglot-workspace-configuration
  '(:rust-analyzer
     ( :procMacro ( :attributes (:enable t)
                    :enable t)
       :cargo (:buildScripts (:enable t))
       :diagnostics (:disabled ["unresolved-proc-macro"
                                 "unresolved-macro-call"]))))

(require 'rust-mode)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(dolist (hook '(rust-mode-hook rust-ts-mode-hook))
  (add-hook hook #'eglot-ensure))

(setq-default nix-ts-mode-indent-offset 2)

(require 'nix-ts-mode)
(add-to-list 'eglot-server-programs '(nix-ts-mode . ("nixd")))
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-ts-mode))
(add-hook 'nix-ts-mode-hook #'eglot-ensure)

(setq-default python-indent-offset custom-tab-width)

(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))
(add-hook 'python-ts-mode-hook #'eglot-ensure)

(setq-default c-ts-mode-indent-offset custom-tab-width)
(setq-default c-basic-offset custom-tab-width)

(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-ts-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-ts-mode))
(add-hook 'c-ts-mode-hook #'eglot-ensure)

(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-ts-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-ts-mode))
(add-hook 'c++-ts-mode-hook #'eglot-ensure)

(require 'typst-ts-mode)
(add-to-list 'auto-mode-alist '("\\.typ\\'" . typst-ts-mode))
(add-hook 'typst-ts-mode-hook #'eglot-ensure)

(add-to-list 'eglot-server-programs '(typst-ts-mode . ("tinymist")))

(setq-default lua-ts-indent-offset custom-tab-width)

(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-ts-mode))

(setq-default js-indent-level custom-tab-width)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(require 'emmet-mode)
(dolist (hook '(web-mode-hook tsx-mode-hook))
  (add-hook hook #'emmet-mode))

(require 'beancount)
(add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))

(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-ts-mode))

(add-to-list 'auto-mode-alist '("Dockerfile" . dockerfile-ts-mode))

(add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-ts-mode))

(add-to-list 'auto-mode-alist '("CMakeLists.txt" . cmake-ts-mode))

(setq magit-status-buffer-switch-function 'switch-to-buffer)

(require 'magit)

(setq gptel-model 'llama3:8b)
(setq gptel-backend (gptel-make-ollama "ollama"
                      :host "localhost:11434"
                      :stream t
                      :models '(llama3:8b dolphin-mistral:7b)))

(require 'gptel)
(add-hook 'gptel-post-stream-hook 'gptel-auto-scroll)

(require 'embark)
(bind-key* "C-;" #'embark-act)
(bind-key* "C-h B" #'embark-bindings)
(setq prefix-help-command #'embark-prefix-help-command)

(require 'affe)

(require 'avy)
(bind-key* "C-j" #'avy-goto-char-timer)

(require 'which-key)
(which-key-mode)

(require 'general)
(general-evil-setup t)

(nvmap :states '(normal visual motion emacs) :keymaps 'override :prefix "SPC"
  "a" '(:which-key "apps")
  "a d" '(dashboard-open :which-key "dashboard")
  "a f" '(affe-find :which-key "affe find")
  "a F" '(affe-grep :which-key "affe grep")
  "a g" '(magit-status-here :which-key "magit")
  "a i" '(ibuffer :which-key "ibuffer")
  "a r" '(org-roam-ui-open :which-key "org roam ui")
  "a s" '(gptel-send :which-key "gptel send")
  "a S" '(gptel :which-key "gptel")

  "b" '(:which-key "buffer")
  "b d" '(kill-current-buffer :which-key "kill buffer")
  "b i" '(ibuffer :which-key "ibuffer")
  "b n" '(next-buffer :which-key "next buffer")
  "b p" '(previous-buffer :which-key "previous buffer")
  "b s" '(scratch-buffer :which-key "scratch buffer")

  "d" '(:which-key "dired")
  "d d" '(dired-jump :which-key "open dired")
  "d p" '(peep-dired :which-key "peep dired")

  "e" '(:which-key "eval")
  "e b" '(eval-buffer :which-key "eval buffer")
  "e e" '(eval-expression :which-key "eval expression")
  "e l" '(eval-last-sexp :which-key "eval last expression")
  "e r" '(eval-region :which-key "eval region")

  "f" '(:which-key "file")
  "f b" '(:which-key "bookmark")
  "f b d" '(bookmark-delete :which-key "delete bookmark")
  "f b j" '(bookmark-jump :which-key "jump to bookmark")
  "f b n" '(bookmark-set :which-key "new bookmark")
  "f f" '(find-file :which-key "find file")
  "f s" '(save-buffer :which-key "save file")

  "h" '(:which-key "help")
  "h f" '(describe-function :which-key "describe function")
  "h k" '(describe-key :which-key "describe key")
  "h m" '(describe-mode :which-key "describe mode")
  "h s" '(sort-lines :which-key "sort lines")
  "h t" '(load-theme :which-key "load theme")
  "h T" '(consult-theme :which-key "consult theme")
  "h v" '(describe-variable :which-key "describe variable")
  "h w" '(woman :which-key "woman")

  "o" '(:which-key "org")
  "o e" '(org-edit-special :which-key "org edit special")
  "o E" '(org-export-dispatch :which-key "org export dispatch")
  "o i" '(org-toggle-inline-images :which-key "toggle inline images")
  "o R" '(org-mode-restart :which-key "restart org")
  "o t" '(org-babel-tangle :which-key "tangle")

  "o r" '(:which-key "org roam")
  "o r f" '(org-roam-node-find :which-key "org roam node find")
  "o r i" '(org-roam-node-insert :which-key "org roam node insert")
  "o r s" '(org-roam-db-sync :which-key "org roam sync db")

  "q" '(:which-key "quit")
  "q f" '(delete-frame :which-key "quit emacsclient")
  "q q" '(save-buffers-kill-terminal :which-key "quit emacs")

  "t" '(:which-key "typst")
  "t w" '(typst-ts-watch-mode :which-key "toggle watch")
  "t o" '(typst-ts-preview :which-key "open")

  "w" '(:which-key "window")
  "w k" '(delete-window :which-key "close window")
  "w h" '(split-window-below :which-key "split window horizontally")
  "w v" '(split-window-right :which-key "split window vertically")
  "w w" '(other-window :which-key "switch window"))

(nvmap :states '(normal) :keymaps 'override
  "z a" '(org-cycle :which-key "org toggle fold"))

(dashboard-open)
