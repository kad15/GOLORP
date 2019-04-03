/*conc([],L,L).
conc([X|L1],L2,[X|L3]):-conc(L1,L2,L3).



%applatir ap transforme une liste de listes en une liste unique i;e liste applatie A 
ap([],[]). % applatir liste vide
ap(X,[X]). %applatir un elt qui n'est pas une liste
ap([Tete|Queue],ListePlate):-
	ap(Tete,TetePlate),
	ap(Queue, QueuePlate),
	conc(TetePlate,QueuePlate,ListePlate).
	
	
	
% 1.07 (**): Flatten a nested list structure.

% my_flatten(L1,L2) :- the list L2 is obtained from the list L1 by
%    flattening; i.e. if an element of L1 is a list then it is replaced
%    by its elements, recursively. 
%    (list,list) (+,?)

% Note: flatten(+List1, -List2) is a predefined predicate

my_flatten(X,[X]) :- \+ is_list(X).
my_flatten([],[]).
my_flatten([X|Xs],Zs) :- my_flatten(X,Y), my_flatten(Xs,Ys), append(Y,Ys,Zs).

	*/