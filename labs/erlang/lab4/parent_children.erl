-module(parent_children).
-compile(export_all).

spawn_procesess(List, Count, Current) ->
    if
        Current < Count -> spawn_procesess([spawn(fun() ->thread() end) | List], Count, Current + 1);
        true -> List %[spawn(fun() ->thread() end) | List]
    end.

start(N) -> 
    spawn(fun() ->parent([], N) end).

delete(N, List, NewList, Current) ->
    [H | Tail] = List,
    if
        N /= Current -> delete(N, Tail, NewList ++ [H], Current + 1);
        true -> NewList ++ Tail
    end.
delete(N, List) ->
    delete(N, List, [], 1).

stop_all([]) -> ok;
stop_all(List) ->
    [H | Tail] = List,
    H ! {stop},
    stop_all(Tail).


parent([], N) ->
    parent(spawn_procesess([], N, 0)).
parent(List) ->
    receive
        {stop, N} ->
            P = lists:nth(N, List),
            P ! {stop},
            NewList = delete(N, List),
            % io:format("NewList: ~p~n", [NewList]),
            parent(NewList);
        {die, N} ->
            P = lists:nth(N, List),
            P ! {die},
            NewP = spawn(fun() ->thread() end),
            NewList = delete(N, List),
            parent([NewP | NewList]);
        {Msg, N} ->
            P = lists:nth(N, List),
            P ! {Msg},
            parent(List);
        stop -> 
            stop_all(List);
        list -> 
            io:format("~p~n", [List]),
            parent(List)

    end.
thread() ->
    receive
        {stop} -> 
            io:format("Proc: ~p ending without errors~n", [self()]),
            exit(stop);
        {die} ->
            io:format("Proc: ~p ending with error~n", [self()]),
            exit(die);
        {Msg} ->
            io:format("Proc: ~p received message: ~p~n", [self(), Msg]),
            thread();
        M ->
            io:format("Proc: ~p received message: ~p~n", [self(), M]),
            thread()
    end.
