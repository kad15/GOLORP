/*

Question 2.1. Define a predicate cheaperPath/3, such that cheaperPath(X, Y, N) is true if there
is a path from X to Y of total cost less than N. The predicate is supposed to be called with X, Y
and N all instantiated, for example to the query cheaperPath(a, f , 7) the anwer should be no.

*/

/*

Question 2.2. Define a predicate reachable/2 that computes the list of nodes that can be reached
from a given node. For instance, to the query reachable(a, L) Prolog should answer L=[c, e, d, f ]
(in any order). (Remember findall.)

*/

edge(a,c,1).
edge(a,d,3).
edge(b,d,2).
edge(c,e,5).
edge(e,c,2).
edge(e,f,2).
edge(d,f,10).

path(X ,Y ,Path , Cost ) :- path(X ,Y ,[] ,0 ,P , Cost), reverse(P,Path).
path(X ,X ,Path ,Cost ,Path , Cost ).
path(X ,Y ,Visited , CurrentCost ,Path , Cost ) :- 
	/*edge(X,Y,V), Cost is CurrentCost+V;*/
	edge(X ,Z , V ) , \+ member(Z, Visited ) ,
	K is CurrentCost + V , path(Z ,Y ,[ Z | Visited ] , K ,Path, Cost).

cheaperPath(X, Y, N):- path(X ,Y ,Path , Cost), Cost<N.
reachable(X,L) :- setof(Y,(X, Path, Cost) ^ (path(X,Y,Path,Cost), Y\==X),L).
  