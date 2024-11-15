(defun add-next-fn (&key transform)
  (let ((prev-element nil))
    (lambda (current)
      (if (null prev-element)
          (setf prev-element (cons (if transform (funcall transform current) current) nil))
          (progn
            (setf (cdr prev-element) (if transform (funcall transform current) current))
            (setf current (cons (cdr prev-element) nil))
            (setf prev-element current)))))) 

(defun check-pair-elements-with-mapcar (name input expected &key transform)
  "Execute  add-next-fn on input, compare result with expected and print comparison status"
  (let ((result (mapcar (add-next-fn :transform transform) input))) 
    (format t "~:[~a failed! Expected: ~a Obtained: ~a~;~a passed! Expected: ~a Obtained: ~a~]~%"
            (equal result expected)
            name expected result)))


(defun test-pair-elements-with-mapcar ()
  (format t "Start testing add-next-fn function~%")
  (check-pair-elements-with-mapcar "Сalling a function without a transform" '(1 2 3) '((1 . 2) (2 . 3) (3 . NIL)))
  (check-pair-elements-with-mapcar "Сalling a function with transform 1+" '(1 2 3) '((2 . 3) (3 . 4) (4 . NIL)) :transform #'1+)
  (check-pair-elements-with-mapcar "Сalling a function with transform 5+"  '(1 5 10 15) '((6 . 10) (10 . 15) (15 . 20) (20))  :transform (lambda (x) (+ x 5)))
  (check-pair-elements-with-mapcar "Сalling a function with transform sqrt"  '(9 16 25) '((3 . 4) (4 . 5) (5)) :transform #'sqrt)
  (format t "EnD~%"))


(test-pair-elements-with-mapcar)
