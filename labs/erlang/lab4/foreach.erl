-module(foreach).
-export([
    thread/2,
    seq/1,
    spawn_procesess/3
]).
% L = foreach:seq(10).
% T = foreach:spawn_procesess(fun(X) -> io:format("~p: ~p~n", [self(),X]) end,L, 10).

thread(F, Item) ->
    % timer:sleep(1000),
    F(Item),
    % thread(F, Item),
    ok.

seq(N) ->
    seq([], N, 1).

seq(List, Count, Current) ->
    if
        Current == Count -> List ++ [Current];
        true -> seq(List ++ [Current], Count, Current + 1)
    end.

spawn_procesess(F, List, N) ->
    spawn_procesess([], N, 1, List, F).

spawn_procesess(Threads, Count, Current, List, F) ->
    [Item | Tail] = List,
    if
        Current < Count -> spawn_procesess([spawn(fun() ->thread(F, Item) end) | Threads], Count, Current + 1, Tail, F);
        true -> Threads
    end.