-module(test).
-export([
    test_make/1,
    test_add/2,
    test_has/3,
    test_clear/2,
    test_delete/3
]).

test_make(Module) -> 
    Module:make().

push(Module, Set, Count) ->
    if
        Count == 0 -> Set;
        true -> push(Module, Module:add(Set, Count), Count - 1)
    end.
test_add(Module, Count) ->
    Set = test_make(Module),
    push(Module, Set, Count).


test_has(Module, Set, Item) ->
    Module:has(Set, Item).

test_clear(Module, Set) -> 
    Module:clear(Set).

test_delete(Module, Set, Item) ->
    Module:delete(Set, Item).