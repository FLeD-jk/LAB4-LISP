(defun add-next-fn (&key transform)
  (lambda (lst)
    (let ((shifted-lst (append (cdr lst) (list nil))))
      (mapcar (lambda (current next)
                (let ((current-value (if transform (funcall transform current) current))
                      (next-value (if (and next transform) (funcall transform next) next)))
                  (cons current-value next-value)))
              lst
              shifted-lst))))

(print (funcall (add-next-fn) '(1 2 3)))
;; => ((1 . 2) (2 . 3) (3 . NIL))

(print (funcall (add-next-fn :transform #'1+) '(1 2 3)))
;; => ((2 . 3) (3 . 4) (4 . NIL))

(print (funcall (add-next-fn :transform #'sqrt) '(9 16 25)))
;; => ((3 . 4) (4 . 5) (5 . NIL))
