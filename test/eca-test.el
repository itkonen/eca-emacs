;;; eca-test.el --- Tests for eca -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'buttercup)
(require 'eca)

(describe "eca-new-workspace"
  (it "creates a fresh session for selected workspaces"
    (let ((eca--sessions nil)
          (eca--session-ids 0))
      (spy-on 'eca--discover-workspaces
              :and-return-value '("/tmp/eca-project/"))
      (spy-on 'eca--start-or-open-session :and-return-value nil)
      (with-temp-buffer
        (eca-new-workspace)
        (let ((session (cdr (car eca--sessions))))
          (expect (length eca--sessions) :to-equal 1)
          (expect (eca--session-workspace-folders session)
                  :to-equal '("/tmp/eca-project/"))
          (expect eca--session-id-cache :to-equal (eca--session-id session))
          (expect 'eca--start-or-open-session
                  :to-have-been-called-with session))))))

(provide 'eca-test)
;;; eca-test.el ends here
