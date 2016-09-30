

;;;;;;;;;;;;;;;;
;;; Packages ;;;
;;;;;;;;;;;;;;;;


(require 'cask "~/.cask/cask.el")
(cask-initialize)
;;(require 'pallet)
(require 'package)

(package-initialize)                ;; Initialize & Install Package

;;
;; Icicles
;; 
(require 'icicles)
(icy-mode 1)


;;
;; Use IDO mode
;;
(setq ido-enable-flex-matching t)       ;; fuzzy matching is called flex matching
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-use-filename-at-point 'guess) ;; try to guess file type i think?
(setq ido-create-new-buffer 'always)    ;; Don’t ask to create new buffers, just do.


;;
;; Magit
;;
(require 'magit)
(setq magit-wip-after-save-mode t)
(setq magit-wip-after-apply-mode t)
(setq magit-wip-before-change-mode t)
(add-to-list 'magit-no-confirm 'safe-with-wip)

;;
;; EShell
;;

(defun eshell-maybe-bol ()
      (interactive)
      (let ((p (point)))
        (eshell-bol)
        (if (= p (point))
            (beginning-of-line))))

(add-hook 'eshell-mode-hook
  '(lambda () (define-key eshell-mode-map "\C-a" 'eshell-maybe-bol)))



;;;;;;;;;;;;;
;;; Paths ;;;
;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;
;;; Key Remapping  ;;;
;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-\\") 'undo)
(define-key global-map (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-x g") 'magit-status)


;;;;;;;;;;;;;;;;;;;;;;
;;; Easy-Customize ;;;
;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(blink-cursor-mode nil)
 '(change-major-mode-with-file-name t)
 '(delete-active-region (quote kill))
 '(electric-pair-mode t)
 '(electric-pair-pairs (quote ((34 . 34) (123 . 125) (40 . 41))))
 '(electric-pair-text-pairs (quote ((34 . 34) (40 . 41) (123 . 125))))
 '(electric-quote-mode t)
 '(electric-quote-string t)
 '(fill-column 120)
 '(global-hl-line-mode t)
 '(global-mark-ring-max 64)
 '(goal-column nil)
 '(indent-tabs-mode nil)
 '(kill-do-not-save-duplicates t)
 '(package-selected-packages (quote (org)))
 '(require-final-newline t)
 '(save-interprogram-paste-before-kill t)
 '(standard-indent 2)
 '(tab-stop-list nil)
 '(tab-width 2)
 '(track-eol t)
 '(undo-limit 11000000)
 '(undo-strong-limit 12000000))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;;;;;;;;;;;;;;;;;;;
;;; Emacs style  ;;;
;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;
;;; Editing ;;;
;;;;;;;;;;;;;;;

(defun determine-scope (beg end &optional region)
  "Determine scope for next invocation of `kill-region' or
`kill-ring-save': When called interactively with no active
region, operate on a single line. Otherwise, operate on region."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-beginning-position 2)))))

(advice-add 'kill-region :before #'determine-scope)
(advice-add 'kill-ring-save :before #'determine-scope)

