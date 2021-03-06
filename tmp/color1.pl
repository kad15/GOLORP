sol(A,B,C,D,E) :- generate(A,B,C,D,E), test(A,B,C,D,E).

/**/
generate(A, B, C, D, E) :-
	color(A) , color(B) , color(C) , color(D) , color(E).

color(X) :- X=green ; X=purple ; X=orange .

test(A, B, C, D, E) :- A \= B,B \= E,E \= D,D \= A,
C \= A,C \= B,C \= E,C \= D.