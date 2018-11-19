%%%%%%%%%%%%%%% k

conc([],L,L).
conc([X|L1],L2,[X|L3]):-conc(L1,L2,L3).

flatten_(X,[X]).          % :- \+ is_list(X).
flatten_([],[]).
flatten_([T|Q],R) :- flatten_(T,Tplate), flatten_(Q,Qplate), conc(Tplate,Qplate,R).  %append(Tplate,Qplate,R).

% on pop le 1er element de L et on l'accumule dans A
% dès que la liste L est vide, on copie l'accumulateur dans A
%reverse_([],M,M).
reverse_(L,A,M ):- L = [X|R] , reverse_(R,[X|A],M ); L = [],  M = A.
reverse_(L, M ) :- reverse_(L,[], M ).


