% Предикат length_custom - определение длины списка
% length_custom(List, Length)
% List - список
% Length - длина списка

length_custom([], 0).
length_custom([_|T], N) :-
    length_custom(T, N1),
    N is N1 + 1.


% Предикат member_custom - проверка принадлежности элемента списку
% member_custom(Element, List)
% Element - элемент
% List - список

member_custom(X, [X|_]).
member_custom(X, [_|T]) :-
    member_custom(X, T).


% Предикат append_custom - объединение двух списков
% append_custom(List1, List2, Result)
% List1 - первый список
% List2 - второй список
% Result - результат объединения

append_custom([], List, List).
append_custom([H|T], List, [H|Result]) :-
    append_custom(T, List, Result).


% Предикат remove_custom - удаление элемента из списка
% remove_custom(Element, List, Result)
% Element - элемент для удаления
% List - исходный список
% Result - результат с удаленным элементом

remove_custom(_, [], []).
remove_custom(X, [X|T], Result) :-
    remove_custom(X, T, Result).
remove_custom(X, [H|T], [H|Result]) :-
    X \= H,
    remove_custom(X, T, Result).


% Предикат permute_custom - генерация всех перестановок списка
% permute_custom(List, Result)
% List - исходный список
% Result - результат с перестановками

permute_custom([], []).
permute_custom(List, [X|Perm]) :-
    select_custom(X, List, Rest),
    permute_custom(Rest, Perm).


% Предикат sublist_custom - проверка, является ли список подсписком другого списка
% sublist_custom(Sublist, List)
% Sublist - подсписок
% List - список

sublist_custom(Sublist, List) :-
    append_custom(_, Rest, List),
    append_custom(Sublist, _, Rest).


% Предикат для вставки элемента в список на указанную позицию (с использованием стандартных предикатов)
% insert_element_custom1(Element, Position, List, NewList)
% Element - элемент для вставки
% Position - позиция для вставки (начинается с 1)
% List - исходный список
% NewList - результирующий список с вставленным элементом

insert_element_custom1(Element, Position, List, NewList) :-
    length_custom(List, Length),
    Position > 0,
    Position =< Length + 1,
    append_custom(Prefix, Suffix, List),
    length_custom(Prefix, PositionMinusOne), % Длина префикса
    PositionMinusOne =:= Position - 1,
    append_custom(Prefix, [Element|Suffix], NewList).


% Предикат для вставки элемента в список на указанную позицию (без использования стандартных предикатов)
% insert_element_custom2(Element, Position, List, NewList)
% Element - элемент для вставки
% Position - позиция для вставки (начинается с 1)
% List - исходный список
% NewList - результирующий список с вставленным элементом

insert_element_custom2(Element, 1, List, [Element|List]).
insert_element_custom2(Element, Position, [Head|Tail], [Head|NewTail]) :-
    Position > 1,
    NextPosition is Position - 1,
    insert_element_custom2(Element, NextPosition, Tail, NewTail).


% Предикат для проверки списка на геометрическую прогрессию (с использованием стандартных предикатов как member_custom и sublist_custom)
% geometric_progression_custom(List)
% List - список чисел

geometric_progression_custom([]).
geometric_progression_custom([_]).
geometric_progression_custom([X,Y|T]) :-
    Y =:= X * 2,
    geometric_progression_custom([Y|T]).