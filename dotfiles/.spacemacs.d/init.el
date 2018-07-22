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
     (ess :variables ess-disable-underscore-assign t)
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
     (shell :variables shell-default-shell 'eshell)
     shell-scripts
     spell-checking
     sql
     syntax-checking
     systemd
     terraform
     twitter
     version-control
     vimscript
     yaml
     )
   dotspacemacs-additional-packages '(bats-mode
                                      editorconfig
                                      vue-mode
                                      )
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(smartparens  ;; SEE: https://github.com/syl20bnr/spacemacs/issues/1603#issuecomment-213553034
                                    )
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-gc-cons '(100000000 0.1)
   dotspacemacs-use-spacelpa nil
   dotspacemacs-verify-spacelpa-archives nil
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory 'emacs-version
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '()
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-initial-scratch-message nil
   dotspacemacs-themes '(material
                         material-light
                         spacemacs-dark
                         spacemacs-light
                         )
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)
   dotspacemacs-colorize-cursor-according-to-state nil
   dotspacemacs-default-font '("DejaVu Sans Mono for Powerline"
                               :size 12
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
   dotspacemacs-auto-generate-layout-names nil
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
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers nil
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-enable-server nil
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   dotspacemacs-frame-title-format "%I@%S"
   dotspacemacs-icon-title-format nil
   dotspacemacs-whitespace-cleanup nil
   dotspacemacs-zone-out-when-idle nil
   dotspacemacs-pretty-docs nil
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

  ;; Depend on eslint and transcompilers Instead
  (add-hook 'js2-mode-hook 'js2-mode-hide-warnings-and-errors)
  ;; Disable Method chaining indentations
  (advice-add 'js--multi-line-declaration-indentation :around (lambda (orig-fun &rest args) nil))

  ;; http://editorconfig.org/
  (editorconfig-mode 1)

  ;; Shell
  (setq-default
   flycheck-disabled-checkers
   '(
     sh-posix-bash
     sh-posix-dash
     )
   flycheck-shellcheck-excluded-warnings
   '(
     "SC1090" ;; No source: https://github.com/koalaman/shellcheck/wiki/SC1090
     "SC2039" ;; No POSIX : https://github.com/koalaman/shellcheck/wiki/SC2039
     "SC2046" ;; No quote : https://github.com/koalaman/shellcheck/wiki/SC2046
     )
   )

  ;; Python
  ;; SEE: https://github.com/timothycrosley/isort#multi-line-output-modes
  (setq-default py-isort-options '("-m 4"))

  ;; Org
  (setq-default
   org-startup-indented t
   org-startup-folded t
   org-edit-src-content-indentation 0 ;; Make src blocks consistent with other blocks
   )

  ; Org Babel Languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t)
     (emacs-lisp . t)
     (latex . t)
     (python . t)
     (shell . t)
     (R . t)
     )
   )

  (defun org-babel-execute:html (body params) body)

  (setq-default
   org-confirm-babel-evaluate nil
   )

  ;; Save org files automatically after arranging items
  (defun my-org-save-all-org-buffers (old-function &rest args)
    (org-save-all-org-buffers)
    )
  (advice-add 'org-refile :after 'my-org-save-all-org-buffers)
  (advice-add 'org-archive :after 'my-org-save-all-org-buffers)

  (defun yeonghoey-tr-line-chars (start end)
    (interactive "r")
    (let* ((table (make-translation-table '((?| . ?│) (?+ . ?└) (?- . ?─)))))
      (translate-region start end table))
    )
  (defun yeonghoey-trans-en-ko (start end)
    (interactive "r")
    (let* ((text (buffer-substring-no-properties start end))
           (command (format "trans -brief -no-autocorrect -to en+ko \"%s\"" text))
           (output (shell-command-to-string command))
           )
      (kill-new output)
      (message output))
    )

  (defun yeonghoey-open-target()
    (list (read-directory-name
           "yeonghoey-open: "
           ;; FIXME: Read ~/yeonghoey part as an environment variable
           (let ((yeonghoey-docs (substitute-in-file-name "${HOME}/yeonghoey/docs/"))
                 )
             (if (string-prefix-p yeonghoey-docs default-directory)
                 default-directory
               yeonghoey-docs)
             )
           )
          )
    )

  (defun yeonghoey-open (target root)
    (when (not (file-directory-p target))
      (make-directory target t)
      )
    (find-file (concat target root))
    )

  (defun yeonghoey-flyspell-mode-off ()
    (interactive)
    (flyspell-mode-off)
    )

  (defun yeonghoey-flycheck-reset ()
    (interactive)
    (setq flycheck-disabled-checkers nil)
    (flycheck-buffer)
    )

  (defun yhy-org-img-paste ()
    (interactive)
    (let* ((cmd  (format "yhy img paste %s 2> /dev/null"
                         (or yhy-org-img-paste-flags "")))
           (path (shell-command-to-string cmd)))
      (if (string= path "")
          (message "Clipboard does not contain image data")
        (unless (eolp) (forward-char))
        (when yhy-org-img-paste-attrs
          (insert (format "#+ATTR_HTML: %s\n" yhy-org-img-paste-attrs))
          (org-indent-line)
          )
        (insert (format "[[file:%s]]" (string-trim path)))
        (org-display-inline-images)
        )
      )
    )

  (defun yhy-org-insert-div (begin end)
    (interactive "r")
    (let ((text-begin "#+HTML: <div class=\"\">")
          (text-end   "#+HTML: </div>"))
      (if (org-region-active-p)
          (progn
            (goto-char end)
	          (skip-chars-backward " \r\t\n")
            (insert "\n" text-end)

            (goto-char begin)
	          (beginning-of-line)
	          (skip-chars-forward " \r\t\n")

	          (beginning-of-line)
            (insert text-begin "\n")
	          (deactivate-mark t)
	          (forward-line -1)
            (search-forward "\"")
            )
        (progn
	        (beginning-of-line)
          (insert text-begin "\n" text-end "\n")
	        (forward-line -2)
          (search-forward "\"")
          )
        )
      )
    )

  (defcustom yhy-org-img-paste-attrs nil
    "Attributes to be customized as #+ATTR_HTML: %s"
    :safe (lambda (v) (member v '(":width 320px" ":width 640px"))))
  (defcustom yhy-org-img-paste-flags "-C '_img'"
    "Flags to be passed when executing `yhy img paste'")

  (spacemacs/set-leader-keys
    "ot" (defun yeonghoey-org-table (begin end)
           (interactive "r")
           (org-table-convert-region begin end)
           )
    "oT" 'yeonghoey-trans-en-ko
    "ol" 'yeonghoey-tr-line-chars
    "oS" 'yeonghoey-flyspell-mode-off
    "oe" 'yeonghoey-flycheck-reset

    ;; Open 'yeonghoey/docs'
    "of" (defun yeonghoey-open-index (target)
           (interactive (yeonghoey-open-target))
           (yeonghoey-open target "index.org")
           )
    ;; Refresh inline displays
    "or" (defun yhy-org-display-toggle ()
           (interactive)
           (org-toggle-inline-images)
           (org-toggle-link-display)
           )
    "oR" (defun yhy-org-display-show ()
           (interactive)
           (org-display-inline-images)
           (setq org-descriptive-links t)
           )
    "odd" 'yhy-org-insert-div
    "odr" (defun yhy-org-drawer-references ()
            (interactive)
            (org-insert-drawer nil "REFERENCES")
            )
    "ods" (defun yhy-org-drawer-subindex ()
            (interactive)
            (org-insert-drawer nil "SUBINDEX")
            )
    "odt" (defun yhy-org-drawer-tagindex ()
            (interactive)
            (org-insert-drawer nil "TAGINDEX")
            )
    "op" 'yhy-org-img-paste
    )
  )
