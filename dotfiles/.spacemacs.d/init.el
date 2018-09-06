;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(auto-completion
     better-defaults
     command-log
     csharp
     csv
     docker
     emacs-lisp
     ess
     fasd
     git
     (go :variables
         go-format-before-save t
         gofmt-command "goimports")
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

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(bats-mode
                                      editorconfig
                                      ob-go
                                      vue-mode
                                      )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   ;; SEE: https://github.com/syl20bnr/spacemacs/issues/1603#issuecomment-213553034
   dotspacemacs-excluded-packages '(smartparens)

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '()

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(material
                         material-light
                         spacemacs-dark
                         spacemacs-light
                         )

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `vim-powerline' and `vanilla'. The first three
   ;; are spaceline themes. `vanilla' is default Emacs mode-line. `custom' is a
   ;; user defined themes, refer to the DOCUMENTATION.org for more info on how
   ;; to create your own spaceline theme. Value can be a symbol or list with\
   ;; additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state nil

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("DejaVu Sans Mono for Powerline"
                               :size 12
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols nil

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  ;; NOTE: Disable `.spacemacs.env`
  ;; (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (setq-default git-magit-status-fullscreen t)
  (setq-default exec-path-from-shell-check-startup-files nil) ;; for OSX
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
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
     (go . t)
     (js . t)
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
        ;; (org-display-inline-images)
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
    "ot" 'yeonghoey-trans-en-ko
    "oT" (defun yeonghoey-org-table (begin end)
           (interactive "r")
           (org-table-convert-region begin end)
           )
    "ol" 'avy-copy-line
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

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
