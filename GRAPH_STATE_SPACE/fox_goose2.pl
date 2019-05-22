% Q 7.1 safeState/1 E état représentant les éléments présents
% sur la berge initiale : état initial [f, x, g, b]

% nb/2 nb of elements in a list
nb([],0).
nb([_|T],N):- nb(T,K), N is K+1. 


safeState(E) :- %sort(E),
member(E, [[],[g],[x],[b],
[f,g], [b,x], 
[f,g,x], [b,f,x], [b,f,g], 
[b,f,g,x]]).



% ******************************************************* 
% Q 7.2 crossing/2 s.t. crossing(E1,E2) est vrai
% s'il est possible de passer de l'état 1 à l'état 2
% via une traversée unique du fermier avec ou sans elements.
% utiliser select

%cas de la traversée du fermier à vide de la berge 
% 1 vers la berge 2
crossing(E1,E2) :- safeState(E1),
					safeState(E2), 
					select(f,E1,E2).

% crossing([x,b,f,g], [x,b]).
% crossing([x,b],[x,b,f,g]).
% consult('C:/Users/toto/Desktop/fox_goose2.pl').
					
%cas de la traversée à vide de la 
% berge 2 vers la berge 1 
crossing(E1,E2) :- safeState(E2),
					safeState(E1),
					select(f,E2,E1).
					 
% cas de la traversée du fermier 
% avec un element de la berge 1 à la 2
crossing(E1,E2) :-  safeState(E1),
					safeState(E2),
					select(f,E1,Z),
					select(_, Z,E2).
		

					
% cas de la traversée du fermier 
% avec un element de la berge 2 à la 1
crossing(E1,E2) :-  safeState(E1),
					safeState(E2),
					select(f,E2,Z),
					select(_, Z,E1).
					
 

% Q 7.3 plan/4 st plan(I,F,P,N) vrai s'il est possible
% de passer de l'état I à l'état F avec les états intermédiaires
% dans la liste P sans passer par les états interdits
% dans la liste N. verifier qu'un état n'est pas dans la liste N
% fxb  and xfb representent le même état.

%nonvar/1 true si la var est instanciée
permu([],[]).
permu([X|L], P):- nonvar(X),permu(L,R), ins(X,R,P).
permu([X|L],P):- var(X),permu(P,[X|L]).

% tri en place de chaque état de la liste L
sortStates([]).
% sortStates([E|T]) :- sort(E),sortStates(T).
sortStates([E|T]) :- sort(E),sortStates(T).
% sortStates([E|T]) :- sort(E),write(E),sortStates(T).  

% stateIn true if state E in liste N 
notIn(E, N) :- sort(E), sortStates(N), \+ ((member(E,N))).

% 
%plan([f,g,x,b],[],P, []).
plan(I,F,P,N) :- sort(I), sort(F),crossing(I,F), P=[] ;
		crossing(I,Z), notIn(Z,N), 
		N1=[I|N], plan(Z,F,P1,N1),P=[Z|P1].


path(X, Y, P, F) :- edge(X, Y), P = [] ; 
	(   
		edge(X,Z),
		\+ (member(Z, F)),
		path(Z, Y, P1, [X|F]), 
		P = [Z|P1] 
	).
		
% Q 7.4
plan(P) :- plan([b,f,g,x], [], P, []), write(P).
reachable(P,L) :- findall(P, plan(P),L).