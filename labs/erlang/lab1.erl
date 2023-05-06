-module(lab1).
-import(math, [sqrt/1]).
-compile(export_all).

pow2(A) -> A*A.

distance(P1, P2) ->  
    if element(1, P1) > element(1, P2) -> 
        A =  pow2(element(1, P1) - element(1, P2));
        true ->
            A = pow2(element(1, P2) - element(1, P1))
    end,
    if element(2, P1) > element(2, P2) -> 
        B = pow2(element(2, P1) - element(2, P2)); 
        true -> 
            B = pow2(element(2, P2) - element(2, P1))
    end,
    math:sqrt(A + B).

insert([Head | List], X) ->
    if  Head >= X ->
        [X, Head] ++ List;
    true -> [Head] ++ insert(List, X)
    end.

len([]) -> 0;
len([Head | List]) -> 1 + len(List).

drop_every([Head | List], N, Count) when Count == length([Head | List]) -> [Head | List];
drop_every([Head | List], N, Count) when Count < length([Head | List]) ->
    if 
        Count == N -> drop_every(List, N, 1);
    true -> [Head] ++ drop_every(List, N, Count + 1)
    end.

drop_every(List, N) -> drop_every(List, N, 1).

getCharList({Char, 1}) -> [Char];
getCharList({Char, Count}) -> [Char] ++ getCharList({Char, Count - 1}).

rle_decode([]) -> [];
rle_decode([Head | List]) when is_tuple(Head) -> getCharList(Head) ++ rle_decode(List);
rle_decode([Head | List]) -> [Head] ++ rle_decode(List).

getNumber([Head |List], N, Count) when Count == N -> Head;
getNumber([Head |List], N, Count) -> getNumber(List, N, Count + 1).

getNumber([Head | List], 1) -> Head;
getNumber([Head | List], N) -> getNumber(List, N, 2).


diagonal(Matrix) -> diagonal(Matrix, 1).
diagonal([], Count) -> [];
diagonal([Head | List], Count) -> [getNumber(Head, Count)] ++ diagonal(List, Count + 1).


char_intersect(Char, []) -> [];
char_intersect(Char, [Head | List]) ->
    if Char == Head -> [Char] ++ char_intersect(Char, List);
    true -> char_intersect(Char, List)
    end.

intersect([], List2) -> [];
intersect([HeadL1 | List1], List2) -> char_intersect(HeadL1, List2) ++ intersect(List1,List2).

is_date(1, 1, 2000) -> 6;
is_date(DayOfMonth, MonthOfYear, Year) -> 
    if 
        Year /= 2000 -> 
            if ((Year rem 4 == 0) and (Year rem 100 /= 0)) or (Year rem 400 == 0) ->
                (is_date(DayOfMonth, MonthOfYear, Year - 1) + 366) rem 7;
            true -> (is_date(DayOfMonth, MonthOfYear, Year - 1) + 365) rem 7
            end;
        MonthOfYear /= 1 -> 
            if
                MonthOfYear == 3 -> (is_date(DayOfMonth, MonthOfYear - 1, Year) + 29) rem 7;
                MonthOfYear == 9 -> (is_date(DayOfMonth, MonthOfYear - 1, Year) + 31) rem 7;
                MonthOfYear rem 2 == 0 -> (is_date(DayOfMonth, MonthOfYear - 1, Year) + 31) rem 7;
                true -> (is_date(DayOfMonth, MonthOfYear - 1, Year) + 30) rem 7
            end;
        true ->  (is_date(1, MonthOfYear, Year) + DayOfMonth - 1) rem 7
    end.
        