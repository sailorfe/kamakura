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

(defun kamakura/clamp01 (x)
  "Clamp X into the [0.0, 1.0] range."
  (min 1.0 (max 0.0 x)))

(defun kamakura/apply-deltas (h s l &optional dh ds dl)
  "Return the list (H S L), each offset by optional DH, DS, DL.
H wraps into [0, 360); S and L clamp into [0.0, 1.0].  All deltas default to 0."
  (list (mod (+ h (or dh 0.0)) 360.0)
        (kamakura/clamp01 (+ s (or ds 0.0)))
        (kamakura/clamp01 (+ l (or dl 0.0)))))

(defun kamakura/hsl (h s l &optional dh ds dl)
  "Convert H, S and L to a hex color string.
H is in degrees (0-360); S and L are floats in [0.0, 1.0].
DH, DS and DL are optional deltas added to H, S and L before conversion."
  (pcase-let ((`(,h ,s ,l) (kamakura/apply-deltas h s l dh ds dl)))
    (apply #'color-rgb-to-hex
           (append (color-hsl-to-rgb (/ h 360.0) s l) '(2)))))

(defun kamakura/rgb (hex)
  "Convert HEX color to a comma-separated RGB string: \"r, g, b\"."
  (let* ((r (string-to-number (substring hex 1 3) 16))
         (g (string-to-number (substring hex 3 5) 16))
         (b (string-to-number (substring hex 5 7) 16)))
    (format "%d, %d, %d" r g b)))

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

(defconst kamakura/palette-spec
  '(;; backgrounds
    (base    45 0.71 0.93)
    (surface 46 0.76 0.90)
    (overlay 40 0.82 0.87)

    ;; foregrounds
    (muted 35 0.16 0.60)
    (faint 35 0.12 0.48)
    (text  30 0.22 0.30)
    (light 30 0.28 0.20)

    ;; contrast
    (low  44 0.30 0.90)
    (med  39 0.25 0.82)
    (high 44 0.45 0.72)

    ;; accents
    (miko      352 0.76 0.38)   ; red
    (yorishige 114 0.50 0.36)   ; green
    (mima      44  0.75 0.46)   ; gold
    (tokiyuki  263 0.33 0.61)   ; purple
    (ayako     355 0.63 0.65)   ; pink
    (shizuku   186 0.53 0.35)   ; turquoise

    ;; brights for terminals
    (taisha    miko      0.0 -0.2  0.15)
    (suwa      yorishige 0.0 -0.15 0.15)
    (sasaki    mima      0.0  0.0  0.1)
    (hojo      tokiyuki  0.0  0.0  0.1)
    (mochizuki ayako     0.0  0.0  0.1)
    (kami      shizuku   0.0 -0.2  0.15)))

(defun kamakura/build-palette ()
  "Derive the full hex palette from `palette-spec'.
Returns an alist of hex colors, a `NAME-rgb' comma-separated RGB string for each, and a `NAME-cterm' nearest-256 index for each."
  (let (hsl-table hex)
    (dolist (spec kamakura/palette-spec)
      (pcase spec
        (`(,name ,h ,s ,l)
         (push (cons name (list h s l)) hsl-table)
         (push (cons name (kamakura/hsl h s l)) hex))
        (`(,name ,base ,dh ,ds ,dl)
         (let ((base-hsl (alist-get base hsl-table)))
           (unless base-hsl
             (error "kamakura: `%s' derives from unknown or later color `%s'" name base))
           (let ((resolved (apply #'kamakura/apply-deltas (append base-hsl (list dh ds dl)))))
             (push (cons name resolved) hsl-table)
             (push (cons name (apply #'kamakura/hsl resolved)) hex))))))
    (setq hex (nreverse hex))
    (let* ((rgb (mapcar (lambda (p)
                          (cons (intern (format "%s-rgb" (car p)))
                                (kamakura/rgb (cdr p))))
                        hex))
           (raw (append hex rgb)))
      (append raw
              (mapcar (lambda (p)
                        (cons (intern (format "%s-cterm" (car p)))
                              (kamakura/nearest-256 (cdr p))))
                      ;; the rgb helpers aren't hex, so they have no cterm form
                      hex)))))

(defvar kamakura/palette (kamakura/build-palette))

(defmacro kamakura/with-palette (&rest body)
  "Bind every color name in 'palette-spec' to its hex value from 'palette', then evaluate BODY."
  (declare (indent 0))
  (let ((names (mapcar #'car kamakura/palette-spec)))
    `(let* ,(mapcar (lambda (n) (list n `(alist-get ',n kamakura/palette))) names)
       ,@body)))

(deftheme kamakura "Nanbokuchou theme.")

(kamakura/with-palette
 (custom-theme-set-faces
  'kamakura
  ;; --- core ui -------------------------------------------------
  `(default ((t (:background ,base :foreground ,text))))
  `(cursor ((t (:background ,text))))
  `(region ((t (:background ,ayako :foreground ,base))))
  `(secondary-selection ((t (:background ,med :foreground ,mima))))
  `(highlight ((t (:background ,overlay :foreground ,ayako))))
  `(hl-line ((t (:background ,overlay))))
  `(fringe ((t (:background ,base :foreground ,muted))))
  `(vertical-border ((t (:foreground ,surface))))
  `(window-divider ((t (:foreground ,surface))))
  `(window-divider-first-pixel ((t (:foreground ,surface))))
  `(window-divider-last-pixel ((t (:foreground ,surface))))
  `(minibuffer-prompt ((t (:foreground ,tokiyuki :weight bold))))
  `(shadow ((t (:foreground ,muted))))
  `(link ((t (:foreground ,tokiyuki :underline t))))
  `(link-visited ((t (:foreground ,yorishige :underline t))))
  `(escape-glyph ((t (:foreground ,shizuku))))
  `(homoglyph ((t (:foreground ,shizuku))))
  `(tooltip ((t (:background ,surface :foreground ,text))))
  `(trailing-whitespace ((t (:background ,overlay))))
  `(nobreak-space ((t (:foreground ,muted :underline t))))
  `(fill-column-indicator ((t (:foreground ,high))))
  `(bookmark-face ((t (:foreground ,tokiyuki))))

  ;; --- errors / warnings / success ------------------------------
  `(error ((t (:foreground ,miko :weight bold))))
  `(warning ((t (:foreground ,mima :weight bold))))
  `(success ((t (:foreground ,yorishige :weight bold))))

  ;; --- mode-line / header / tab lines ---------------------------
  `(mode-line ((t (:background ,surface :foreground ,text))))
  `(mode-line-inactive ((t (:background ,base :foreground ,muted))))
  `(mode-line-active ((t (:background ,surface :foreground ,text))))
  `(mode-line-emphasis ((t (:foreground ,ayako :weight bold))))
  `(mode-line-highlight ((t (:foreground ,ayako :box (:line-width -1 :color ,ayako)))))
  `(mode-line-buffer-id ((t (:foreground ,text :weight bold))))
  `(header-line ((t (:background ,med :foreground ,faint))))
  `(header-line-highlight ((t (:background ,med :foreground ,ayako))))
  `(tab-line ((t (:background ,surface :foreground ,muted))))
  `(tab-line-tab ((t (:background ,surface :foreground ,muted))))
  `(tab-line-tab-inactive ((t (:background ,surface :foreground ,muted))))
	`(tab-line-tab-current ((t (:background ,overlay :foreground ,ayako :weight bold))))
	`(tab-line-highlight ((t (:background ,overlay :foreground ,ayako))))
	`(tab-bar ((t (:background ,surface :foreground ,muted))))
  `(tab-bar-tab ((t (:background ,overlay :foreground ,ayako :weight bold))))
  `(tab-bar-tab-inactive ((t (:background ,surface :foreground ,muted))))

  ;; --- line numbers -------------------------------------------------
  `(line-number ((t (:foreground ,muted :background ,base))))
  `(line-number-current-line ((t (:foreground ,text :background ,overlay :weight bold))))
  `(line-number-major-tick ((t (:foreground ,faint :background ,base))))
  `(line-number-minor-tick ((t (:foreground ,muted :background ,base))))

  ;; --- search / isearch ---------------------------------------------
  `(isearch ((t (:background ,mima :foreground ,base))))
  `(isearch-fail ((t (:background ,miko :foreground ,light))))
  `(isearch-group-1 ((t (:background ,tokiyuki :foreground ,base))))
  `(isearch-group-2 ((t (:background ,yorishige :foreground ,base))))
  `(lazy-highlight ((t (:background ,med :foreground ,mima))))
  `(query-replace ((t (:background ,mima :foreground ,base))))

  ;; --- show-paren ---------------------------------------------------
  `(show-paren-match ((t (:background ,high :weight bold))))
  `(show-paren-match-expression ((t (:background ,overlay))))
  `(show-paren-mismatch ((t (:background ,miko :foreground ,light :weight bold))))

  ;; --- sh ------------------------------------------------------------
  `(sh-heredoc ((t (:foreground ,mima :weight bold))))
  `(sh-quoted-exec ((t :foreground ,miko :slant italic)))
  `(sh-escaped-newline ((t :foreground ,faint)))

  ;; --- font-lock (syntax highlighting) -------------------------------
  ;; comment
  `(font-lock-comment-face ((t (:foreground ,faint :slant italic))))
  `(font-lock-comment-delimiter-face ((t (:foreground ,faint :slant italic))))
  `(font-lock-doc-face ((t (:foreground ,faint :slant italic))))
  `(font-lock-doc-markup-face ((t (:foreground ,faint))))

  ;; constant
  `(font-lock-constant-face ((t (:foreground ,mima))))
  `(font-lock-number-face ((t (:foreground ,mima))))

  ;; type
  `(font-lock-type-face ((t (:foreground ,mima))))

  ;; string
  `(font-lock-string-face ((t (:foreground ,yorishige))))

  ;; identifier
  `(font-lock-variable-name-face ((t (:foreground ,shizuku))))
  `(font-lock-variable-use-face ((t (:foreground ,shizuku))))

  ;; function
  `(font-lock-function-name-face ((t (:foreground ,tokiyuki))))
  `(font-lock-function-call-face ((t (:foreground ,tokiyuki))))

  ;; statement
  `(font-lock-keyword-face ((t (:foreground ,ayako :weight bold))))

  ;; preproc
  `(font-lock-preprocessor-face ((t (:foreground ,ayako))))

  ;; special
  `(font-lock-builtin-face ((t (:foreground ,ayako :weight bold))))
  `(font-lock-escape-face ((t (:foreground ,muted))))
  `(font-lock-regexp-grouping-backslash ((t (:foreground ,muted :weight bold))))
  `(font-lock-regexp-grouping-construct ((t (:foreground ,muted :weight bold))))

  ;; misc
  `(font-lock-warning-face ((t (:foreground ,miko :weight bold))))
  `(font-lock-negation-char-face ((t (:foreground ,tokiyuki :weight bold))))
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
  `(diff-added ((t (:foreground ,yorishige))))
  `(diff-removed ((t (:foreground ,miko))))
  `(diff-changed ((t (:foreground ,ayako))))
  `(diff-refine-added ((t (:background ,yorishige :foreground ,base))))
  `(diff-refine-removed ((t (:background ,miko :foreground ,light))))
  `(diff-refine-changed ((t (:background ,ayako :foreground ,base))))
  `(diff-indicator-added ((t (:foreground ,yorishige))))
  `(diff-indicator-removed ((t (:foreground ,miko))))
  `(diff-indicator-changed ((t (:foreground ,ayako))))

  ;; --- flyspell -----------------------------------------------------
  `(flyspell-incorrect ((t (:foreground ,miko :underline (:style wave)))))
  `(flyspell-duplicate ((t (:foreground ,mima :underline (:style wave)))))

  ;; --- completions ----------------------------------------------------
  `(completions-common-part ((t (:foreground ,ayako :weight bold))))
  `(completions-first-difference ((t (:foreground ,shizuku :weight bold))))
  `(completions-annotations ((t (:foreground ,muted :slant italic))))
  `(completions-group-title ((t (:foreground ,faint :weight bold))))

  ;; --- widgets / custom-mode --------------------------------------------
  `(widget-field ((t (:background ,overlay :foreground ,text :box (:line-width 1 :color ,muted)))))
  `(widget-single-line-field ((t (:background ,overlay :foreground ,text))))
  `(widget-button ((t (:foreground ,ayako :weight bold))))
  `(widget-documentation ((t (:foreground ,faint))))
  `(custom-button ((t (:background ,surface :foreground ,text :box (:line-width 1 :color ,muted)))))
  `(custom-button-mouse ((t (:background ,overlay :foreground ,ayako :box (:line-width 1 :color ,ayako)))))
  `(custom-button-pressed ((t (:background ,overlay :foreground ,ayako :box (:line-width 1 :color ,ayako)))))
  `(custom-state ((t (:foreground ,yorishige))))
  `(custom-variable-tag ((t (:foreground ,ayako :weight bold))))
  `(custom-group-tag ((t (:foreground ,tokiyuki :weight bold))))

  ;; --- misc buffer / dired ---------------------------------------------
  `(match ((t (:background ,med :foreground ,mima))))
  `(next-error ((t (:background ,overlay))))
  `(help-key-binding ((t (:foreground ,ayako :background ,surface :box (:line-width 1 :color ,muted)))))
  `(dired-directory ((t (:foreground ,tokiyuki))))
  `(dired-symlink ((t (:foreground ,shizuku))))
  `(dired-broken-symlink ((t (:foreground ,miko :underline t))))
  `(dired-marked ((t (:foreground ,ayako :weight bold))))
  `(dired-flagged ((t (:foreground ,miko :weight bold))))
  `(dired-header ((t (:foreground ,ayako :weight bold))))
  `(dired-ignored ((t (:foreground ,muted))))
  `(dired-mark ((t (:foreground ,ayako :weight bold))))
  `(dired-warning ((t (:foreground ,mima :weight bold))))
  `(dired-perm-write ((t (:foreground ,mima))))
  `(dired-set-id ((t (:foreground ,shizuku :weight bold))))
  `(dired-special ((t (:foreground ,yorishige))))

  ;; --- flymake -------------------------------------------------------
  `(flymake-error ((t (:underline (:style wave :color ,miko)))))
  `(flymake-warning ((t (:underline (:style wave :color ,mima)))))
  `(flymake-note ((t (:underline (:style wave :color ,tokiyuki)))))
  `(flymake-error-echo ((t (:foreground ,miko))))
  `(flymake-warning-echo ((t (:foreground ,mima))))
  `(flymake-note-echo ((t (:foreground ,tokiyuki))))

  ;; --- eldoc -----------------------------------------------------------
  `(eldoc-highlight-function-argument ((t (:foreground ,ayako :weight bold))))

  ;; --- org-mode basics -------------------------------------------------
  `(org-level-1 ((t (:foreground ,ayako :weight bold))))
  `(org-level-2 ((t (:foreground ,mima :weight bold))))
  `(org-level-3 ((t (:foreground ,yorishige :weight bold))))
  `(org-level-4 ((t (:foreground ,shizuku :weight bold))))
  `(org-level-5 ((t (:foreground ,tokiyuki :weight bold))))
  `(org-level-6 ((t (:foreground ,miko :weight bold))))
  `(org-document-title ((t (:foreground ,ayako :weight bold))))
  `(org-document-info ((t (:foreground ,faint))))
  `(org-block ((t (:background ,surface :foreground ,text))))
  `(org-block-begin-line ((t (:background ,surface :foreground ,muted))))
  `(org-block-end-line ((t (:background ,surface :foreground ,muted))))
  `(org-code ((t (:foreground ,yorishige))))
  `(org-verbatim ((t (:foreground ,shizuku))))
  `(org-link ((t (:foreground ,tokiyuki :underline t))))
  `(org-todo ((t (:background ,miko :foreground ,low :weight bold))))
  `(org-done ((t (:background ,yorishige :foreground ,low :weight bold))))
  `(org-headline-todo ((t (:foreground ,miko))))
  `(org-headline-done ((t (:foreground ,yorishige))))
  `(org-date ((t (:foreground ,muted :underline t))))
  `(org-tag ((t (:foreground ,faint))))
  `(org-special-keyword ((t (:foreground ,muted))))
  `(org-quote ((t (:foreground ,faint :slant italic))))
  `(org-macro ((t (:foreground ,mima))))
  `(org-table ((t (:foreground ,ayako))))
  `(org-footnote ((t :foreground ,shizuku :underline t)))
  `(org-special-keyword ((t :foreground ,shizuku)))
  ;; custom todo keywords
  `(sailorfe-org-todo-next ((t (:background ,ayako :foreground ,low :weight bold))))
  `(sailorfe-org-todo-prog ((t (:background ,shizuku :foreground ,low :weight bold))))
  `(sailorfe-org-todo-wait ((t (:background ,tokiyuki :foreground ,low :weight bold))))
  `(sailorfe-org-todo-void ((t (:background ,high :foreground ,low :weight bold :strikethrough t))))

  ;; --- org-agenda -------------------------------------------------------
  `(org-agenda-structure ((t (:foreground ,ayako :weight bold))))
  `(org-agenda-date ((t (:foreground ,tokiyuki))))
  `(org-agenda-date-weekend ((t (:foreground ,faint))))
  `(org-agenda-date-today ((t (:foreground ,ayako :weight bold :underline t))))
  `(org-agenda-current-time ((t (:foreground ,mima))))
  `(org-agenda-clocking ((t (:background ,med))))
  `(org-agenda-done ((t (:foreground ,yorishige))))
  `(org-agenda-dimmed-todo-face ((t (:foreground ,muted))))
  `(org-agenda-restriction-lock ((t (:background ,overlay))))
  `(org-agenda-filter-tags ((t (:foreground ,shizuku))))
  `(org-time-grid ((t (:foreground ,muted))))
  `(org-scheduled ((t (:foreground ,text))))
  `(org-scheduled-today ((t (:foreground ,ayako))))
  `(org-scheduled-previously ((t (:foreground ,mima))))
  `(org-upcoming-deadline ((t (:foreground ,mima))))
  `(org-upcoming-distant-deadline ((t (:foreground ,faint))))
  `(org-imminent-deadline ((t (:foreground ,miko :weight bold))))
  `(org-warning ((t (:foreground ,miko :weight bold))))
  `(org-priority ((t (:foreground ,shizuku))))
  `(org-column ((t (:background ,surface))))
  `(org-column-title ((t (:background ,surface :foreground ,ayako :weight bold))))

  ;; --- eww ---------------------------------------------------------------
  `(eww-form-file ((t (:foreground ,base :background ,faint :box nil))))
  `(eww-form-submit ((t (:foreground ,base :background ,faint :box nil))))
  `(eww-form-text ((t (:foreground ,base :background ,text :box nil))))
  `(eww-form-select ((t (:foreground ,base :background ,shizuku :box nil))))
  `(eww-form-checkbox ((t (:foreground ,base :background ,shizuku :box nil))))
  `(eww-form-textarea ((t (:foreground ,base :background ,text :box nil))))
  `(eww-invalid-certificate ((t :foreground ,miko :weight bold)))
  `(eww-valid-certificate ((t :foreground ,yorishige :weight bold)))

  ;; =====================================================================
  ;; external packages
  ;; =====================================================================

  ;; --- diff-hl -----------------------------------------------------------
  `(diff-hl-insert ((t (:foreground ,yorishige))))
  `(diff-hl-delete ((t (:foreground ,miko))))
  `(diff-hl-change ((t (:foreground ,ayako))))

  ;; --- diredfl -------------------------------------------------------
  `(diredfl-dir-heading ((t (:foreground ,ayako :weight bold))))
  `(diredfl-dir-name ((t (:foreground ,tokiyuki))))
  `(diredfl-dir-priv ((t (:foreground ,tokiyuki))))
  `(diredfl-file-name ((t (:foreground ,text))))
  `(diredfl-file-suffix ((t (:foreground ,faint))))
  `(diredfl-symlink ((t (:foreground ,shizuku))))
  `(diredfl-number ((t (:foreground ,mima))))
  `(diredfl-date-time ((t (:foreground ,faint))))
  `(diredfl-deletion ((t (:foreground ,miko :weight bold))))
  `(diredfl-deletion-file-name ((t (:foreground ,miko :strike-through t))))
  `(diredfl-flag-mark ((t (:foreground ,ayako :weight bold :background ,overlay))))
  `(diredfl-flag-mark-line ((t (:background ,overlay))))
  `(diredfl-ignored-file-name ((t (:foreground ,muted))))
  `(diredfl-compressed-file-suffix ((t (:foreground ,shizuku))))
  `(diredfl-compressed-file-name ((t (:foreground ,text))))
  `(diredfl-executable-flag ((t (:foreground ,yorishige :weight bold))))
  `(diredfl-read-priv ((t (:foreground ,mima))))
  `(diredfl-write-priv ((t (:foreground ,mima))))
  `(diredfl-exec-priv ((t (:foreground ,yorishige))))
  `(diredfl-no-priv ((t (:foreground ,muted))))
  `(diredfl-rare-priv ((t (:foreground ,shizuku :weight bold))))
  `(diredfl-link-priv ((t (:foreground ,shizuku))))
  `(diredfl-autofile-name ((t (:foreground ,faint :slant italic))))
  `(diredfl-tagged-autofile-name ((t (:foreground ,ayako :slant italic))))

  ;; --- flycheck --------------------------------------------------------
  `(flycheck-error ((t (:underline (:style wave :color ,miko)))))
  `(flycheck-warning ((t (:underline (:style wave :color ,mima)))))
  `(flycheck-info ((t (:underline (:style wave :color ,tokiyuki)))))
  `(flycheck-fringe-error ((t (:foreground ,miko :weight bold))))
  `(flycheck-fringe-warning ((t (:foreground ,mima :weight bold))))
  `(flycheck-fringe-info ((t (:foreground ,tokiyuki :weight bold))))
  `(flycheck-error-list-error ((t (:foreground ,miko :weight bold))))
  `(flycheck-error-list-warning ((t (:foreground ,mima :weight bold))))
  `(flycheck-error-list-info ((t (:foreground ,tokiyuki))))

  ;; --- jinx ------------------------------------------------------------
  `(jinx-misspelled ((t (:foreground ,miko :underline (:style wave :color ,miko)))))
  `(jinx-highlight ((t (:foreground ,base :background ,mima))))

  ;; --- eldoc-box -------------------------------------------------------
  `(eldoc-box-body ((t (:background ,surface :foreground ,text))))
  `(eldoc-box-border ((t (:background ,muted))))

  ;; --- markdown-mode -------------------------------------------------
  `(markdown-header-face ((t (:foreground ,ayako :weight bold))))
  `(markdown-header-face-1 ((t (:foreground ,ayako :weight bold))))
  `(markdown-header-face-2 ((t (:foreground ,mima :weight bold))))
  `(markdown-header-face-3 ((t (:foreground ,yorishige :weight bold))))
  `(markdown-header-face-4 ((t (:foreground ,shizuku :weight bold))))
  `(markdown-header-face-5 ((t (:foreground ,tokiyuki :weight bold))))
  `(markdown-header-face-6 ((t (:foreground ,miko :weight bold))))
  `(markdown-header-delimiter-face ((t (:foreground ,muted))))
  `(markdown-link-face ((t (:foreground ,tokiyuki :underline t))))
  `(markdown-url-face ((t (:foreground ,tokiyuki :slant italic :underline t))))
  `(markdown-code-face ((t (:foreground ,yorishige))))
  `(markdown-inline-code-face ((t (:foreground ,yorishige))))
  `(markdown-blockquote-face ((t (:foreground ,faint :slant italic))))
  `(markdown-list-face ((t (:foreground ,mima))))
  `(markdown-bold-face ((t (:weight bold))))
  `(markdown-italic-face ((t (:slant italic))))
  `(markdown-strike-through-face ((t (:strike-through t :foreground ,muted))))
  `(markdown-markup-face ((t (:foreground ,muted))))

  ;; --- magit / transient -------------------------------------------------

  ;; sections / headers
  `(magit-section-heading ((t (:foreground ,ayako :weight bold))))
  `(magit-section-heading-selection ((t (:background ,overlay :foreground ,ayako :weight bold))))
  `(magit-section-highlight ((t (:background ,surface))))

  ;; popup / transient interface
  `(transient-heading ((t (:foreground ,ayako :weight bold))))
  `(transient-key ((t (:foreground ,tokiyuki :weight bold))))
  `(transient-argument ((t (:foreground ,yorishige))))
  `(transient-value ((t (:foreground ,mima))))
  `(transient-inactive-argument ((t (:foreground ,muted))))
  `(transient-inactive-value ((t (:foreground ,muted))))

  ;; branch / refs
  `(magit-branch-local ((t (:foreground ,yorishige :weight bold))))
  `(magit-branch-remote ((t (:foreground ,tokiyuki :weight bold))))
  `(magit-branch-current ((t (:foreground ,ayako :weight bold))))
  `(magit-branch-upstream ((t (:foreground ,mima))))
  `(magit-head ((t (:foreground ,ayako :weight bold))))

  `(magit-tag ((t (:foreground ,shizuku :weight bold))))

  ;; commit metadata
  `(magit-log-author ((t (:foreground ,text))))
  `(magit-log-date ((t (:foreground ,muted))))
  `(magit-log-graph ((t (:foreground ,faint))))
  `(magit-hash ((t (:foreground ,muted))))
  `(magit-reflog-commit ((t (:foreground ,yorishige))))
  `(magit-reflog-other ((t (:foreground ,tokiyuki))))

  ;; commit messages
  `(magit-diff-file-heading ((t (:foreground ,ayako :weight bold))))
  `(magit-diff-file-heading-highlight ((t (:background ,surface :foreground ,ayako :weight bold))))
  `(magit-diff-file-heading-selection ((t (:background ,overlay :foreground ,light :weight bold))))
  `(magit-diff-hunk-heading ((t (:background ,surface :foreground ,tokiyuki))))
  `(magit-diff-hunk-heading-highlight ((t (:background ,overlay :foreground ,ayako))))
  `(magit-diff-hunk-heading-selection ((t (:background ,overlay :foreground ,light))))

  ;; diff content
  `(magit-diff-context ((t (:foreground ,faint))))
  `(magit-diff-context-highlight ((t (:background ,surface :foreground ,text))))

  `(magit-diff-added ((t (:foreground ,yorishige))))
  `(magit-diff-added-highlight ((t (:background ,yorishige :foreground ,base))))

  `(magit-diff-removed ((t (:foreground ,miko))))
  `(magit-diff-removed-highlight ((t (:background ,miko :foreground ,light))))

  `(magit-diff-added-highlight ((t (:background ,yorishige :foreground ,base))))
  `(magit-diff-removed-highlight ((t (:background ,miko :foreground ,light))))

  `(magit-diff-whitespace-warning ((t (:background ,mima :foreground ,base))))

  ;; status buffer
  `(magit-diffstat-added ((t (:foreground ,yorishige))))
  `(magit-diffstat-removed ((t (:foreground ,miko))))
  `(magit-diffstat-neutral ((t (:foreground ,muted))))

  `(magit-status-heading ((t (:foreground ,ayako :weight bold))))
  `(magit-status-heading-key ((t (:foreground ,tokiyuki))))
  `(magit-status-untracked ((t (:foreground ,shizuku))))
  `(magit-status-ignored ((t (:foreground ,muted))))
  `(magit-status-modified ((t (:foreground ,mima))))
  `(magit-status-added ((t (:foreground ,yorishige))))
  `(magit-status-renamed ((t (:foreground ,tokiyuki))))
  `(magit-status-conflict ((t (:foreground ,miko :weight bold))))

  ;; process / errors
  `(magit-process-ok ((t (:foreground ,yorishige :weight bold))))
  `(magit-process-ng ((t (:foreground ,miko :weight bold))))

  ;; blame
  `(magit-blame-heading ((t (:background ,surface :foreground ,text))))
  `(magit-blame-highlight ((t (:background ,overlay))))
  `(magit-blame-date ((t (:foreground ,muted))))
  `(magit-blame-name ((t (:foreground ,ayako))))

  ;; --- corfu ----------------------------------------------------------
  `(corfu-default ((t (:background ,surface :foreground ,text))))
  `(corfu-current ((t (:background ,overlay :foreground ,ayako :weight bold))))
  `(corfu-bar ((t (:background ,high))))
  `(corfu-border ((t (:background ,muted))))
  `(corfu-annotations ((t (:foreground ,muted :slant italic))))
  `(corfu-deprecated ((t (:foreground ,muted :strike-through t))))

  ;; --- vertico / orderless ---------------------------------------------
  `(vertico-current ((t (:background ,overlay :foreground ,ayako :weight bold))))
  `(vertico-group-title ((t (:foreground ,faint :weight bold))))
  `(vertico-group-separator ((t (:foreground ,muted :strike-through t))))
  `(vertico-mkamakuraline ((t (:foreground ,muted))))
  `(orderless-match-face-0 ((t (:foreground ,ayako :weight bold))))
  `(orderless-match-face-1 ((t (:foreground ,tokiyuki :weight bold))))
  `(orderless-match-face-2 ((t (:foreground ,yorishige :weight bold))))
  `(orderless-match-face-3 ((t (:foreground ,shizuku :weight bold))))

  ;; --- dashboard -------------------------------------------------------
  `(dashboard-heading ((t (:foreground ,tokiyuki :weight bold))))
  `(dashboard-navigator ((t (:foreground ,shizuku :weight bold))))
  `(dashboard-items-face ((t (:foreground ,shizuku :weight bold))))
  `(dashboard-no-items-face ((t (:foreground ,muted :weight bold))))
  `(dashboard-footer-face ((t (:foreground ,faint :slant italic))))
  `(dashboard-text-banner ((t (:foreground ,tokiyuki))))
  `(dashboard-banner-logo-title ((t (:foreground ,text))))

  ;; --- vterm -----------------------------------------------------------
  `(vterm-color-black ((t (:foreground ,low :background ,low))))
  `(vterm-color-bright-black ((t (:foreground ,med :background ,med))))
  `(vterm-color-red ((t (:foreground ,miko :background ,miko))))
  `(vterm-color-bright-red ((t (:foreground ,taisha :background ,taisha))))
  `(vterm-color-green ((t (:foreground ,yorishige :background ,yorishige))))
  `(vterm-color-bright-green ((t (:foreground ,suwa :background ,suwa))))
  `(vterm-color-yellow ((t (:foreground ,mima :background ,mima))))
  `(vterm-color-bright-yellow ((t (:foreground ,sasaki :background ,sasaki))))
  `(vterm-color-blue ((t (:foreground ,tokiyuki :background ,tokiyuki))))
  `(vterm-color-bright-blue ((t (:foreground ,hojo :background ,hojo))))
  `(vterm-color-magenta ((t (:foreground ,ayako :background ,ayako))))
  `(vterm-color-bright-magenta ((t (:foreground ,mochizuki :background ,mochizuki))))
  `(vterm-color-cyan ((t (:foreground ,shizuku :background ,shizuku))))
  `(vterm-color-bright-cyan ((t (:foreground ,kami :background ,kami))))
  `(vterm-color-white ((t (:foreground ,text :background ,text))))
  `(vterm-color-bright-white ((t (:foreground ,light :background ,light))))
  `(vterm-color-underline ((t (:foreground ,shizuku))))
  `(vterm-color-inverse-video ((t (:background ,base :inverse-video t))))
  ))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'kamakura)

;;; --- automated exports -------------------------------------------------

(defun kamakura/render-template (template-file output-file &optional strip-hash)
  "Inject 'palette' values into TEMPLATE-FILE and write to extras/OUTPUT-FILE.
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
    ("templates/vim.vim" "extras/vim/colors/kamakura.vim")
    ("templates/X11.Xresources" "extras/X11/kamakura.Xresources")
    ("templates/zathura" "extras/zathura/kamakura")
    ))

(defun kamakura/export-all ()
  "Render every template in `export-targets' against `palette'.
Callable interactively after `load-theme`, or headless via:
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
