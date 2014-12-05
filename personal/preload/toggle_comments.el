;;; toggle-comment --- Toggle the selected region as commented or not.
;;; Commentary:
;;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html

;;; Code:
(defun toggle-comment-region (&optional arg)
  "Replacement for the 'comment-dwim' command.
ARG: The number of comment character to use in the comment.
If no region is selected and current line is not blank and we are not
at the end of the line,then comment current line.
Replaces default behavior of 'comment-dwim', when it inserts
comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-unset-key (kbd "C-x /"))
(global-set-key (kbd "C-x /") 'toggle-comment-region)
;;; toggle-comment.el ends here
