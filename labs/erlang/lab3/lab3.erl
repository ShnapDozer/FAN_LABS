-module lab3.
-compile(export_all).

listLength([], Count) -> Count;
listLength([H | Tail], Count) -> listLength(Tail, Count + 1).
listLength(List) -> listLength(List, 0).

listSlice(List, 0, Res) -> Res;
listSlice([], Count, Res) -> Res;
listSlice([H | Tail], Count, Res) -> listSlice(Tail, Count - 1, Res ++ [H]).

listSplit(List) ->
    L = listLength(List) div 2,
    Left = listSlice(List, L, []),
    Right = List -- Left,
    [Left, Right].

% разделение списка на две части, 
% в первой все элементы меньше переданного аргумента, во второй больше
medianArgSplit([], Arg, Res) -> [Res, []];
medianArgSplit(List, Arg, Res) ->
    [H | Tail] = List,
    if
        (H >= Arg) and (Res == []) -> [[], List];
        H < Arg -> medianArgSplit(Tail, Arg, Res ++ [H]);
        true -> [Res, List]
    end.
medianArgSplit(List, Arg) -> medianArgSplit(List, Arg, []).

-type tree() :: empty | {node, any(), tree(), tree()}.

list2Tree([]) -> empty;
list2Tree(List) ->
    [L, R] = listSplit(List),
    [Data | TR] = R,
    {node, Data, list2Tree(L), list2Tree(TR)}.


tree2List(empty, Res) -> Res;
tree2List(Tree, Res) ->
    Data = element(2, Tree),
    LE = element(3, Tree),
    RE = element(4, Tree),
    if
        (LE == empty) and (RE == empty) -> Res ++ [Data];
        RE == empty -> tree2List(LE, Res);
        LE == empty -> tree2List(RE, Res ++ [Data]);
        true -> tree2List(LE, Res) ++ [Data] ++ tree2List(RE, Res)
    end.
tree2List(Tree) -> tree2List(Tree, []).

split(Tree, X) ->
    List = tree2List(Tree),
    [L, R] = medianArgSplit(List, X),
    {list2Tree(L), list2Tree(R)}.

% T = lab3:list2Tree([1, 3, 5, 7, 8, 11, 13]).
% lab3:split(T, 6).
