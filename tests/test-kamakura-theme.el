;;; test-kamakura-theme.el --- tiny test suite -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'ert)

(ert-deftest check-for-unresolved-curly-brackets ()
  "Check that no file in extras/ contains {{ or }}."
  (let* ((extras-dir (expand-file-name "extras" (locate-dominating-file default-directory "extras")))
         (files (directory-files-recursively extras-dir "\\..*")))
    (dolist (file files)
      (ert-info ((format "Checking file: %s" file))
        (with-temp-buffer
          (insert-file-contents file)
          (goto-char (point-min))
          (should-not (re-search-forward "{{\\|}}" nil t)))))))

(provide 'test-kamakura-theme.el)
;;; test-kamakura-theme.el ends here
