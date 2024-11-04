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
<!-- Зазначається алгоритм сортування за варіантом -->
## Лістинг реалізації першої частини завдання
```lisp
<Лістинг реалізації>
```
### Тестові набори та утиліти першої частини
```lisp
<Лістинг реалізації утилітних тестових функцій та тестових наборів>
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
