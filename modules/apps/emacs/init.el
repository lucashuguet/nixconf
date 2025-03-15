(setq inhibit-startup-message t)

(tool-bar-mode -1)
(menu-bar-mode -1)

(scroll-bar-mode -1)
(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'horizontal-scroll-bar-mode nil)

(global-hl-line-mode t)

(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))

(global-display-line-numbers-mode t)
(setq frame-resize-pixelwise t)

(setq nerd-icons-font-family "FantasqueSansM Nerd Font")
(require 'nerd-icons)

(add-to-list 'default-frame-alist '(font . "FantasqueSansM Nerd Font-16"))

(unicode-fonts-setup)

(setq custom-tab-width 4)

(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

(add-hook 'prog-mode-hook 'disable-tabs)

(setq-default python-indent-offset custom-tab-width)
(setq-default js-indent-level custom-tab-width)

(setq-default electric-indent-inhibit t)

(setq backward-delete-char-untabify-method 'hungry)

(setq-default evil-shift-width custom-tab-width)

(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 '(whitespace-tab ((t (:foreground "#636363")))))
(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
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

;; (require 'doom-themes)
;; (load-theme 'doom-material-dark t)
(load-theme 'doom-dark+ t)
;; (doom-themes-org-config)

(setq doom-modeline-height 30)
(require 'doom-modeline)
(add-hook 'after-init-hook 'doom-modeline-mode)

(setq vertico-count 15)
(require 'vertico)
(vertico-mode)

(setq completion-styles '(orderless basic))
(setq completion-category-overrides '((file (styles basic partial-completion))))
(require 'orderless)

(require 'which-key)
(which-key-mode)

(setq evil-want-keybinding nil)
(setq evil-want-integration t)
(setq evil-vsplit-window-right t)
(setq evil-split-window-below t)
(setq evil-default-cursor t)
(setq evil-want-c-i-jump nil) ;; fixes indent in org mode

(require 'evil)
(evil-mode t)

(setq evil-collection-mode-list '(dashboard dired ibuffer magit calc))

(require 'evil-collection)
(evil-collection-init)

(require 'evil-commentary)
(evil-commentary-mode)

(require 'evil-vimish-fold)
(dolist (hook '(prog-mode-hook conf-mode-hook text-mode-hook))
  (add-hook hook 'evil-vimish-fold-mode))

(require 'evil-anzu)
(global-anzu-mode)

(setq custom-file "~/.emacs.d/custom.el")
;; (load custom-file)

(setq backup-directory-alist `((".*" . "~/emacs_backups")))

(setq ring-bell-function 'ignore)

(require 'dired)

(put 'dired-find-alternate-file 'disabled nil)

(with-eval-after-load 'dired
  (setq dired-listing-switches "-Dhlv --group-directories-first"))

(require 'nerd-icons-dired)
(add-hook 'dired-mode-hook 'nerd-icons-dired-mode)

(require 'diredfl)
(diredfl-global-mode)

(require 'peep-dired)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "M-p") 'peep-dired)
  (evil-define-key 'normal dired-mode-map (kbd "h")
    (lambda () (interactive) (find-alternate-file "..")))
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-find-alternate-file)
  (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
  (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file))

(run-at-time (current-time) 300 'recentf-save-list)

(setq warning-minimum-level :emergency)

(set-language-environment 'utf-8)

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

(require 'org)
(require 'org-superstar)
(with-eval-after-load 'org-superstar
  (setq org-superstar-item-bullet-alist
        '((?* . ?•)
          (?+ . ?➤)
          (?- . ?•)))

  (setq org-superstar-leading-bullet ?\s)
  (setq org-superstar-headline-bullets-list
        '("◉" "◈" "○" "▷"))
  (org-superstar-restart))

(add-hook 'org-mode-hook 'org-superstar-mode)

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

(add-hook 'org-mode-hook 'my/style-org)
(add-hook 'org-mode-hook 'org-indent-mode)

;; prevent org capture from saving bookmarks
(setq org-bookmark-names-plist nil)

(org-babel-do-load-languages
 'org-babel-load-languages (quote ((emacs-lisp . t)
                                   (sqlite . t)
                                   (python . t))))

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

(require 'magit)
(setq magit-status-buffer-switch-function 'switch-to-buffer)

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

(electric-pair-mode t)
(electric-indent-mode t)

(global-auto-revert-mode)

(setq-default indent-tabs-mode nil)

(setq eldoc-echo-area-use-multiline-p nil)
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
(define-key corfu-map (kbd "M-SPC") #'corfu-insert-separator)
(define-key corfu-map (kbd "RET") nil)
(define-key corfu-map (kbd "TAB") #'corfu-next)
(define-key corfu-map (kbd "<tab>") #'corfu-next)
(define-key corfu-map (kbd "S-TAB") #'corfu-previous)
(define-key corfu-map (kbd "<backtab>") #'corfu-previous)
(define-key corfu-map (kbd "S-<return>") #'corfu-insert)
(global-corfu-mode)

(setq tab-always-indent 'complete)
(setq text-mode-ispell-word-completion nil)
(setq read-extended-command-predicate #'command-completion-default-include-p)

(require 'cape)
(global-set-key (kbd "C-c p") 'cape-prefix-map)
(add-hook 'completion-at-point-functions #'cape-dabbrev)
(add-hook 'completion-at-point-functions #'cape-file)
(add-hook 'completion-at-point-functions #'cape-elisp-block)

(require 'nerd-icons-corfu)
(add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)

(require 'yasnippet)
(require 'yasnippet-snippets)
(yas-global-mode 1)

(defun my/yas-try-expanding-auto-snippets ()
  (when (and (boundp 'yas-minor-mode) yas-minor-mode)
    (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
      (yas-expand))))

(add-hook 'post-self-insert-hook #'my/yas-try-expanding-auto-snippets)

(setq abbrev-file-name "~/.emacs.d/abbrev_defs")

(setq save-abbrevs 'silently)
;; (setq-default abbrev-mode t)

(setq treesit-font-lock-level 4)
(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (c "https://github.com/tree-sitter/tree-sitter-c")
        (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (js . ("https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (nix "https://github.com/nix-community/tree-sitter-nix")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (rust "https://github.com/tree-sitter/tree-sitter-rust")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
        (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

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

(require 'nix-ts-mode)
(add-to-list 'eglot-server-programs '(nix-ts-mode . ("nixd")))
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-ts-mode))
(add-hook 'nix-ts-mode-hook #'eglot-ensure)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))

(require 'emmet-mode)
(dolist (hook '(web-mode-hook tsx-mode-hook))
  (add-hook hook #'emmet-mode))

(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
(add-hook 'python-ts-mode-hook #'eglot-ensure)

(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-ts-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-ts-mode))

(add-to-list 'auto-mode-alist '("Dockerfile" . dockerfile-ts-mode))

(add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-ts-mode))

(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))

(add-hook 'c-ts-mode-hook #'eglot-ensure)
(add-hook 'c-ts-mode-hook #'indent-tabs-mode)

(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
(add-hook 'c++-ts-mode-hook #'eglot-ensure)

(require 'general)
(general-evil-setup t)

(nvmap :states '(normal visual motion emacs) :keymaps 'override :prefix "SPC"
  "a" '(:which-key "apps")
  "a d" '(dashboard-open :which-key "dashboard")
  "a f" '(affe-find :which-key "affe find")
  "a F" '(affe-grep :which-key "affe grep")
  "a g" '(magit-status-here :which-key "magit")
  "a i" '(ibuffer :which-key "ibuffer")
  "a t" '(treemacs :which-key "open treemacs")
  "a r" '(org-roam-ui-open :which-key "org roam ui")
  "a s" '(gptel-send :which-key "gptel send")
  "a S" '(gptel :which-key "gptel")

  "b" '(:which-key "buffer")
  "b d" '(kill-current-buffer :which-key "kill buffer")
  "b i" '(ibuffer :which-key "ibuffer")
  "b n" '(next-buffer :which-key "next buffer")
  "b p" '(previous-buffer :which-key "previous buffer")

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
  "f b b" '(bookmark-jump :which-key "jump to bookmark")
  "f b d" '(bookmark-delete :which-key "delete bookmark")
  "f b n" '(bookmark-set :which-key "new bookmark")
  "f f" '(find-file :which-key "find file")
  "f s" '(save-buffer :which-key "save file")
  "f S" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "source init.el")

  "h" '(:which-key "help")
  "h f" '(describe-function :which-key "describe function")
  "h k" '(describe-key :which-key "describe key")
  "h m" '(describe-mode :which-key "describe mode")
  "h M" '(man :which-key "gnu manual")
  "h t" '(load-theme :which-key "load theme")
  "h v" '(describe-variable :which-key "describe variable")

  "i" '(:which-key "insert")
  "i a" '(add-global-abbrev :which-key "write new abbrev")
  "i f" '(yas-visit-snippet-file :which-key "visit snippet")
  "i n" '(yas-new-snippet :which-key "new snippet")
  "i s" '(yas-insert-snippet :which-key "insert snippet")

  "l" '(:which-key "LaTeX")
  "l c" '((lambda () (interactive) (TeX-command "LaTeXMkCompile" 'TeX-master-file -1)) :which-key "LaTeX compile")
  "l C" '((lambda () (interactive) (TeX-command "LaTeXMkClean" 'TeX-master-file -1)) :which-key "LaTeX clean")
  "l e" '(cdlatex-environment :which-key "LaTeX environment")

  "o" '(:which-key "org")
  "o c" '(org-latex-preview-clear-cache :which-key "clear LaTeX fragments")
  "o e" '(org-export-dispatch :which-key "org export dispatch")
  "o E" '(org-edit-special :which-key "org edit special")
  "o i" '(org-link-preview :which-key "toggle inline images")
  "o p" '(org-latex-preview :which-key "preview LaTeX fragments")
  "o r" '(:which-key "org roam")
  "o R" '(org-mode-restart :which-key "restart org")
  "o r f" '(org-roam-node-find :which-key "org roam node find")
  "o r i" '(org-roam-node-insert :which-key "org roam node insert")
  "o r s" '(org-roam-db-sync :which-key "org roam sync db")

  "q" '(:which-key "quit")
  "q f" '(delete-frame :which-key "quit emacsclient")
  "q q" '(save-buffers-kill-terminal :which-key "quit emacs")

  "w" '(:which-key "window")
  "w c" '(delete-window :which-key "close window")
  "w s" '(split-window-below :which-key "split window horizontally")
  "w v" '(split-window-right :which-key "split window vertically")
  "w w" '(other-window :which-key "switch window"))

(nvmap :states '(normal) :keymaps 'override
  "z a" '(org-cycle :which-key "org toggle fold"))

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
(dashboard-open)
