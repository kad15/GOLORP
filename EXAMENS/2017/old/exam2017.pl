%Exo 1
% 1.1
is_nest(e(_)).
is_nest(n([])).
is_nest(n([X|T])):- is_nest(X),is_nest(n(T)).


% 1.2

mirror(e(X),e(X)).
mirror(n([]),n([])). 
mirror(L,N):- is_list(L),reverse(L,N).
mirror(n([H|T]), N):- mirror(H,HM),mirror(T,TM), append(TM, HM,N).

% 1.3
flatten2(e(X),[X]).
flatten2(n([]),n([])). 
flatten2( n([H|T]), F):- is_nestflatten2(H,HF), flatten2(T,TF),append(HF,TF,F).