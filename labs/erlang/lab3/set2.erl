-module(set2).
-compile(export_all).

% -type set() :: {_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _}.

-type set() :: {integer(), 
    {
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty
    }}.

-spec make() -> set().
-spec has(set(), any()) -> boolean().
-spec add(set(), any()) -> set().
-spec clear(set()) -> set().
-spec delete(set(), any()) -> set().
-spec is_subset(set(), set()) -> boolean().

make() -> {0, 
    {
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty,
        empty, empty, empty, empty, empty
    }}.


has_item(Set, Item, Current) ->
    {Count, Tuple} = Set,
    Elem = element(Current, Tuple),
    if
        Item == Elem -> true;
        Current == Count -> false;
        true -> has_item(Set, Item, Current + 1)
    end.


has(Set, Item) ->
    {Count, Tuple} = Set,
    if
        Count == 0 -> false;
        true -> has_item(Set, Item, 1)
    end. 

add(Set, Item) ->
    {Count, Tuple} = Set,
    Has = has(Set, Item),
    if
        Has -> Set;
        Count == 50 -> Set;
        true -> {Count + 1, setelement(Count + 1, Tuple, Item)}
    end.

clear(Set) -> make().


copy_without_item(Set, Item, Res, Current) when Current > 50 -> Res;
copy_without_item(Set, Item, Res, Current) when Current =< 50->
    {Count, Tuple} = Set,
    {CountRes, TupleRes} = Res,
    Elem = element(Current, Tuple),
    if
        Elem == empty -> Res;
        Item /= Elem -> copy_without_item(Set, Item, add(Res, Elem), Current + 1);
        Item == Elem -> copy_without_item(Set, Item, Res, Current + 1)
    end.
    

delete(Set, Item) -> 
    A = make(),
    Has = has(Set, Item),
    if
        Has == false -> Set;
        true -> copy_without_item(Set, Item, A, 1)
    end.

check(Set1, Set2, Current) ->
    {C1, T1} = Set1,
    % {C2, T2} = Set2,
    Elem = element(Current, T1),
    Has = has(Set2, Elem),
    if
        Elem == empty -> true;
        Has -> check(Set1, Set2, Current + 1);
        true -> false
    end.

is_subset(Set1, Set2) ->
    {Count, Tuple} = Set1,
    if
        Count == 0 -> true;
        true -> check(Set1, Set2, 1)
    end.
