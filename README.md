<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Конструктивний і деструктивний підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студентка</b>: Нестерук Анастасія Олександрівна КВ-11</p>
<p align="right"><b>Рік</b>: 2024</p>

## Загальне завдання
1. Переписати функціональну реалізацію алгоритму сортування з лабораторної
роботи 3 з такими змінами:
використати функції вищого порядку для роботи з послідовностями (де це
доречно);
додати до інтерфейсу функції (та використання в реалізації) два ключових
параметра: key та test , що працюють аналогічно до того, як працюють
параметри з такими назвами в функціях, що працюють з послідовностями. При
цьому key має виконатись мінімальну кількість разів.
2. Реалізувати функцію, що створює замикання, яке працює згідно із завданням за
варіантом (див. п 4.1.2). Використання псевдо-функцій не забороняється, але, за
можливості, має бути мінімізоване.

## Варіант першої частини - 7
Алгоритм сортування Шелла за незменшенням.
## Лістинг реалізації першої частини завдання
```lisp
 (defun shell-sorting (lst n gap i key test)
           (if (>= gap 1)
               (if (< i n)
                   (let ((j i))
                     (if (and (>= j gap)
                              (funcall test (funcall key (nth j lst))
                                       (funcall key (nth (- j gap) lst))))
                         (progn
                           (rotatef (nth j lst) (nth (- j gap) lst))
                           (shell-sorting lst n gap (- j gap) key test))
                         (shell-sorting lst n gap (+ i 1) key test)))
                   (shell-sorting lst n (floor (/ gap 2)) 0 key test))
               lst))
(defun shell-sorting-functional (lst &key (key #'identity) (test #'<))
  (let ((n (length lst)))
    (shell-sorting lst n (floor (/ n 2)) 0 key test)))
```

### Тестові набори та утиліти першої частини
```lisp
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
```
### Тестування першої частини
```lisp
CL-USER> (test-shell-sorting-functional)
Start testing shell-sorting-functional function
test 1 without key passed! Expected: (0 2 23 32 32 34 44 65 76 120 346) Obtained: (0 2 23 32 32 34 44 65 76 120 346)
test 2 without key passed! Expected: (-1 0 0 1 1 1 1 2 21 34 56 78 90 6751) Obtained: (-1 0 0 1 1 1 1 2 21 34 56 78 90 6751)
test 3 without key passed! Expected: (2 3 4 9 34) Obtained: (2 3 4 9 34)
test 4 with key - abs passed! Expected: (-1 1 -2 3 3 -4 -5 -5 -5 6 9) Obtained: (-1 1 -2 3 3 -4 -5 -5 -5 6 9)
test 5 with key - abs and test - > passed! Expected: (9 6 -5 -5 -5 -4 3 3 -2 -1 1) Obtained: (9 6 -5 -5 -5 -4 3 3 -2 -1 1)
test 6 with key - abs and test - < passed! Expected: (-1 1 -2 3 3 -4 -5 -5 -5 6 9) Obtained: (-1 1 -2 3 3 -4 -5 -5 -5 6 9)
test 7 with key - car passed! Expected: ((1 . 2) (2 . 3) (3 . 1) (4 . 5)) Obtained: ((1 . 2) (2 . 3) (3 . 1) (4 . 5))
test 8 with key - cdr passed! Expected: ((3 . 1) (1 . 2) (2 . 3) (4 . 5)) Obtained: ((3 . 1) (1 . 2) (2 . 3) (4 . 5))
EnD
```
## Варіант другої частини - 3
Написати функцію add-next-fn , яка має один ключовий параметр — функцію
transform . add-next-fn має повернути функцію, яка при застосуванні в якості
першого аргументу mapcar разом з одним списком-аргументом робить наступне: кожен
елемент списку перетворюється на точкову пару, де в комірці CAR знаходиться значення
поточного елемента, а в комірці CDR знаходиться значення наступного елемента списку.
Якщо функція transform передана, тоді значення поточного і наступного елементів, що
потраплять у результат, мають бути змінені згідно transform . transform має
виконатись мінімальну кількість разів.
```lisp
CL-USER> (mapcar (add-next-fn) '(1 2 3))
((1 . 2) (2 . 3) (3 . NIL))
CL-USER> (mapcar (add-next-fn :transform #'1+) '(1 2 3))
((2 . 3) (3 . 4) (4 . NIL))
```

## Лістинг реалізації другої частини завдання
```lisp
(Defun Add-Next-Fn (&Key Transform)
  (Lambda (Current Next)
    (Let ((Current-Value (If Transform (Funcall Transform Current) current))
          (next-value (if (and next transform) (funcall transform next) next)))
      (cons current-value next-value))))

(defun pair-elements-with-mapcar (lst &key transform)
  (mapcar (add-next-fn :transform transform)
          lst
          (append (cdr lst) (list nil)))) 
```
### Тестові набори та утиліти другої частини 
```lisp
(defun check-pair-elements-with-mapcar (name input expected &key transform)
  "Execute shell-sorting-functional on input, compare result with expected and print comparison status"
  (let ((result (pair-elements-with-mapcar input :transform transform)))
    (format t "~:[~a failed! Expected: ~a Obtained: ~a~;~a passed! Expected: ~a Obtained: ~a~]~%"
            (equal result expected)
            name expected result)))


(defun test-pair-elements-with-mapcar ()
  (format t "Start testing shell-sorting-functional function~%")
  (check-pair-elements-with-mapcar "Сalling a function without a transform" '(1 2 3) '((1 . 2) (2 . 3) (3 . NIL)))
  (check-pair-elements-with-mapcar "Сalling a function with transform 1+" '(1 2 3) '((2 . 3) (3 . 4) (4 . NIL)) :transform #'1+)
  (check-pair-elements-with-mapcar "Сalling a function with transform 5+"  '(1 5 10 15) '((6 . 10) (10 . 15) (15 . 20) (20))  :transform (lambda (x) (+ x 5)))
  (check-pair-elements-with-mapcar "Сalling a function with transform sqrt"  '(9 16 25) '((3 . 4) (4 . 5) (5)) :transform #'sqrt)
  (format t "EnD~%"))
```
### Тестування другої частини 
```lisp
CL-USER> (test-pair-elements-with-mapcar)
Start testing shell-sorting-functional function
Сalling a function without a transform passed! Expected: ((1 . 2) (2 . 3) (3)) Obtained: ((1 . 2) (2 . 3) (3))
Сalling a function with transform 1+ passed! Expected: ((2 . 3) (3 . 4) (4)) Obtained: ((2 . 3) (3 . 4) (4))
Сalling a function with transform 5+ passed! Expected: ((6 . 10) (10 . 15) (15 . 20) (20)) Obtained: ((6 . 10) (10 . 15) (15 . 20) (20))
Сalling a function with transform sqrt passed! Expected: ((3 . 4) (4 . 5) (5)) Obtained: ((3 . 4) (4 . 5) (5))
EnD
```
