inser([], X,[X]).
inser([A|B], X, [X,A|B]) :- X >= A.
inser([A|B], X, [A|C]) :-  X <A, inser(B,X,C).

trier([],L,L).
% on insère l'elt X dans la liste C pour donner la liste A 
trier([X|B],C,D) :- inser(C, X, A), trier(B, A, D).

trier(A,B) :- trier(A,[], B).

% trier([2,5,2,6,7], L).