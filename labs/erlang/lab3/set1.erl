-module(set1).
-compile(export_all).

-type set() :: [any].

-spec make() -> set().
-spec has(set(), any()) -> boolean().
-spec add(set(), any()) -> set().
-spec clear(set()) -> set().
-spec delete(set(), any()) -> set().
-spec is_subset(set(), set()) -> boolean().

make() -> [].

has([], Item) -> false;
has(Set, Item) ->
    [H | T] = Set,
    if
        H == Item -> true;
        true -> has(T, Item)
    end.

add(Set, Item) -> 
    Has = has(Set, Item),
    if
        Has -> Set;
        true -> [Item | Set]
    end. 

clear(Set) -> [].

delete_item([H | Tail], Item, Res) -> 
    if
        H == Item -> Res ++ Tail;
        true -> delete_item(Tail, Item, [H | Res])
    end.
    

delete(Set, Item) -> 
    Has = has(Set, Item),
    if
        Has == false -> Set;
        true -> delete_item(Set, Item, [])
    end.

is_subset([], Set2) -> true;
is_subset(Set1, Set2) ->
    [H | Tail] = Set1,
    Has = has(Set2, H),
    if
        Has -> is_subset(Tail, Set2);
        true -> false
    end.
