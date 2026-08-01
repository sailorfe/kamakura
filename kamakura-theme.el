;;; kamakura-theme.el --- Nanbokuchou theme -*- lexical-binding: t; -*-

;; Author: sailorfe
;; URL: https://codeberg.org/sailorfe/kamakura
;; Package-Requires: ((emacs "30.1"))
;; Version: 0.1.0

;;; Commentary:
;; Emacs-first theme inspired by /The Elusive Samurai/.

;;; Code:

(require 'color)

(defvar kamakura/theme-dir
  (file-name-directory (or load-file-name buffer-file-name default-directory))
  "Directory this file lives in.")

(defun kamakura/hsl (h s l)
  "Convert H, S and L to a hex color string."
  (apply #'color-rgb-to-hex
         (append (color-hsl-to-rgb (/ h 360.0) s l) '(2))))

(defun kamakura/bright (h s l &optional delta-l delta-s)
  "Raise L by DELTA-L and adjust S by DELTA-S for a bright variant, H unchanged.
Defaults to +0.1 lightness and no saturation change."
  (kamakura/hsl
   h
   (min 1.0 (max 0.0 (+ s (or delta-s 0.0))))
   (min 1.0 (max 0.0 (+ l (or delta-l 0.1))))))

(defun kamakura/nearest-256 (hex)
  "Return the nearest xterm-256 color index for HEX."
  (let* ((r (string-to-number (substring hex 1 3) 16))
         (g (string-to-number (substring hex 3 5) 16))
         (b (string-to-number (substring hex 5 7) 16))
         (steps [0 95 135 175 215 255])
         (nearest-step
          (lambda (v)
            (let ((best 0) (bestd 1000))
              (dotimes (i 6)
                (let ((d (abs (- v (aref steps i)))))
                  (when (< d bestd) (setq bestd d best i))))
              best)))
         (ri (funcall nearest-step r))
         (gi (funcall nearest-step g))
         (bi (funcall nearest-step b))
         (cube-idx (+ 16 (* 36 ri) (* 6 gi) bi))
         (cube-dist (+ (expt (- r (aref steps ri)) 2)
                       (expt (- g (aref steps gi)) 2)
                       (expt (- b (aref steps bi)) 2)))
         (gray-idx (max 0 (min 23 (round (/ (- (/ (+ r g b) 3.0) 8) 10.0)))))
         (gray-val (+ 8 (* gray-idx 10)))
         (gray-dist (+ (expt (- r gray-val) 2)
                       (expt (- g gray-val) 2)
                       (expt (- b gray-val) 2))))
    (number-to-string (if (<= cube-dist gray-dist) cube-idx (+ 232 gray-idx)))))

(defvar kamakura/palette
  (let* (
         ;; backgrounds
         (base    (kamakura/hsl 45 0.71 0.93))
         (surface (kamakura/hsl 46 0.76 0.90))
         (overlay (kamakura/hsl 40 0.82 0.87))

         ;; foregrounds
         (muted   (kamakura/hsl 35 0.16 0.48))
         (faint   (kamakura/hsl 35 0.12 0.60))
         (text    (kamakura/hsl 30 0.22 0.30))
         (light   (kamakura/hsl 30 0.28 0.20))

         ;; contrast
         (low  (kamakura/hsl 44 0.30 0.90))
         (med  (kamakura/hsl 39 0.25 0.82))
         (high (kamakura/hsl 44 0.45 0.72))

         ;; accents
         (accent01 (kamakura/hsl 352 0.76 0.38)) ; miko skirt
         (accent02 (kamakura/hsl 114 0.50 0.36)) ; yorishige
         (accent03 (kamakura/hsl 44 0.75 0.46)) ; mima
         (accent04 (kamakura/hsl 263 0.33 0.61)); tokiyuki
         (accent05 (kamakura/hsl 355 0.63 0.65)) ; ayako
         (accent06 (kamakura/hsl 186 0.53 0.35)) ; shizuku

         (bright01 (kamakura/bright 352 0.76 0.38 0.15 -0.2))
         (bright02 (kamakura/bright 114 0.50 0.36 0.15 -0.15))
         (bright03 (kamakura/bright 44 0.75 0.46 0.1))
         (bright04 (kamakura/bright 263 0.33 0.61 0.1))
         (bright05 (kamakura/bright 355 0.63 0.65 0.1))
         (bright06 (kamakura/bright 186 0.53 0.35 0.15 -0.2))

         (raw
          `((base . ,base)
            (surface . ,surface)
            (overlay . ,overlay)
            (muted . ,muted)
            (faint . ,faint)
            (text . ,text)
            (light . ,light)
            (accent01 . ,accent01)
            (bright01 . ,bright01)
            (accent02 . ,accent02)
            (bright02 . ,bright02)
            (accent03 . ,accent03)
            (bright03 . ,bright03)
            (accent04 . ,accent04)
            (bright04 . ,bright04)
            (accent05 . ,accent05)
            (bright05 . ,bright05)
            (accent06 . ,accent06)
            (bright06 . ,bright06)
            (low . ,low)
            (med . ,med)
            (high . ,high)
            )))
    (append raw
            (mapcar (lambda (p)
                      (cons (intern (format "%s-cterm" (car p)))
                            (kamakura/nearest-256 (cdr p))))
                    raw))))

(deftheme kamakura "Nanbokuchou theme.")

(let* ((base (alist-get 'base kamakura/palette))
       (surface (alist-get 'surface kamakura/palette))
       (overlay (alist-get 'overlay kamakura/palette))
       (text (alist-get 'text kamakura/palette))
       (light (alist-get 'light kamakura/palette))
       (faint (alist-get 'faint kamakura/palette))
       (muted (alist-get 'muted kamakura/palette))
       (low (alist-get 'low kamakura/palette))
       (med (alist-get 'med kamakura/palette))
       (high (alist-get 'high kamakura/palette))
       (accent01 (alist-get 'accent01 kamakura/palette))
       (bright01 (alist-get 'bright01 kamakura/palette))
       (accent02 (alist-get 'accent02 kamakura/palette))
       (bright02 (alist-get 'bright02 kamakura/palette))
       (accent03 (alist-get 'accent03 kamakura/palette))
       (bright03 (alist-get 'bright03 kamakura/palette))
       (accent04 (alist-get 'accent04 kamakura/palette))
       (bright04 (alist-get 'bright04 kamakura/palette))
       (accent05 (alist-get 'accent05 kamakura/palette))
       (bright05 (alist-get 'bright05 kamakura/palette))
       (accent06 (alist-get 'accent06 kamakura/palette))
       (bright06 (alist-get 'bright06 kamakura/palette)))

  (custom-theme-set-faces
   'kamakura
   ;; --- core ui -------------------------------------------------
   `(default ((t (:background ,base :foreground ,text))))
   `(cursor ((t (:background ,text))))
   `(region ((t (:background ,accent05 :foreground ,base))))
   `(secondary-selection ((t (:background ,med :foreground ,accent03))))
   `(highlight ((t (:background ,overlay :foreground ,accent05))))
   `(hl-line ((t (:background ,overlay))))
   `(fringe ((t (:background ,base :foreground ,muted))))
   `(vertical-border ((t (:foreground ,surface))))
   `(window-divider ((t (:foreground ,surface))))
   `(window-divider-first-pixel ((t (:foreground ,surface))))
   `(window-divider-last-pixel ((t (:foreground ,surface))))
   `(minibuffer-prompt ((t (:foreground ,accent04 :weight bold))))
   `(shadow ((t (:foreground ,muted))))
   `(link ((t (:foreground ,accent04 :underline t))))
   `(link-visited ((t (:foreground ,accent02 :underline t))))
   `(escape-glyph ((t (:foreground ,accent06))))
   `(homoglyph ((t (:foreground ,accent06))))
   `(tooltip ((t (:background ,surface :foreground ,text))))
   `(trailing-whitespace ((t (:background ,overlay))))
   `(nobreak-space ((t (:foreground ,muted :underline t))))
   `(fill-column-indicator ((t (:foreground ,high))))
   `(bookmark-face ((t (:foreground ,accent04))))

   ;; --- errors / warnings / success ------------------------------
   `(error ((t (:foreground ,accent01 :weight bold))))
   `(warning ((t (:foreground ,accent03 :weight bold))))
   `(success ((t (:foreground ,accent02 :weight bold))))

   ;; --- mode-line / header / tab lines ---------------------------
   `(mode-line ((t (:background ,surface :foreground ,text))))
   `(mode-line-inactive ((t (:background ,base :foreground ,muted))))
   `(mode-line-active ((t (:background ,surface :foreground ,text))))
   `(mode-line-emphasis ((t (:foreground ,accent05 :weight bold))))
   `(mode-line-highlight ((t (:foreground ,accent05 :box (:line-width -1 :color ,accent05)))))
   `(mode-line-buffer-id ((t (:foreground ,text :weight bold))))
   `(header-line ((t (:background ,med :foreground ,faint))))
   `(header-line-highlight ((t (:background ,med :foreground ,accent05))))
   `(tab-line ((t (:background ,surface :foreground ,muted))))
   `(tab-line-tab ((t (:background ,surface :foreground ,muted))))
   `(tab-line-tab-inactive ((t (:background ,surface :foreground ,muted))))
   `(tab-line-tab-current ((t (:background ,overlay :foreground ,accent05 :weight bold))))
   `(tab-line-highlight ((t (:background ,overlay :foreground ,accent05))))
   `(tab-bar ((t (:background ,surface :foreground ,muted))))
   `(tab-bar-tab ((t (:background ,overlay :foreground ,accent05 :weight bold))))
   `(tab-bar-tab-inactive ((t (:background ,surface :foreground ,muted))))

   ;; --- line numbers ----------------------------------------------
   `(line-number ((t (:foreground ,muted :background ,base))))
   `(line-number-current-line ((t (:foreground ,text :background ,overlay :weight bold))))
   `(line-number-major-tick ((t (:foreground ,faint :background ,base))))
   `(line-number-minor-tick ((t (:foreground ,muted :background ,base))))

   ;; --- search / isearch --------------------------------------------
   `(isearch ((t (:background ,accent03 :foreground ,base))))
   `(isearch-fail ((t (:background ,accent01 :foreground ,light))))
   `(isearch-group-1 ((t (:background ,accent04 :foreground ,base))))
   `(isearch-group-2 ((t (:background ,accent02 :foreground ,base))))
   `(lazy-highlight ((t (:background ,med :foreground ,accent03))))
   `(query-replace ((t (:background ,accent03 :foreground ,base))))

   ;; --- show-paren --------------------------------------------------
   `(show-paren-match ((t (:background ,high :weight bold))))
   `(show-paren-match-expression ((t (:background ,overlay))))
   `(show-paren-mismatch ((t (:background ,accent01 :foreground ,light :weight bold))))

   ;; --- misc syntax ----------------------------------------------
   ;; sh
   `(sh-heredoc ((t (:foreground ,accent03 :weight bold))))
   `(sh-quoted-exec ((t :foreground ,accent01 :slant italic)))
   `(sh-escaped-newline ((t :foreground ,faint)))

   ;; --- font-lock (syntax highlighting) -------------------------------
   ;; comment
   `(font-lock-comment-face ((t (:foreground ,faint :slant italic))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,faint :slant italic))))
   `(font-lock-doc-face ((t (:foreground ,faint :slant italic))))
   `(font-lock-doc-markup-face ((t (:foreground ,faint))))

   ;; constant
   `(font-lock-constant-face ((t (:foreground ,accent03))))
   `(font-lock-number-face ((t (:foreground ,accent03))))

   ;; type
   `(font-lock-type-face ((t (:foreground ,accent03))))

   ;; string
   `(font-lock-string-face ((t (:foreground ,accent02))))

   ;; identifier
   `(font-lock-variable-name-face ((t (:foreground ,accent06))))
   `(font-lock-variable-use-face ((t (:foreground ,accent06))))

   ;; function
   `(font-lock-function-name-face ((t (:foreground ,accent04))))
   `(font-lock-function-call-face ((t (:foreground ,accent04))))

   ;; statement
   `(font-lock-keyword-face ((t (:foreground ,accent05 :weight bold))))

   ;; preproc
   `(font-lock-preprocessor-face ((t (:foreground ,accent05))))

   ;; special
   `(font-lock-builtin-face ((t (:foreground ,accent05 :weight bold))))
   `(font-lock-escape-face ((t (:foreground ,muted))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,muted :weight bold))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,muted :weight bold))))

   ;; misc
   `(font-lock-warning-face ((t (:foreground ,accent01 :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,accent04 :weight bold))))
   `(font-lock-property-name-face ((t (:foreground ,text))))
   `(font-lock-property-use-face ((t (:foreground ,text))))
   `(font-lock-operator-face ((t (:foreground ,text))))
   `(font-lock-bracket-face ((t (:foreground ,text))))
   `(font-lock-punctuation-face ((t (:foreground ,text))))
   `(font-lock-delimiter-face ((t (:foreground ,muted))))

   ;; --- diff-mode ------------------------------------------------
   `(diff-header ((t (:background ,surface))))
   `(diff-file-header ((t (:background ,surface :foreground ,text :weight bold))))
   `(diff-hunk-header ((t (:background ,surface :foreground ,muted))))
   `(diff-context ((t (:foreground ,faint))))
   `(diff-added ((t (:foreground ,accent02))))
   `(diff-removed ((t (:foreground ,accent01))))
   `(diff-changed ((t (:foreground ,accent05))))
   `(diff-refine-added ((t (:background ,accent02 :foreground ,base))))
   `(diff-refine-removed ((t (:background ,accent01 :foreground ,light))))
   `(diff-refine-changed ((t (:background ,accent05 :foreground ,base))))
   `(diff-indicator-added ((t (:foreground ,accent02))))
   `(diff-indicator-removed ((t (:foreground ,accent01))))
   `(diff-indicator-changed ((t (:foreground ,accent05))))

   ;; --- diff-hl ----------------------------------------------------
   `(diff-hl-insert ((t (:foreground ,accent02))))
   `(diff-hl-delete ((t (:foreground ,accent01))))
   `(diff-hl-change ((t (:foreground ,accent05))))

   ;; --- flyspell ---------------------------------------------------
   `(flyspell-incorrect ((t (:foreground ,accent01 :underline (:style wave)))))
   `(flyspell-duplicate ((t (:foreground ,accent03 :underline (:style wave)))))

   ;; --- completions (in-buffer / *Completions*) ---------------------
   `(completions-common-part ((t (:foreground ,accent05 :weight bold))))
   `(completions-first-difference ((t (:foreground ,accent06 :weight bold))))
   `(completions-annotations ((t (:foreground ,muted :slant italic))))
   `(completions-group-title ((t (:foreground ,faint :weight bold))))

   ;; --- widgets / custom-mode ----------------------------------------
   `(widget-field ((t (:background ,overlay :foreground ,text :box (:line-width 1 :color ,muted)))))
   `(widget-single-line-field ((t (:background ,overlay :foreground ,text))))
   `(widget-button ((t (:foreground ,accent05 :weight bold))))
   `(widget-documentation ((t (:foreground ,faint))))
   `(custom-button ((t (:background ,surface :foreground ,text :box (:line-width 1 :color ,muted)))))
   `(custom-button-mouse ((t (:background ,overlay :foreground ,accent05 :box (:line-width 1 :color ,accent05)))))
   `(custom-button-pressed ((t (:background ,overlay :foreground ,accent05 :box (:line-width 1 :color ,accent05)))))
   `(custom-state ((t (:foreground ,accent02))))
   `(custom-variable-tag ((t (:foreground ,accent05 :weight bold))))
   `(custom-group-tag ((t (:foreground ,accent04 :weight bold))))

   ;; --- misc buffer / dired -----------------------------------------
   `(match ((t (:background ,med :foreground ,accent03))))
   `(next-error ((t (:background ,overlay))))
   `(help-key-binding ((t (:foreground ,accent05 :background ,surface :box (:line-width 1 :color ,muted)))))
   `(dired-directory ((t (:foreground ,accent04))))
   `(dired-symlink ((t (:foreground ,accent06))))
   `(dired-broken-symlink ((t (:foreground ,accent01 :underline t))))
   `(dired-marked ((t (:foreground ,accent05 :weight bold))))
   `(dired-flagged ((t (:foreground ,accent01 :weight bold))))
   `(dired-header ((t (:foreground ,accent05 :weight bold))))
   `(dired-ignored ((t (:foreground ,muted))))
   `(dired-mark ((t (:foreground ,accent05 :weight bold))))
   `(dired-warning ((t (:foreground ,accent03 :weight bold))))
   `(dired-perm-write ((t (:foreground ,accent03))))
   `(dired-set-id ((t (:foreground ,accent06 :weight bold))))
   `(dired-special ((t (:foreground ,accent02))))

   ;; --- diredfl --------------------------------------------------------
   `(diredfl-dir-heading ((t (:foreground ,accent05 :weight bold))))
   `(diredfl-dir-name ((t (:foreground ,accent04))))
   `(diredfl-dir-priv ((t (:foreground ,accent04))))
   `(diredfl-file-name ((t (:foreground ,text))))
   `(diredfl-file-suffix ((t (:foreground ,faint))))
   `(diredfl-symlink ((t (:foreground ,accent06))))
   `(diredfl-number ((t (:foreground ,accent03))))
   `(diredfl-date-time ((t (:foreground ,faint))))
   `(diredfl-deletion ((t (:foreground ,accent01 :weight bold))))
   `(diredfl-deletion-file-name ((t (:foreground ,accent01 :strike-through t))))
   `(diredfl-flag-mark ((t (:foreground ,accent05 :weight bold :background ,overlay))))
   `(diredfl-flag-mark-line ((t (:background ,overlay))))
   `(diredfl-ignored-file-name ((t (:foreground ,muted))))
   `(diredfl-compressed-file-suffix ((t (:foreground ,accent06))))
   `(diredfl-compressed-file-name ((t (:foreground ,text))))
   `(diredfl-executable-flag ((t (:foreground ,accent02 :weight bold))))
   `(diredfl-read-priv ((t (:foreground ,accent03))))
   `(diredfl-write-priv ((t (:foreground ,accent03))))
   `(diredfl-exec-priv ((t (:foreground ,accent02))))
   `(diredfl-no-priv ((t (:foreground ,muted))))
   `(diredfl-rare-priv ((t (:foreground ,accent06 :weight bold))))
   `(diredfl-link-priv ((t (:foreground ,accent06))))
   `(diredfl-autofile-name ((t (:foreground ,faint :slant italic))))
   `(diredfl-tagged-autofile-name ((t (:foreground ,accent05 :slant italic))))

   ;; --- flymake --------------------------------------------------------
   `(flymake-error ((t (:underline (:style wave :color ,accent01)))))
   `(flymake-warning ((t (:underline (:style wave :color ,accent03)))))
   `(flymake-note ((t (:underline (:style wave :color ,accent04)))))
   `(flymake-error-echo ((t (:foreground ,accent01))))
   `(flymake-warning-echo ((t (:foreground ,accent03))))
   `(flymake-note-echo ((t (:foreground ,accent04))))

   ;; --- flycheck -------------------------------------------------------
   `(flycheck-error ((t (:underline (:style wave :color ,accent01)))))
   `(flycheck-warning ((t (:underline (:style wave :color ,accent03)))))
   `(flycheck-info ((t (:underline (:style wave :color ,accent04)))))
   `(flycheck-fringe-error ((t (:foreground ,accent01 :weight bold))))
   `(flycheck-fringe-warning ((t (:foreground ,accent03 :weight bold))))
   `(flycheck-fringe-info ((t (:foreground ,accent04 :weight bold))))
   `(flycheck-error-list-error ((t (:foreground ,accent01 :weight bold))))
   `(flycheck-error-list-warning ((t (:foreground ,accent03 :weight bold))))
   `(flycheck-error-list-info ((t (:foreground ,accent04))))

   ;; --- jinkx monsoon ---------------------------------------------------
   `(jinx-misspelled ((t (:foreground ,accent01 :underline (:style wave :color ,accent01)))))
   `(jinx-highlight ((t (:foreground ,base :background ,accent03))))

   ;; --- eldoc / help hints & tooltips -----------------------------------
   `(eldoc-highlight-function-argument ((t (:foreground ,accent05 :weight bold))))
   `(eldoc-box-body ((t (:background ,surface :foreground ,text))))
   `(eldoc-box-border ((t (:background ,muted))))

   ;; --- markdown-mode -------------------------------------------------
   `(markdown-header-face ((t (:foreground ,accent05 :weight bold))))
   `(markdown-header-face-1 ((t (:foreground ,accent05 :weight bold))))
   `(markdown-header-face-2 ((t (:foreground ,accent03 :weight bold))))
   `(markdown-header-face-3 ((t (:foreground ,accent02 :weight bold))))
   `(markdown-header-face-4 ((t (:foreground ,accent06 :weight bold))))
   `(markdown-header-face-5 ((t (:foreground ,accent04 :weight bold))))
   `(markdown-header-face-6 ((t (:foreground ,accent01 :weight bold))))
   `(markdown-header-delimiter-face ((t (:foreground ,muted))))
   `(markdown-link-face ((t (:foreground ,accent04 :underline t))))
   `(markdown-url-face ((t (:foreground ,accent04 :slant italic :underline t))))
   `(markdown-code-face ((t (:foreground ,accent02))))
   `(markdown-inline-code-face ((t (:foreground ,accent02))))
   `(markdown-blockquote-face ((t (:foreground ,faint :slant italic))))
   `(markdown-list-face ((t (:foreground ,accent03))))
   `(markdown-bold-face ((t (:weight bold))))
   `(markdown-italic-face ((t (:slant italic))))
   `(markdown-strike-through-face ((t (:strike-through t :foreground ,muted))))
   `(markdown-markup-face ((t (:foreground ,muted))))

   ;; --- org-mode basics ------------------------------------------------
   `(org-level-1 ((t (:foreground ,accent05 :weight bold))))
   `(org-level-2 ((t (:foreground ,accent03 :weight bold))))
   `(org-level-3 ((t (:foreground ,accent02 :weight bold))))
   `(org-level-4 ((t (:foreground ,accent06 :weight bold))))
   `(org-level-5 ((t (:foreground ,accent04 :weight bold))))
   `(org-level-6 ((t (:foreground ,accent01 :weight bold))))
   `(org-document-title ((t (:foreground ,accent05 :weight bold))))
   `(org-document-info ((t (:foreground ,faint))))
   `(org-block ((t (:background ,surface :foreground ,text))))
   `(org-block-begin-line ((t (:background ,surface :foreground ,muted))))
   `(org-block-end-line ((t (:background ,surface :foreground ,muted))))
   `(org-code ((t (:foreground ,accent02))))
   `(org-verbatim ((t (:foreground ,accent06))))
   `(org-link ((t (:foreground ,accent04 :underline t))))
   `(org-todo ((t (:background ,accent01 :foreground ,low :weight bold))))
   `(org-done ((t (:background ,accent02 :foreground ,low :weight bold))))
   `(org-headline-todo ((t (:foreground ,accent01))))
   `(org-headline-done ((t (:foreground ,accent02))))
   `(org-date ((t (:foreground ,muted :underline t))))
   `(org-tag ((t (:foreground ,faint))))
   `(org-special-keyword ((t (:foreground ,muted))))
   `(org-quote ((t (:foreground ,faint :slant italic))))
   `(org-macro ((t (:foreground ,accent03))))
   `(org-table ((t (:foreground ,accent05))))
   `(org-footnote ((t :foreground ,accent06 :underline t)))
   `(org-special-keyword ((t :foreground ,accent06)))
   ;; custom todo keywords
   `(sailorfe-org-todo-next ((t (:background ,accent05 :foreground ,low :weight bold))))
   `(sailorfe-org-todo-prog ((t (:background ,accent06 :foreground ,low :weight bold))))
   `(sailorfe-org-todo-wait ((t (:background ,accent04 :foreground ,low :weight bold))))
   `(sailorfe-org-todo-void ((t (:background ,high :foreground ,low :weight bold :strikethrough t))))

   ;; --- org-agenda -----------------------------------------------------
   `(org-agenda-structure ((t (:foreground ,accent05 :weight bold))))
   `(org-agenda-date ((t (:foreground ,accent04))))
   `(org-agenda-date-weekend ((t (:foreground ,faint))))
   `(org-agenda-date-today ((t (:foreground ,accent05 :weight bold :underline t))))
   `(org-agenda-current-time ((t (:foreground ,accent03))))
   `(org-agenda-clocking ((t (:background ,med))))
   `(org-agenda-done ((t (:foreground ,accent02))))
   `(org-agenda-dimmed-todo-face ((t (:foreground ,muted))))
   `(org-agenda-restriction-lock ((t (:background ,overlay))))
   `(org-agenda-filter-tags ((t (:foreground ,accent06))))
   `(org-time-grid ((t (:foreground ,muted))))
   `(org-scheduled ((t (:foreground ,text))))
   `(org-scheduled-today ((t (:foreground ,accent05))))
   `(org-scheduled-previously ((t (:foreground ,accent03))))
   `(org-upcoming-deadline ((t (:foreground ,accent03))))
   `(org-upcoming-distant-deadline ((t (:foreground ,faint))))
   `(org-imminent-deadline ((t (:foreground ,accent01 :weight bold))))
   `(org-warning ((t (:foreground ,accent01 :weight bold))))
   `(org-priority ((t (:foreground ,accent06))))
   `(org-column ((t (:background ,surface))))
   `(org-column-title ((t (:background ,surface :foreground ,accent05 :weight bold))))

   ;; --- magit ------------------------------------------------------------

   ;; sections / headers
   `(magit-section-heading ((t (:foreground ,accent05 :weight bold))))
   `(magit-section-heading-selection ((t (:background ,overlay :foreground ,accent05 :weight bold))))
   `(magit-section-highlight ((t (:background ,surface))))

   ;; popup / transient interface
   `(transient-heading ((t (:foreground ,accent05 :weight bold))))
   `(transient-key ((t (:foreground ,accent04 :weight bold))))
   `(transient-argument ((t (:foreground ,accent02))))
   `(transient-value ((t (:foreground ,accent03))))
   `(transient-inactive-argument ((t (:foreground ,muted))))
   `(transient-inactive-value ((t (:foreground ,muted))))

   ;; branch / refs
   `(magit-branch-local ((t (:foreground ,accent02 :weight bold))))
   `(magit-branch-remote ((t (:foreground ,accent04 :weight bold))))
   `(magit-branch-current ((t (:foreground ,accent05 :weight bold))))
   `(magit-branch-upstream ((t (:foreground ,accent03))))
   `(magit-head ((t (:foreground ,accent05 :weight bold))))

   `(magit-tag ((t (:foreground ,accent06 :weight bold))))

   ;; commit metadata
   `(magit-log-author ((t (:foreground ,text))))
   `(magit-log-date ((t (:foreground ,muted))))
   `(magit-log-graph ((t (:foreground ,faint))))
   `(magit-hash ((t (:foreground ,muted))))
   `(magit-reflog-commit ((t (:foreground ,accent02))))
   `(magit-reflog-other ((t (:foreground ,accent04))))

   ;; commit messages
   `(magit-diff-file-heading ((t (:foreground ,accent05 :weight bold))))
   `(magit-diff-file-heading-highlight ((t (:background ,surface :foreground ,accent05 :weight bold))))
   `(magit-diff-file-heading-selection ((t (:background ,overlay :foreground ,light :weight bold))))
   `(magit-diff-hunk-heading ((t (:background ,surface :foreground ,accent04))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,overlay :foreground ,accent05))))
   `(magit-diff-hunk-heading-selection ((t (:background ,overlay :foreground ,light))))

   ;; diff content
   `(magit-diff-context ((t (:foreground ,faint))))
   `(magit-diff-context-highlight ((t (:background ,surface :foreground ,text))))

   `(magit-diff-added ((t (:foreground ,accent02))))
   `(magit-diff-added-highlight ((t (:background ,accent02 :foreground ,base))))

   `(magit-diff-removed ((t (:foreground ,accent01))))
   `(magit-diff-removed-highlight ((t (:background ,accent01 :foreground ,light))))

   `(magit-diff-added-highlight ((t (:background ,accent02 :foreground ,base))))
   `(magit-diff-removed-highlight ((t (:background ,accent01 :foreground ,light))))

   `(magit-diff-whitespace-warning ((t (:background ,accent03 :foreground ,base))))

   ;; status buffer
   `(magit-diffstat-added ((t (:foreground ,accent02))))
   `(magit-diffstat-removed ((t (:foreground ,accent01))))
   `(magit-diffstat-neutral ((t (:foreground ,muted))))

   `(magit-status-heading ((t (:foreground ,accent05 :weight bold))))
   `(magit-status-heading-key ((t (:foreground ,accent04))))
   `(magit-status-untracked ((t (:foreground ,accent06))))
   `(magit-status-ignored ((t (:foreground ,muted))))
   `(magit-status-modified ((t (:foreground ,accent03))))
   `(magit-status-added ((t (:foreground ,accent02))))
   `(magit-status-renamed ((t (:foreground ,accent04))))
   `(magit-status-conflict ((t (:foreground ,accent01 :weight bold))))

   ;; process / errors
   `(magit-process-ok ((t (:foreground ,accent02 :weight bold))))
   `(magit-process-ng ((t (:foreground ,accent01 :weight bold))))

   ;; blame
   `(magit-blame-heading ((t (:background ,surface :foreground ,text))))
   `(magit-blame-highlight ((t (:background ,overlay))))
   `(magit-blame-date ((t (:foreground ,muted))))
   `(magit-blame-name ((t (:foreground ,accent05))))

   ;; --- in-buffer completion popups (corfu) ----------------------------
   `(corfu-default ((t (:background ,surface :foreground ,text))))
   `(corfu-current ((t (:background ,overlay :foreground ,accent05 :weight bold))))
   `(corfu-bar ((t (:background ,high))))
   `(corfu-border ((t (:background ,muted))))
   `(corfu-annotations ((t (:foreground ,muted :slant italic))))
   `(corfu-deprecated ((t (:foreground ,muted :strike-through t))))

   ;; --- minibuffer completion UI ---------------------------------------
   `(vertico-current ((t (:background ,overlay :foreground ,accent05 :weight bold))))
   `(vertico-group-title ((t (:foreground ,faint :weight bold))))
   `(vertico-group-separator ((t (:foreground ,muted :strike-through t))))
   `(vertico-mkamakuraline ((t (:foreground ,muted))))
   `(orderless-match-face-0 ((t (:foreground ,accent05 :weight bold))))
   `(orderless-match-face-1 ((t (:foreground ,accent04 :weight bold))))
   `(orderless-match-face-2 ((t (:foreground ,accent02 :weight bold))))
   `(orderless-match-face-3 ((t (:foreground ,accent06 :weight bold))))

   ;; --- eww -------------------------------------------------------------
   `(eww-form-file ((t (:foreground ,base :background ,faint :box nil))))
   `(eww-form-submit ((t (:foreground ,base :background ,faint :box nil))))
   `(eww-form-text ((t (:foreground ,base :background ,text :box nil))))
   `(eww-form-select ((t (:foreground ,base :background ,accent06 :box nil))))
   `(eww-form-checkbox ((t (:foreground ,base :background ,accent06 :box nil))))
   `(eww-form-textarea ((t (:foreground ,base :background ,text :box nil))))
   `(eww-invalid-certificate ((t :foreground ,accent01 :weight bold)))
   `(eww-valid-certificate ((t :foreground ,accent02 :weight bold)))

   ;; --- dashboard -------------------------------------------------------
   `(dashboard-heading ((t (:foreground ,accent04 :weight bold))))
   `(dashboard-navigator ((t (:foreground ,accent06 :weight bold))))
   `(dashboard-items-face ((t (:foreground ,accent06 :weight bold))))
   `(dashboard-no-items-face ((t (:foreground ,muted :weight bold))))
   `(dashboard-footer-face ((t (:foreground ,faint :slant italic))))
   `(dashboard-text-banner ((t (:foreground ,accent04))))
   `(dashboard-banner-logo-title ((t (:foreground ,text))))
   
   ;; --- vterm -----------------------------------------------------------
   `(vterm-color-black ((t (:foreground ,low :background ,low))))
   `(vterm-color-bright-black ((t (:foreground ,med :background ,med))))
   `(vterm-color-red ((t (:foreground ,accent01 :background ,accent01))))
   `(vterm-color-bright-red ((t (:foreground ,bright01 :background ,bright01))))
   `(vterm-color-green ((t (:foreground ,accent02 :background ,accent02))))
   `(vterm-color-bright-green ((t (:foreground ,bright02 :background ,bright02))))
   `(vterm-color-yellow ((t (:foreground ,accent03 :background ,accent03))))
   `(vterm-color-bright-yellow ((t (:foreground ,bright03 :background ,bright03))))
   `(vterm-color-blue ((t (:foreground ,accent04 :background ,accent04))))
   `(vterm-color-bright-blue ((t (:foreground ,bright04 :background ,bright04))))
   `(vterm-color-magenta ((t (:foreground ,accent05 :background ,accent05))))
   `(vterm-color-bright-magenta ((t (:foreground ,bright05 :background ,bright05))))
   `(vterm-color-cyan ((t (:foreground ,accent06 :background ,accent06))))
   `(vterm-color-bright-cyan ((t (:foreground ,bright06 :background ,bright06))))
   `(vterm-color-white ((t (:foreground ,text :background ,text))))
   `(vterm-color-bright-white ((t (:foreground ,light :background ,light))))
   `(vterm-color-underline ((t (:foreground ,accent06))))
   `(vterm-color-inverse-video ((t (:background ,base :inverse-video t))))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'kamakura)

;;; --- automated exports -------------------------------------------------

(defun kamakura/render-template (template-file output-file &optional strip-hash)
  "Inject kamakura/palette values into TEMPLATE-FILE and write to extras/OUTPUT-FILE.
STRIP-HASH optionally removes # from templates that require bare rrggbb."
  (with-temp-buffer
    (insert-file-contents template-file)
    (dolist (pair kamakura/palette)
      (goto-char (point-min))
      (let ((value (if strip-hash (substring (cdr pair) 1) (cdr pair))))
        (while (search-forward (format "{{%s}}" (car pair)) nil t)
          (replace-match value t t))))
    (make-directory (file-name-directory output-file) t)
    (write-region (point-min) (point-max) output-file)
    (message "kamakura: wrote %s" output-file)))

(defvar kamakura/export-targets
  '(("templates/palette.json" . "palette.json")
    ("templates/ansi.json" . "extras/ansi/kamakura.json")
    ("templates/foot.ini" "extras/foot/kamakura.ini" t)
    ("templates/mako" . "extras/mako/kamakura")
    ("templates/nvim.lua" . "extras/nvim/lua/kamakura.lua")
    ("templates/shell.sh" . "extras/shell/kamakura.sh")
    ("templates/termux.properties" . "extras/termux/kamakura.properties")
    ("templates/tty.conf" "extras/tty/kamakura.conf" t)
    ("templates/vim.vim" "extras/vim/colors/kamakura.vim")))

(defun kamakura/export-all ()
  "Render every template in `kamakura/export-targets' against `kamakura/palette'.
Callable interactively, or headless via:
  `emacs --batch -l kamakura-theme.el -f kamakura/export-all`."
  (interactive)
  (dolist (entry kamakura/export-targets)
    (let ((template (if (consp (cdr entry)) (nth 0 entry) (car entry)))
          (output    (if (consp (cdr entry)) (nth 1 entry) (cdr entry)))
          (strip     (if (consp (cdr entry)) (nth 2 entry) nil)))
      (kamakura/render-template
       (expand-file-name template kamakura/theme-dir)
       (expand-file-name output)
       strip))))

;;; kamakura-theme.el ends here
