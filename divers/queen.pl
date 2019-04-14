solution( Queens) :-
permutation( [1,2,3,4,5,6,7,8], Queens),
safe( Queens).
permutation( [],[]).
permutation( [Head | Tail], PermList) :-
permutation( Tail, PermTail),
del( Head, PermList, PermTail). % Insert Head in permuted Tail
% del( Item, List, NewList): deleting Item from List gives NewList
del( Item, [Item | List], List).
del( Item, [First | List], [First | Listl]) :-
del( Item, List, Listl).
% safe( Queens) if Queens is a list of Y-coordinates of non-attacking queens
safe([]).
safe( [Queen | Others]) :-
safe( Others),
noattack( Queen, Others, 1).
noattack(_, [], _).
noattack( Y, [Yl | Ylist], Xdist) :-
Yl-Y=\= Xdist,
Y-Yl =\= Xdist,
Distl is Xdist + 1,
noattack( Y, Ylist, Distl).