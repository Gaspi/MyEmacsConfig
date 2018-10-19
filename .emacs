
;; Environnement
(set-language-environment "UTF-8")

(setq custom-file "~/.emacs-custom.el")
(load custom-file)

;; Affichage
(column-number-mode t)

(setq truncate-partial-width-windows nil)
(setq ring-bell-function 'ignore)

(display-time-mode t)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))

(load (concat opam-share "/emacs/site-lisp/tuareg-site-file"))

;; Open .v files with Proof General's Coq mode
(load "~/.emacs.d/lisp/PG/generic/proof-site")



(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)
    (setq merlin-ac-setup 'easy)
  )
)

;; OCP indent
(require 'ocp-indent)

;; Custom font-lock colors
;(custom-set-faces
; '(font-lock-function-name-face ((t (:foreground "blue"))))
; '(font-lock-preprocessor-face  ((t (:foreground "brightblue"))))
; '(font-lock-constant-face      ((t (:foreground "color-165"))))
; '(font-lock-variable-name-face ((t (:foreground "black"))))
; '(font-lock-keyword-face       ((t (:foreground "green" :weight bold))))
; '(font-lock-comment-face       ((t (:foreground "brightmagenta"))))
; '(font-lock-string-face        ((t (:foreground "red"))))
;)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(global-set-key (kbd "C-c n") 'proof-assert-until-point-interactive)

(load "/home/gferey/.opam/4.04.0/share/emacs/site-lisp/tuareg-site-file")

(split-window-right)
(other-window 1)
(shell)
(other-window 1)
(setq-default tab-width 4)

(require 'git)

;; Load company-coq when opening Coq files
(add-hook 'coq-mode-hook #'company-coq-mode)
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
