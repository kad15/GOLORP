% Q 7.1 safeState/1 E état représentant les éléments présents
% sur la berge initiale : état initial [f, x, g, b]

% nb/2 nb of elements in a list
nb([],0).
nb([_|T],N):- nb(T,K), N is K+1. 

% cas 0 elements 
% safeState([]). 

% cas 1 element : il faut fermier not in E sinon
% sur la berge opposée on aurait x,g,b 
% safeState(E) :- nb(E,1), \+ member(f, E).
% safeState(E) :- E\= [f].

% cas 2 elements : soit f,g soit x,b
% safeState(E) :- sort(E,F), ( F = [f,g] ; F = [b,x];F\=[b,g,x]).
% safeState(E) :- nb(E,2), member(x,E), member(b,E).

% cas 3 elements : il faut et il suffit que le fermier soit présent
% sur l'autre berge on n'a qu'un seul element non fermier
% donc safe.
% safeState(E) :- nb(E,3), member(f,E).
%safeState(E) :- E \=[b,g,x].


% cas 4 elements
%safeState(E) :- nb(E,4).
% safeState([_,_,_,_]).

safeState(E) :- sort(E), 
member(E, [[],[g],[x],[b], [f,g], 
[b,x], [f,g,x], [b,f,x], [b,f,g], [_,_,_,_]]).






% ******************************************************* 
% Q 7.2 crossing/2 s.t. crossing(E1,E2) est vrai
% s'il est possible de passer de l'état 1 à l'état 2
% via une traversée unique du fermier avec ou sans elements.
% utiliser select

%cas de la traversée du fermier à vide de la berge 
% 1 vers la berge 2
 crossing(E1,E2) :-  safeState(E1),safeState(E2),
					member(f,E1),select(f,E1,E2).

%cas de la traversée à vide de la 
% berge 2 vers la berge 1
  crossing(E1,E2) :- safeState(E2),safeState(E1),
					 member(f,E2), select(f,E2,E1).
					 
% cas de la traversée du fermier 
% avec un element de la berge 1 à la 2
crossing(E1,E2) :-  safeState(E1),safeState(E2),
					member(f,E1),
					select(f,E1,Z),X\=f,
					select(X, Z,E2).
					
% cas de la traversée du fermier 
% avec un element de la berge 2 à la 1
crossing(E1,E2) :-  safeState(E1),safeState(E2),
					member(f,E2),
					select(f,E2,Z),
					select(_, Z,E1).

% Q 7.3 plan/4 st plan(I,F,P,N) vrai s'il est possible
% de passer de l'état I à l'état F avec les états intermédiaires
% dans la liste P sans passer par les états interdits
% dans la liste N. verifier qu'un état n'est pas dans la liste N
% fxb  and xfb representent le même état.

% tri en place de chaque état de la liste L
sortStates([]).
sortStates([E|T]) :- sort(E),sortStates(T).
% sortStates([E|T]) :- sort(E),write(E),sortStates(T).  

% stateIn true if state E in liste N 
stateIn(E, N) :- sort(E), sortStates(N),member(E,N).

% 
plan(I,F,P,N) :- crossing(I,F), P=[] ;
		crossing(I,Z), write(P), \+ (stateIn(Z,N)), 
		N1=[I|N], plan(Z,F,P1,N1),P=[Z|P1].
		
% Q 7.4
plan(P) :- plan([f,x,g,b], [], P, []), write(P).
