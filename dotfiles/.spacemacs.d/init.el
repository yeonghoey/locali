;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(auto-completion
     better-defaults
     command-log
     csharp
     csv
     docker
     emacs-lisp
     fasd
     git
     go
     graphviz
     helm
     html
     imenu-list
     javascript
     (markdown :variables markdown-live-preview-engine 'vmd)
     nginx
     (org :variables
          org-enable-github-support t
          org-enable-reveal-js-support t)
     plantuml
     (python :variables python-test-runner 'pytest)
     (ranger :variables ranger-show-preview t)
     restclient
     rust
     scala
     (shell :variables shell-default-shell 'multi-term)
     shell-scripts
     (spell-checking :variables spell-checking-enable-by-default nil)
     syntax-checking
     terraform
     twitter
     version-control
     vimscript
     yaml
     )
   dotspacemacs-additional-packages '(bats-mode)
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '()
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '()
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(material
                         material-light
                         spacemacs-dark
                         spacemacs-light
                         )
   dotspacemacs-colorize-cursor-according-to-state nil
   dotspacemacs-default-font '("D2Coding for Powerline"
                               :size 14
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 75
   dotspacemacs-inactive-transparency 75
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers nil
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  (setq-default git-magit-status-fullscreen t)
  (setq-default exec-path-from-shell-check-startup-files nil) ;; for OSX
  )

(defun dotspacemacs/user-config ()
  ;; Emacs
  (setq-default fringe-indicator-alist             ;; Disable ungainly line wrapping related indicators
                (assq-delete-all 'continuation
                                 (assq-delete-all 'truncation
                                                  fringe-indicator-alist)))
  (setq-default
   ns-pop-up-frames nil                            ;; No Popup a new frame when open files
   vc-follow-symlinks t                            ;; Always follow symlinks
   magit-diff-refine-hunk 'all                     ;; Highlight hunks by characters
   )
  (fset 'evil-visual-update-x-selection 'ignore)   ;; Paste like vim in visual mode
  (remove-hook 'prog-mode-hook #'smartparens-mode) ;; Disable smartparens
  (spacemacs/toggle-smartparens-globally-off)      ;; https://github.com/syl20bnr/spacemacs/issues/1603#issuecomment-213553034

  (add-hook 'after-change-major-mode-hook 'spacemacs/toggle-truncate-lines-on) ;; No line-wrapping

  ;; Korean language setting
  (setq-default default-input-method "korean-hangul")
  (set-fontset-font t 'hangul (font-spec :name "D2Coding for Powerline"))

  ;; Indentations
  (setq-default
   sh-basic-offset 2
   sh-indentation 2
   web-mode-markup-indent-offset 2
   web-mode-code-indent-offset 2
   js-indent-level 2
   js2-basic-offset 2
   web-mode-css-indent-offset 2
   css-indent-offset 2)

  ;; Python
  ;; SEE: https://github.com/timothycrosley/isort#multi-line-output-modes
  (setq-default py-isort-options '("-m 4"))

  ;; Org
  (setq-default
   org-directory "~/org/"
   org-agenda-files `(,org-directory)
   org-refile-targets '((org-agenda-files :level . 1))
   org-startup-indented t
   org-startup-folded t
   org-download-method 'directory
   org-download-image-dir "./img"
   org-download-heading-lvl nil
   org-download-annotate-function (lambda (x) nil)
   org-download-screenshot-method "ln -sfF \"$(ls -t $HOME/screenshots/* | head -n 1)\" %s"
   org-export-with-author nil
   org-export-with-section-numbers nil
   org-export-with-timestamps nil
   org-export-with-toc nil
   org-html-postamble nil
   org-html-htmlize-output-type 'css
   org-html-htmlize-font-prefix "org-"
   )

  ;; Org TODO customizations
  (setq-default
   org-todo-keywords '((sequence "TODO" "NOTE" "|" "DONE" "ABORTED"))
   org-todo-keyword-faces '(("NOTE" . (:foreground "SteelBlue"))
                            ("ABORTED" . (:foreground "DarkKhaki")))
   )

  ;; Save org files automatically after arranging items
  (defun my-org-save-all-org-buffers (old-function &rest args)
    (org-save-all-org-buffers)
    )
  (advice-add 'org-refile :after 'my-org-save-all-org-buffers)
  (advice-add 'org-archive :after 'my-org-save-all-org-buffers)

  ;; my- Customizations
  (setq-default
   my-org-inbox (concat org-directory "inbox.org")
   my-org-work  (concat org-directory "what-studio.org")
   )

  (setq-default
   org-capture-templates `(("c" "Create a task"
                            entry (file+headline ,my-org-inbox "Inbox")
                            "* TODO %t %?"
                            :empty-lines 1)

                           ("w" "Create a task (work)"
                            entry (file+headline ,my-org-work "Inbox")
                            "* TODO %t %?"
                            :empty-lines 1))
   )

  (defun my-find-dot-files ()
    (interactive)
    (let ((default-directory "~/.dotfiles/"))
      (spacemacs/helm-find-files nil))
    )
  (defun my-find-org-files ()
    (interactive)
    (let ((default-directory org-directory))
      (spacemacs/helm-find-files nil))
    )
  (defun my-find-notes-files ()
    (interactive)
    (let ((default-directory "~/notes/"))
      (spacemacs/helm-find-files nil))
    )
  (defun my-find-org-inbox ()
    (interactive)
    (find-file my-org-inbox)
    )
  (defun my-find-org-work ()
    (interactive)
    (find-file my-org-work)
    )
  (defun my-ag-org-files ()
    (interactive)
    (spacemacs/helm-files-do-ag org-directory)
    )
  (defun my-toggle-org-archived ()
    (interactive)
    (if (string-match "^.*[.]org$" buffer-file-name)
        (find-file (concat buffer-file-name "_archive"))
      (find-file (replace-regexp-in-string "_archive$" "" buffer-file-name))
      )
    )
  (defun my-trans-en-ko (start end)
    (interactive "r")
    (let* ((text (buffer-substring-no-properties start end))
           (command (format "trans -brief -no-autocorrect -to en+ko \"%s\"" text))
           (output (shell-command-to-string command))
           )
      (kill-new output)
      (message output))
    )
  (spacemacs/set-leader-keys
    "oo" 'spacemacs/workspaces-transient-state/body
    "o0" 'spacemacs/workspaces-transient-state/eyebrowse-switch-to-window-config-0-and-exit
    "o1" 'spacemacs/workspaces-transient-state/eyebrowse-switch-to-window-config-1-and-exit
    "o2" 'spacemacs/workspaces-transient-state/eyebrowse-switch-to-window-config-2-and-exit
    "o3" 'spacemacs/workspaces-transient-state/eyebrowse-switch-to-window-config-3-and-exit
    "o4" 'spacemacs/workspaces-transient-state/eyebrowse-switch-to-window-config-4-and-exit
    "o5" 'spacemacs/workspaces-transient-state/eyebrowse-switch-to-window-config-5-and-exit
    "o6" 'spacemacs/workspaces-transient-state/eyebrowse-switch-to-window-config-6-and-exit
    "o7" 'spacemacs/workspaces-transient-state/eyebrowse-switch-to-window-config-7-and-exit
    "o8" 'spacemacs/workspaces-transient-state/eyebrowse-switch-to-window-config-8-and-exit
    "o9" 'spacemacs/workspaces-transient-state/eyebrowse-switch-to-window-config-9-and-exit

    "o." `my-find-dot-files
    "of" 'my-find-org-files
    "on" `my-find-notes-files

    "oi" 'my-find-org-inbox
    "ow" 'my-find-org-work
    "o/" 'my-ag-org-files
    "oa" 'my-toggle-org-archived
    "ot" 'my-trans-en-ko
    "oT" 'spacemacs/toggle-transparency

    "or" 'org-redisplay-inline-images
    )
  )
