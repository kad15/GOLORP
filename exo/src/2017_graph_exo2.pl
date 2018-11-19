edge(a,c,1).
edge(a,d,3).
edge(b,d,2).
edge(c,e,5).
edge(e,c,2).
edge(e,f,2).
edge(d,f,10).
% edge(X,Y):- edge(X,Y,Z).

/*
ath(X ,Y ,Path , Cost ) :- path(X ,Y ,[] ,0 ,P , Cost), reverse(P,Path).
path(X ,X ,Path ,Cost ,Path , Cost ).
path(X ,Y ,Visited , CurrentCost ,Path , Cost ) :- 
	edge(X ,Z , V ) , \+ member(Z, Visited ) ,
	K is CurrentCost + V , path(Z ,Y ,[ Z | Visited ] , K ,Path, Cost).

cheaperPath(X, Y, N):- path(X ,Y ,Path , Cost), Cost<N.
reachable(X,L) :- setof(Y,(X, Path, Cost) ^ (path(X,Y,Path,Cost), Y\==X),L).
*/

path(X ,Y, Cost) :- path(X ,Y ,[] , 0, Cost).


path(Y ,Y, _,Cost ,Cost).  % quand Z=Y à la fin de la chaine on ecrit le cout courant, alors égale au cout total, dans le cout final : Cost
path(X ,Y ,Visited , CurrentCost , Cost ) :- 
	edge(X ,Z , V ) , \+ member(Z, Visited), 
	  K is CurrentCost + V , path(Z ,Y ,[ Z | Visited ] , K, Cost). 
	 % CurrentCost  mémorise la somme partielle des couts arcs, la somme pour l'arc suivant. 

cheaperPath(X, Y, N):- path(X ,Y, Cost), Cost < N.

% quels que soit le coût et le sommet origine X, calcule la liste des Y et les range dans une liste sans doublons
 reachable(X,L) :- setof(Y,(X, Cost) ^ (path(X,Y,Cost), Y\==X),L).