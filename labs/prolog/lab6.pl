

Задание: 
1. Постройте деревья вызова для запросов:
?- предок_потомок(алексей, катя). %% family.pl
?- my_append(List1, List2, [a,b]). %% lists.pl

% 2. Задайте предикат stutter(List, DoubledList), успешный, если DoubledList содержит те же элементы, 
%   что List, но по два раза подряд. Проверьте поведение, если переменные на других местах.
%   ?- stutter([a,b,c], X) => X = [a,a,b,b,c,c]. 

list([]).
list([_|T]) :- list(T).
    
stutter([], []).
stutter([H|T], [H,H|DoubledT]) :- stutter(T, DoubledT).

% 3. Задайте предикат remove_duplicates(List, ListWithoutDuplicates), успешный, если ListWithoutDuplicates 
%    содержит те же элементы, что List, в том же порядке, но с удалением всех повторений. Проверьте поведение, 
%    если переменные на других местах.
%    ?- remove_duplicates([a,b,a,b,c,c,a], X) => X = [a,b,c]

remove_all(_, [], []).
remove_all(X, [X|T], T1) :-
    remove_all(X, T, T1).
remove_all(X, [H|T], [H|T1]) :-
    X \= H,
    remove_all(X, T, T1).


remove_duplicates([], []).
remove_duplicates([H|T], [H|T1]) :-
  remove_all(H, T, T2),
  remove_duplicates(T2, T1).
remove_duplicates([H|T], [H|T1]) :-
  not(member(H, T)),
  remove_duplicates(T, T1).


% 4. Определите предикат my_flatten(NestedList, FlattenedList), "расплющивающий" вложенный список NestedList.
%   ?- my_flatten([a, [[b], c], [[d]]], X). => X = [a, b, c, d]

list([]).
list([H|T]) :- list(T).

my_append([], List, List).
my_append([H|T1], List2, [H|TResult]) :- my_append(T1, List2, TResult).

my_flatten([], []).
my_flatten([H|T], FlatList) :-
  is_list(H),
  my_flatten(H, HFlat),
  my_flatten(T, TFlat),
  my_append(HFlat, TFlat, FlatList).
my_flatten([H|T], [H|TFlat]) :-
  not(is_list(H)),
  my_flatten(T, TFlat).



add_prefix(_, [], []).
add_prefix(Prefix, [H|T], [[Prefix|H]|T1]) :-
    add_prefix(Prefix, T, T1).

gray([0], [[0], [1]]).
gray(L, Code) :-
    length(L, N),
    N > 1,
    reverse(L, RevL),
    gray(L, Gray1),
    gray(RevL, Gray2),
    add_prefix(0, Gray1, Gray1_0),
    add_prefix(1, Gray2, Gray2_1),
    append(Gray1_0, Gray2_1, Code).




add_element_to_lists(_, [], []).
add_element_to_lists(X, [H|T], [[X|H]|T1]) :-
  is_list(H),
  add_element_to_lists(X, T, T1).
add_element_to_lists(X, [H|T], [H|T1]) :-
  not(is_list(H)),
  add_element_to_lists(X, T, T1).

gray([], []).
gray([_], [[0],[1]]).
gray([_|T], Code):-
    gray(T, C),
	add_element_to_lists(0, C, Code0),
    add_element_to_lists(1, C, Code1),
    append(Code0, Code1, Code).