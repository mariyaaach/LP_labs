% import data
:- ['one.pl'].

/*
Вариант 1
1) Получить таблицу групп и средний балл по каждой из групп
2) Для каждого предмета получить список студентов, не сдавших экзамен (grade=2)
3) Найти количество не сдавших студентов в каждой из групп
*/

% Предикат для вычисления суммы списка чисел
sum([], 0).
sum([X|Y], S) :-
    sum(Y, Q),
    S is Q + X.

% Предикат для вычисления среднего значения списка чисел
average(X, T) :-
    length(X, L),
    sum(X, P),
    T is P / L.

% Предикат для вычисления среднего балла студента
student_average(Student, R) :-
    findall(N, grade(Student, _, N), List),
    average(List, R).

% Предикат для вычисления среднего балла студентов в группе
students_average_in_group(Group, R) :-
    student(Group, Student),
    student_average(Student, R).

% Предикат для вывода среднего балла каждой группы
print_group_average() :-
    findall(Group, student(Group, _), Glist),
    sort(Glist, List),
    member(Group2, List),
    setof(R, students_average_in_group(Group2, R), ListValue),
    average(ListValue, Answer),
    write('Группа №'), write(Group2), write(' Средний балл: '), write(Answer), write('\n'), fail.

% Предикат для вывода списка студентов, не сдавших экзамен по каждому предмету
failed_exam() :-
    subject(X, S),
    findall(N, grade(N, X, 2), L),
    write(S), write(' не сдали: '), write(L), write('\n'), fail.

% Предикат для проверки, не сдал ли студент экзамен
failed_student(Name, Group) :-
    student(Group, Name),
    grade(Name, _, 2).

% Предикат для подсчета количества студентов, не сдавших в группе
failed_in_group(Group, N) :-
    setof(X, failed_student(X, Group), L),
    length(L, N).

% Предикат для вывода количества студентов, не сдавших в каждой группе
number_failed() :-
    findall(X, student(X, _), Glist),
    sort(Glist, List),
    member(Group, List),
    failed_in_group(Group, N),
    write('Группа: №'), write(Group), write(' Не сдали: '), write(N), write('\n'), fail.