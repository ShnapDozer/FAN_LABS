-module(lab2).
-compile(export_all).

list_length([]) -> 0;
list_length([Head | List]) -> 1 + list_length(List).

list_lengths([]) -> [0];
list_lengths([[] | List]) -> list_lengths(List);
list_lengths([Head | List]) when is_list(Head) -> [list_length(Head)] ++ list_lengths(List);
list_lengths([Head | List]) -> list_lengths(List).


all(Pred, []) -> true;
all(Pred, [Head | List]) -> 
    case Pred(Head) of
        true  -> all(Pred, List);
        false -> false
    end.

min_value(F, 1, Min) -> 
    case F(1) < Min of
         true -> F(1);
         false -> Min
    end;
min_value(F, N, Min) -> 
    case F(N) < Min of
        true -> min_value(F, N - 1, F(N));
        false -> min_value(F, N - 1, Min)
    end.
min_value(F, N) -> min_value(F, N-1, F(N)).

group_by(Fun, [X | List], SubList, AnsList) when List == [] -> [SubList | AnsList] ;
group_by(Fun, [X | List], SubList, AnsList) ->
    [Y | Tail] = List,
    case Fun(X, Y) of
         true ->   
            if 
                SubList == [] -> group_by(Fun, List, [X,Y], AnsList);
                true -> group_by(Fun, List, SubList ++ [Y], AnsList)
            end;
         false -> 
            if 
                SubList == [] ->  group_by(Fun, List, [], [AnsList]);
                true -> group_by(Fun, List, [], [SubList | AnsList])
            end
    end.
group_by(Fun, [X | List]) -> 
    [Y | Tail] = List,
    case Fun(X, Y) of
         true -> group_by(Fun, List, [X, Y], []);
         false -> group_by(Fun, List, [], [])
    end.


for(I, Cond, Step, Body) ->
    case Cond(I) of 
        true -> Body(I),
            for(Step(I), Cond, Step, Body);
        false -> true
    end.

getElement(Index, [X | List], Pos) when pos > Index -> false;
getElement(Index, [X | List], Pos) ->
    if 
        Index == Pos -> X;
        true -> getElement(Index, List, Pos + 1)
    end.
getElement(0, [X | List]) -> X;
getElement(Index, [X | List]) -> getElement(Index, List, 1).

compare(A, B) ->
  if
    A > B -> true;
    A =< B -> false
  end.

% lab2:sortBy(fun(A,B) -> A > B end, [1,3,6,2,6]).

sortBy(Comparator, List) ->
    sortBy(Comparator, List, length(List)).

sortBy(_, [], 0) ->
    [];
sortBy(Comparator, List, N) ->
    sortBy(Comparator, bubble_pass(Comparator, List), N - 1).

bubble_pass(Comparator, [A, B | Tail]) ->
    case Comparator(A, B) of
        true -> [B | bubble_pass(Comparator, [A | Tail])];
        false -> [A | bubble_pass(Comparator, [B | Tail])]
    end;
bubble_pass(_, List) ->
    List.


