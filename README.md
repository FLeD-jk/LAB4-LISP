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
                     (funcall test (funcall key (nth (- j gap) lst)) 
                              (funcall key (nth j lst))))
                (progn
                  (rotatef (nth j lst) (nth (- j gap) lst))
                  (shell-sorting lst n gap (- j gap) key test))
                (shell-sorting lst n gap (+ i 1) key test)))
          (shell-sorting lst n (floor (/ gap 2)) 0 key test))
      lst))

(defun shell-sorting-functional (lst &key (key #'identity) (test #'>))
  (let ((n (length lst)))
    (shell-sorting lst n (floor (/ n 2)) 0 key test)))
```

### Тестові набори та утиліти першої частини
```lisp
(defun check-shell-sorting-functional (name input expected &key (key #'identity) (test #'>) )
  "Execute shell-sorting-functional on input, compare result with expected and print comparison status"
  (let ((result (shell-sorting-functional input :key key :test test))) 
    (format t "~:[~a failed! Expected: ~a Obtained: ~a~;~a passed! Expected: ~a Obtained: ~a~]~%"
            (equal result expected)
            name expected result)))


(defun test-shell-sorting-functional ()
  (format t "Start testing shell-sorting-functional function~%")
  (check-shell-sorting-functional "test 1" '(346 23 0 32 44 76 2 120 34  32 65) '(0 2 23 32 32 34 44 65 76 120 346))
  (check-shell-sorting-functional "test 2" '(0 0 2 56 78 21 34 90 6751 1 1 1 -1 1) '(-1 0 0 1 1 1 1 2 21 34 56 78 90 6751))
  (check-shell-sorting-functional "test 3" '(3 4 2 9 34) '(2 3 4 9 34))
    
  (format t "EnD~%"))
```
### Тестування першої частини
```lisp
<Виклик і результат виконання тестів>
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

## Лістинг функції з використанням деструктивного підходу
```lisp
<Лістинг реалізації з використанням деструктивного підходу>
```
### Тестові набори та утиліти
```lisp
<Лістинг реалізації утилітних тестових функцій та тестових наборів>
```
### Тестування
```lisp
<Виклик і результат виконання тестів>
```
