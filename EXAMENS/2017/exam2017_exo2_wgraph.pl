% exo 2
edge(a,c,1).
edge(a,d,3).
edge(b,d,2).
edge(c,e,5).
edge(e,c,2).
edge(e,f,2).
edge(d,f,10).

% graphe traversal exemple du cours
% path(X, Y, P, Forbid) :- edge(X, Y,V), P = [] ; 
		% edge(X,Z,V), \+ member(Z, Forbid),
		% path(Z, Y, P1, [X|Forbid]), P = [Z|P1].

% 2.1 
 % avec le path P			
 % path(X,Y,Visited,P,Cost) :- edge(X,Y,W), Cost is W, P=[];
		% edge(X,Z,W), \+ member(Z,Visited),
		% path(Z,Y,[Z|Visited], P1, C1), P = [Z|P1], Cost is C1 + W.

% sans le path P		
 path(X,Y,Visited,Cost) :- edge(X,Y,W), Cost is W;
		edge(X,Z,W), \+ member(Z,Visited),
		path(Z,Y,[Z|Visited], C1), Cost is C1 + W.
		
% test : 
% path(a,f,[], C).		
		
cheaperPath(X,Y,N):- path(X,Y,[], C),C < N.
% test
% cheaperPath(a,f,7).


% quel que soit le Coût trouver la liste des sommets atteignables			
reachable(X,L) :- setof(Y, Cost ^ path(X,Y,[], Cost), L).