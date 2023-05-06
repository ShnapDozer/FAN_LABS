-module(lab3).
-import(bin_tree, [empty/0, node/3, is_empty/1, data/1, left_child/1, right_child/1, view/1]).
-compile(export_all).


flatten(bin_tree) ->
    flatten(bin_tree, [], []).

flatten([], Acc, Res) ->
    lists:reverse(Res ++ Acc);
flatten([H|T], Acc, Res) ->
    case view(H) of
        empty ->
            flatten(T, Acc, Res);
        {_, V, L, R} ->
            flatten(L, [V|Acc], Res),
            flatten(R, [V|Acc], Res),
            flatten(T, Acc, Res)
    end.