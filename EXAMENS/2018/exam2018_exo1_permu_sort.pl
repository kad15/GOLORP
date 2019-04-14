% exam 2018
% exo 1
% 1.1 permu/2).
ins(X,L,[X|L]).
ins(X,[Y|T1],[Y|T2]) :- ins(X, T1, T2).

% si la 1er liste est vide alors la seconde également
% si la liste est non vide de la forme X|L on permute L
%et on insere X dans L

%introspection avec var/1 pour symétriser la permutation
permu([],[]). % cas de base
% permu(L,P) est vrai si la queue de Q est une permutation de la liste R
% et si l'insertion non déterministe de la tête de L dans R donne P
permu([X|L], P):- nonvar(X),permu(L,R), ins(X,R,P). % nonvar(X) true si X instancié
permu([X|L],P):-var(X),permu(P,[X|L]).  % var(X) true si X non instancié donc on appelle permu

% 2 - stack overflow. l'utilisation du predicat "trace." montre
%que la permutation se fait sur une liste de plus en longue 
% constituée de valeurs non instanciées
%la récursion se fait sur la 1ere liste via la décomposition [X|L] qui doit donc être instanciée 
% i.e. permu([1,2],P)

% 3 - sorted

sorted([]).
sorted([_]).
sorted([X,Y|L]):- X @=< Y, sorted([Y|L]).
 

%4 - permusort/2  générer et tester
permusort([X],[X]).
permusort(L,S) :- permu(L,S),sorted(S).

% 5 - complexité : dans le pire cas, l'algo test n! permutations et chaque
% test de tri avec sorted se fait en O(n) on a donc une complexité temporelle
% en O(n*n!) (catastrophique comparée à l'optimale O(n lg n)) 

