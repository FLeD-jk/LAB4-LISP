(defun add-next-fn (&key transform)
  (lambda (current next)
    (let ((current-value (if transform (funcall transform current) current))
          (next-value (if (and next transform) (funcall transform next) next)))
      (cons current-value next-value))))

(defun pair-elements-with-mapcar (lst &key transform)
  (mapcar (add-next-fn :transform transform)
          lst
          (append (cdr lst) (list nil)))) ; Додаємо NIL до кінця списку

;; Приклад використання
(print (pair-elements-with-mapcar '(1 2 3)))
;; => ((1 . 2) (2 . 3) (3 . NIL))

(print (pair-elements-with-mapcar '(1 2 3) :transform #'1+))
;; => ((2 . 3) (3 . 4) (4 . NIL))

(print (pair-elements-with-mapcar '(9 16 25) :transform #'sqrt))
;; => ((2 . 3) (3 . 4) (4 . NIL))
