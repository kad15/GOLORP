/*
edge(a,c).
edge(a,d).
edge(b,d).
edge(c,e).
edge(e,c).
edge(e,f).
edge(d,f).
*/


edge(a,c,1).
edge(a,d,3).
edge(b,d,2).
edge(c,e,5).
edge(e,c,2).
edge(e,f,2).
edge(d,f,10).
/*
path(X,Y) :- edge(X,Y);
			edge(X,Z),path(Z,Y).
*/
/*			
path(X,Y,P,N):- edge(X,Y,V), P=[], N is V;
		edge(X,Z,W),Z\==Y,path(Z,Y,P1,VV),P=[Z|P1].
*/		
%,VV is W + N
path(X,Y) :- path(X,Y,[X],0).
path(X,Y,Visited,N):- edge(X,Y,V);
		edge(X,Z,W),N1 is W+N, Z\==Y,\+ (member(Z,Visited)),path(Z,Y,[Z|Visited],N1).
		

/*		
reverse(L,A,M ) :- 
		L = [X|R], reverse(R,[X|A],M ); 
		L = [],  M = A.
reverse(L, M) :- reverse(L, [], M ).
		
*/

%successeur( V1 , V2 , N ) :- edge( V2 , V1 , N ) ; edge( V1 , V2 , N ).

chemin(D ,A ,C , K ) :- chemin(D ,A ,[D] ,0 ,Q , K ), reverse(Q,C).


chemin(A ,A ,C ,K ,C , K ).
chemin(D ,A ,P , KP ,C , K ) :-
	edge(D ,S , KDS ) , \+ member(S , P ) ,
	KP1 is KP + KDS , chemin(S ,A ,[ S | P ] , KP1 ,C , K ).


path2(A,B,Path):- 
		traverse(A,B,[A],Q,0), 
		reverse(Q,Path).

traverse(A,B,P,[B|P],N):- 
			edge(A,B,V), N is V.

traverse(A,B,Visited, Path, N) :- 
		edge(A,C,V),C \==B,
		\+ member(C,Visited),/*N1 is V + N,*/
		traverse(C,B,[C|Visited], Path, N1).
