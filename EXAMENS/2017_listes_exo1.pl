
 is_nest(N) :- N = e(_) ; N = n(L), is_nest(L).




%%%%%%%%%%%%%%% k
edge(a,c,1).
edge(a,d,3).
edge(b,d,2).
edge(c,e,5).
edge(e,c,2).
edge(e,f,2).
edge(d,f,10).
edge(X,Y):- edge(X,Y,Z).



conc([],L,L).
conc([X|L1],L2,[X|L3]):-conc(L1,L2,L3).

flatten_(X,[X]) :- \+ is_list(X).
flatten_([],[]).
flatten_([T|Q],R) :- flatten_(T,Tplate), flatten_(Q,Qplate), conc(Tplate,Qplate,R).  %append(Tplate,Qplate,R).

% on pop le 1er element de L et on l'accumule dans A
% dès que la liste L est vide, on copie l'accumulateur dans A
%reverse_([],M,M).
reverse_(L,A,M ):- L = [X|R] , reverse_(R,[X|A],M ); L = [],  M = A.
reverse_(L, M ) :- reverse_(L,[], M ).


% select(-X, -L, +R) supprime un élement de la liste L pour donner R
select_(X,L,R) :- 
		L=[X|R]; /* si X est la tête de liste on envoie R */
		L=[T|Q], select_(X,Q,S), R=[T|S]. /* si la tête est différente de X, on l'extrait
											on recherche X dans la queue on obtient S
											il reste à remettre la tête T <> X */
% path avec forbidden liste F et liste des vertex P											
path(X, Y, P, F) :- edge(X, Y), P = [] ; 
	(   
		edge(X,Z),
		\+ (member(Z, F)),
		path(Z, Y, P1, [X|F]), 
		P = [Z|P1] 
	).
path(X,Y,P):-path(X,Y,P,[X]).

reachable(X,L,P) :- findall(Y, path(X,Y,P),L).
reachable2(X,L) :- setof(Y, P ^ path(X,Y,P),L).
		


