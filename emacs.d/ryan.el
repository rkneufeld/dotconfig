(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)

;; Colours and Formatting
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/twilight-theme")
(load-theme 'twilight t)

(setq-default tab-width 2)
(fset 'yes-or-no-p 'y-or-n-p)

(line-number-mode 1) ; have line numbers and
(column-number-mode 1) ; column numbers in the mode line
(global-linum-mode t)

;; scratch
(setq initial-scratch-message nil)
(when (locate-library "clojure-mode")
  (setq initial-major-mode 'clojure-mode))

;; Clojure
(setq auto-mode-alist (cons '("\\.dtm$" . clojure-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.edn$" . clojure-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cljs$" . clojure-mode) auto-mode-alist))

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode) ; Rainbows!

;; nREPL customizations
(setq nrepl-popup-stacktraces nil)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(add-hook 'nrepl-interaction-mode-hook 'paredit-mode)
