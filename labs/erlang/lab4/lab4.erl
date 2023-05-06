-module(lab4).
-compile(export_all).

thread() ->
    receive
        {Msg, T1, List, ConstList, 0} -> 
            % io:format("Proc: ~p finished~n", [self()]),
            ok;
        {Msg, T1, List, ConstList, Count} ->
            [Cur | Tail] = List,
            if
                Tail == [] -> 
                    io:format("Proc: ~p, mesg: ~p, send: ~p~n", [self(), Msg, T1]),
                    T1 ! {Msg, T1, ConstList, ConstList, Count - 1},
                    thread();
                true ->
                    [Next | T] = Tail,
                    io:format("Proc: ~p, mesg: ~p, send: ~p~n", [self(), Msg, Next]),
                    Next ! {Msg, T1, [Next | T], ConstList, Count},
                    thread()
            end;
        stop -> ok
    end.

spawn_procesess(List, Count, Current) ->
    if
        Current < Count -> spawn_procesess([spawn(fun() ->thread() end) | List], Count, Current + 1);
        true -> List
    end.

ring(N, M) ->
    List = spawn_procesess([], N, 0),
    [H | T] = List,
    H ! {"Hello", H, List, List, M},
    ok.

