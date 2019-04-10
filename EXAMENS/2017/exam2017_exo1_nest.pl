% exo 1
% Q 1.1

% is_nest(e(_)). % e(_) est un nest
% ou un nest  est de la forme n(L) avec L une liste 
% particuliere car il faut que ce soit une liste de nests

is_nest(e(_)). 
is_nest(n(L)) :- is_nests_list(L).
is_nests_list([]).
is_nests_list([X|T]) :- is_nest(X), is_nests_list(T).

% tests
% is_nest(n([e(3),e(0),e(1),e(8)])).
% is_nest([1,2,3]).
% is_nest(e(4)).
 % is_nest(      n([   n([  e(4),e(7),e(2)  ])    ])  ).
% is_nest(n([n([e(4),e(7),e(2)]),n([e(3),e(0),e(1),e(8)])])) .

% Question 1.2. Écrivez un prédicat mirror/2 pour renverser un nest. Par exemple, l’appel
% mirror(n([n([e(4),e(7),e(2)]),n([e(3),e(0),e(1),e(8)])]),N) doit instantier N comme
% n([n([e(8),e(1),e(0),e(3)]),n([e(2),e(7),e(4)])]).

mirror(e(X),e(X)).
mirror(n(L),n(R)):- mirror_list(L,R).

mirror_list([],[]).
mirror_list([H|T], R) :-  mirror(H,HM), mirror_list(T,TM),append(TM,[HM],R).


% test
% mirror(n([n([e(4),e(7),e(2)]),n([e(3),e(0),e(1),e(8)])]),N).

% Question 1.3. Écrivez un prédicat flatten/2 pour “aplatir” un nest, c’est-à-dire, pour
% convertir le nest dans une liste qui contient les éléments dans les feuilles
% d’un nest dans un passage gauche-à-droit. Par exemple, l’appel
% flatten(n([n([e(4),e(7),e(2)]),n([e(3),e(0),e(1),e(8)])]),L) doit instantier L comme
% [4,7,2,3,0,1,8].
% flat([H|T],R):- flat(H,HF), flat(T,TF), append(HF,TF,R).
% flat([],[]).
% flat(X,[X]) :- \+ is_list(X).

flatten_(e(X),[X]).
flatten_(n(L),R) :- flatten_list(L,R).
flatten_list([H|T],R):- flatten_(H,HF), flatten_list(T,TF), append(HF,TF,R).
flatten_list([],[]).


% test% 
% flatten_(n([n([e(4),e(7),e(2)]),n([e(3),e(0),e(1),e(8)])]),R).