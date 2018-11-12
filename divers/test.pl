/*
count(X, X).
count(X, N ):- X < N, write(X), Y is X + 1, nl, count(Y, N).
*/

edge(a,c).
edge(c,a).
edge(a,d).
edge(c,e).
edge(e,f). 
edge(d,f).
path(X,Y):- edge(X,Y);(edge(X,Z), path(Z,Y)).
path(X,Y,F):- edge(X,Y);(edge(X,Z), \+ (member(Z,F)), path(Z,Y,[X|F])).
path2(X,Y):- edge(X,Y);(path2(X,Z), edge(Z,Y)).
path3(X,Y):- edge(X,Y);(edge(Z,Y),path3(Z,Y)).
safe(X) :- \+ (edge(Y,X), safe(Y)).
%notsafe(X) :- edge(Y,X), safe(Y).
%safe2(X):- \+ (notsafe(X)).          % safe if pas du tout attaqué or it is not attacked by any safe node
 
 
/*
We do not know the length of the path in advance ⇒ store it in a list
⇒ Define a predicate path /3 such that path (X, Y, P ) is true if P is a
list of vertices on a path from X to Y :)
 */

%path(X, Y, P) :- edge(X, Y),P=[] ; ( edge(X,Z), path(Z, Y, P1),P=[Z|P1] ).


path(X, Y, P, F) :- edge(X, Y), P = [] ; 
	(   
		edge(X,Z),
		\+ (member(Z, F)), 
		path(Z, Y, P1, [X|F]), 
		P = [Z|P1] 
	).



/*
reachable (X, L) is true if L is the list of vertices to
which there is a path from X
*/


reachable(X,L):- findall(Y, path(X,Y,[]),L).


/*  
select /3: a predicate that can be used to “delete" an occurrence of an
element of a list. For instance, to the query select (X, [a, b, c, a], R)
Prolog should answer:
X = a ∧ R = [b, c, a] ∨ X = b ∧ R = [a, c, a] ∨ X = c ∧ L =
[a, b, a] ∨ X = a ∧ L = [a, b, c].

*/

select(X,[X|T],T).  % si l'elt est en tete de liste on obtient la tail T
select(X,[Y|T],[Y|L]) :- select(X,T,L).   % si X est ds la tail on le selctionne dans cette tail