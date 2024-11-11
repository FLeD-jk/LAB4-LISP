(defun add-next-fn (&key transform)
  (lambda (current next)
    (let ((current-value (if transform (funcall transform current) current))
          (next-value (if (and next transform) (funcall transform next) next)))
      (cons current-value next-value))))

;; Викликаємо функцію безпосередньо з mapcar
(defun pair-elements (lst &key transform)
  (mapcar (add-next-fn :transform transform)
          lst
          (append (cdr lst) (list nil))))

;; Тестування
(print (mapcar (add-next-fn) '(1 2 3) (append (cdr '(1 2 3)) (list nil))))
;; => ((1 . 2) (2 . 3) (3 . NIL))

(print (mapcar (add-next-fn :transform #'1+) '(1 2 3) (append (cdr '(1 2 3)) (list nil))))
;; => ((2 . 3) (3 . 4) (4 . NIL))
