% exam 2018
% exo 1
% 1.1 permu/2).
ins(X,L,[X|L]).
ins(X,[Y|T1],[Y|T2]) :- ins(X, T1, T2).

% si la 1er liste est vide alors la seconde également
% si la liste est non vide de la forme X|L on permute L
%et on insere X dans L

%introspection avec var/1 pour symétriser la permutation
permu([],[]).
permu([X|L], P):- nonvar(X),permu(L,R), ins(X,R,P).
permu([X|L],P):-var(X),permu(P,[X|L]).

% 2 - stack overflow. l'utilisation du predicat trace. montre
%que la permutation se fait sur une liste de plus en longue 
% constituée de valeurs non instanciées
%la récursion se fait sur la 1ere liste qui doit donc être instanciée 
% i.e. permu([1,2],P)

% 3 - sorted

sorted([]).
sorted([_]).
sorted([X,Y|L]):- X =< Y, sorted([Y|L]).
 

%4 - permusort/2
permusort([X],[X]).
permusort(L,S) :- permu(L,S),sorted(S).

% 5 - complexité : dans le pire cas, l'algo test n! permutation et chaque
% test de tri avec sorted se fait en O(n) on a donc une complexité temporelle
% en O(n*n!) (catastrophique comparée à l'optimale O(n lg n)) 


% EXO 2 
address(family(homer,marge,c(bart,c(lisa,c(maggie,none)))), usa).
address(family(gabriel, isabelle, c(paul,c(laetitia, c(jules,none)))),sevres).
address(family(loulou, line,none),paris).
%1 - 
husband(H) :- address(family(H,_,_),_).


%2
%member2(X, [X|_]).
%member2(X, [_|T]):- member2(X,T).
%child_list(none). % list vide
%child_list(c(X,T)) :- child_list(T). % 


dans(X, c(X,_)). % dans la tête de liste
dans(X, c(_,T)) :- dans(X,T). % enfant dans la queue de liste
%child(X):-  c(X,none). % cas de l'enfant unique
%child(X) :- c(X,_). % X est la tête de liste
%child(X) :- c(_,T), dans(X,c(_,T)).  % X est dans la queue
 

% pour que ce soit un enfant il faut qu'il app a la structure famille
% et qu'il soit un ensemble d'enfants de type c(x,y)
child(X) :- address(family(_,_, Z ),_), dans(X,Z).

%3 lives_at/2
wife(W) :- address(family(_,W,_),_).
person(X) :- wife(X); husband(X);child(X).

lives_at(P, City) :- address(family(_,_,_),City), person(P).

%4 married/2
                    
married(H,W) :- address(family(H,W,_),_).


%5] same/2 2 argument de type family 
% same( family(homer,marge,c(bart,c(lisa,c(maggie,none)))), F ).
listify(c(X,none), [X]).
listify(c(X,T),L) :- listify(T,Q), L = [X|Q].
% listify(c(X,T),L) :- listify(T,Q), L = [X|Q].
% same(F1,F2) :- F1 = family(H1,W1,Z1),
				% F2 = family(H2,W2,Z2), H1=H2, W1=W2, 
				% listify(Z1,L1),msort(L1,S1),
				% listify(Z2,L2), msort(L2,S2),S1=S2.
				

same(F1,F2) :- F1 = family(H1,W1,Z1),
				F2 = family(H2,W2,Z2), H1=H2, W1=W2, 
				listify(Z1,L1),
				listify(Z2,L2), permutation(L2,P2),L1=P2.	



%EXO 3	Hanoi
%3.1 validState/1 sur les 3 tiges les list sont ordonnées
% sorted([]).
% sorted([_]).
% sorted([X,Y|L]):- X =< Y, sorted([Y|L]).

validState([L,M,R]) :- sorted(L), sorted(M), sorted(R).
 
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
	
	
 
 