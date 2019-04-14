% exam 2018
% exo 1
% 1.1 permu/2).
% P est une permu de la liste L= [H|T] si T est une permutation de la liste P1
% et R une liste avec H 
% ins(X,T,[X|T]). % si on insere X ds la liste vide on a la liste [X]
% si la liste est non vide ins(X,L,R) est vrai si R est la liste L avec 
eff(X,[X|P],P).
eff(X,[Y|G],[Y|P]):- eff(X, G,P).
ins_bis(X,S,B) :- eff(X,B,S).

ins(X, P, [X|P]).
ins(X, [Y|P], [Y|G]):- ins(X,P,G).

permu([],[]). % cas de base
permu([H|T],P) :- permu(T,P1), ins(H,P1, P).

% predicat vrai si on efface X de L est vrai et le resultat R est une permutation de T
permu2([],[]).
permu2(L, [X|T]):- eff(X, L, R), permu2(R,T).


% 2 - 
% ?- permu(R, [1,2]). non symétrique.
%  En cherchant d'autres permutations, R n'étant pas instancié, 
%  prolog recherche des permutations avec une liste P candidate 
% qui s'agrandit continuellement jusqu'au stack over flow.

% sorted

sorted([X]).
sorted([X,Y|T]) :- X @=<Y, sorted([Y|T]). 

% 4 