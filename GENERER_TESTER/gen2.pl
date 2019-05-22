% sol(S,E,N,D,M,O,R,Y):- select(S,[1,...,9],R1),R1,R2), ...,select(E,[0,R2],R3) , ...,
		% Y1 is D+E, Y is D+E mod 10, ret 1 is D+E//10
crypto(S,E,N,D,M,O,R,Y):- gen(S,E,N,D,M,O,R,Y),tester(S,E,N,D,M,O,R,Y).
gen(S,E,N,D,M,O,R,Y):- 
	select(S,[0,1,2,3,4,5,6,7,8,9],R1),
	select(E,R1,R2), 
	select(N,R2,R3),
	select(D,R3,R4), 
	select(M,R4,R5),
	select(O,R5,R6), 
	select(R,R6,R7),
	select(Y,R7,_).

tester(S,E,N,D,M,O,R,Y):- 
	S\=0, M\=0, 
	Y1 is D+E, Y is Y1 mod 10, Reste1 is Y1 // 10,
	E1 is N+R+Reste1, E is E1 mod 10, Reste2 is E1 // 10,
	N1 is E+O+Reste2, N is N1 mod 10, Reste3 is N1 //10,
	O1 is S+M+Reste3, O is O1 mod 10, Reste4 is O1 //10,
	M is Reste4.
 
sol(A,B,C,D,E) :- generate(A,B,C,D,E), test(A,B,C,D,E).

/* toto */
generate(A, B, C, D, E) :-
	color(A) , color(B) , color(C) , color(D) , color(E).

color(X) :- X=green ; X=purple ; X=orange .

test(A, B, C, D, E) :- A \= B,B \= E,E \= D,D \= A,
C \= A,C \= B,C \= E,C \= D.


