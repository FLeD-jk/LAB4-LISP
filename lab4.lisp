(defun shell-sorting (lst n gap i key test)
  (let ((new-lst (copy-list lst))) 
    (if (>= gap 1)
        (if (< i n)
            (let ((j i))
              (if (and (>= j gap)
                       (funcall test (funcall key (nth j new-lst))
                                (funcall key (nth (- j gap) new-lst))))
                  (progn
                    (rotatef (nth j new-lst) (nth (- j gap) new-lst))
                    (shell-sorting new-lst n gap (- j gap) key test))
                  (shell-sorting new-lst n gap (+ i 1) key test)))
            (shell-sorting new-lst n (floor (/ gap 2)) 0 key test))
        new-lst)))
(defun shell-sorting-functional (lst &key (key #'identity) (test #'<))
  (let ((n (length lst)))
    (shell-sorting lst n (floor (/ n 2)) 0 key test)))

(defun check-shell-sorting-functional (name input expected &key (key #'identity) (test #'<) )
  "Execute shell-sorting-functional on input, compare result with expected and print comparison status"
  (let ((result (shell-sorting-functional input :key key :test test))) 
    (format t "~:[~a failed! Expected: ~a Obtained: ~a~;~a passed! Expected: ~a Obtained: ~a~]~%"
            (equal result expected)
            name expected result)))


(defun test-shell-sorting-functional ()
  (format t "Start testing shell-sorting-functional function~%")
  (check-shell-sorting-functional "test 1 without key" '(346 23 0 32 44 76 2 120 34  32 65) '(0 2 23 32 32 34 44 65 76 120 346))
  (check-shell-sorting-functional "test 2 without key" '(0 0 2 56 78 21 34 90 6751 1 1 1 -1 1) '(-1 0 0 1 1 1 1 2 21 34 56 78 90 6751))
  (check-shell-sorting-functional "test 3 without key" '(3 4 2 9 34) '(2 3 4 9 34))
  (check-shell-sorting-functional "test 4 with key - abs" '(3 -1 -4 1 -5 9 -2 6 -5 3 -5) '(-1 1 -2 3 3 -4 -5 -5 -5 6 9) :key #'abs)
  (check-shell-sorting-functional "test 5 with key - abs and test - >" '(3 -1 -4 1 -5 9 -2 6 -5 3 -5) '(9 6 -5 -5 -5 -4 3 3 -2 -1 1) :key #'abs :test #'>)
  (check-shell-sorting-functional "test 6 with key - abs and test - <" '(3 -1 -4 1 -5 9 -2 6 -5 3 -5) '(-1 1 -2 3 3 -4 -5 -5 -5 6 9) :key #'abs :test #'<)
  
  (check-shell-sorting-functional"test 7 with key - car"  '((2 . 3) (1 . 2) (4 . 5) (3 . 1))
                                  '((1 . 2) (2 . 3) (3 . 1) (4 . 5))                    
                                  :key #'car)
  (check-shell-sorting-functional "test 8 with key - cdr"  '((2 . 3) (1 . 2) (4 . 5) (3 . 1))
                                  '((3 . 1) (1 . 2) (2 . 3) (4 . 5))
                                  :key #'cdr)
  (format t "EnD~%"))

(test-shell-sorting-functional)
