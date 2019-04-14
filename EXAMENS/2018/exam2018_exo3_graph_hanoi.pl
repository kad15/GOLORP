%exam 2018
%EXO 3	Hanoi
%3.1 validState/1 sur les 3 tiges les listes sont ordonnées
sorted([]).
sorted([_]).
sorted([X,Y|L]):- X @=< Y, sorted([Y|L]).

validState([L,M,R]) :- sorted(L), sorted(M), sorted(R).
 
 
 % *****************************************************************
 % 3.2 validMove si l'etat initial est valide, si le deplacement de l'état S à l'état R
 % se fait en retirant un disque de la tige R1 pour le placer sur le tige R2 avec M =(R1,R2)
 % et si l'état R est valide
 % récup des listes = tiges left midle et right à partir d'un état.

 tige([T1,_,_],left,T1). 
 tige([_,T2,_],middle,T2).
 tige([_,_,T3],right,T3).

 
 validMove(S,(R1,R2),R) :- P=[left,middle,right],
   select(R1,P,P1), select(R2,P1,P2),
   select(R3, P2,_),
   validState(S), 
 
   tige(S,R1,TS1),  % recup tige TS1 en pos R1 de l'état S
   tige(R,R1,TR1),  % recup tige TR2 en pos R1 de l'état R 
   TS1 = [X|TR1],% vrai si TR1 est la queue de TS1
   tige(S,R2,TS2),  
   tige(R,R2,TR2),  
   TR2 = [X|TS2], % TS2 queue de TR2 
     tige(S,R3,TS3), tige(R,R3,TR3), TS3=TR3,
   validState(R).
 
 % validMove([[1,2,3,4],[],[]],M,R).
 
 
 % 3.3 hanoi(N,L) 

 hanoi(I,F,P,Interdit) :- validMove(I,M,F), P=[M], nl,write(F);
		validMove(I,M,Z), \+ member(Z, Interdit),nl, write(M),write(Z),
	 hanoi(Z,F,P1,[I|Interdit]),P=[M|P1].
	 

genereListe(1,[1]).
genereListe(N,[N|T]) :-  N1 is N-1, N1 \=0, genereListe(N1,T).
gen(N,L) :- genereListe(N,P), reverse(P,L).


hanoi(N) :- gen(N,L), I=[L,[],[]], reverse(I,F), hanoi(I,F,P,[]). 
 hanoi :- I=[[1,2,3,4],[],[]],F=[[],[],[1,2,3,4]], hanoi(I,F,P,[]).		
% Q 7.4
plan(P) :- plan([b,f,g,x], [], P, []), write(P).
reachable(P,L) :- findall(P, plan(P),L).
 
 
 
 % *****************************************************************
 /*
  % 
  
 %3.2 validMove

 
 % predicat elt/3 elt(Index,Liste, X) où X est l'element d'index I dans la liste L1
 %elt(I,L,_):- length(L,N), (I<0;I>=N),!,write('index out of range'),nl,fail.
 elt(0, [X|_], X). % cas de base
%elt(N-1,[X], X). 
 elt(I, [_|T], Y) :- N is I-1, elt(N,T, Y).
 
 
 validMove(S,M,R):- % valid moves from state 0 to state 1
	% lecture des données et condition rod de départ \= vide
	elt(0,M,R0), elt(1, M,R1), 
	elt(R0,S,LS0), elt(R1,S, LS1), LS0 \= [],
	elt(R0,R,LR0), elt(R1,R,LR1),
	% on retire le disque du rod 0 pour le placer sur le rod 1
	LS0=[X|TS0],LR0=TS0, LR1=[X|LS1]. 
	
	*/
 