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
	
	
 
% EXO 4 : PPC
% Xij = 1 if task i executed on machine j : vars, domain, cstr, filter/search
% produit terme à terme de deux listes rangés dans une liste
prodtt_list([],[],[]).
prodtt_list([X|Tx], [Y|Ty], P) :- Z is X * Y, P = [Z|P1], prodtt_liste(Tx,Ty,P1).

%max_prod[X,Y,M] :- prodtt_list(X,Y,P), max_list(P,M). 

sol_ppc(L,StartTimes) :- 
  % vars
  L=[ X11, X21, X31, X41, X51, X61, X71,
	  X12, X22, X32, X42, X52, X62, X72,
	  X31, X23, X33, X43, X53, X63, X73 ],
  % boolean domain of the vars 	  
  fd_domain_bool(L),
  % start time of each task
  StartTimes = [T1,T2,T3,T4,T5,T6,T7],
  %domain integer.
  fd_domain(StartTimes, 0, 9),
  append(L,StartTimes,Vars),
  % cstr one task per machine : 
  % task i can't be executed on more than one machine j
  % but several tasks can be/have to be assigned to one machine
  X11 + X12 + X13 #= 1,
  X21 + X22 + X23 #= 1,
  X31 + X32 + X33 #= 1,
  X41 + X42 + X43 #= 1,
  X51 + X52 + X53 #= 1,
  X61 + X62 + X63 #= 1,
  X71 + X72 + X73 #= 1,
  % Objective function z = OverallEndTime = max on j ( sum on i( Xij * Di) ) 
  % end time is the max of times used by each machine to process the assigned tasks 
  Time1 #= 10 * X11 + 9 * X21 + 7 * X31 + 4 * X41 + 8 * X51 + 7 * X61 + 20 * X71,
  Time2 #= 10 * X12 + 9 * X22 + 7 * X32 + 4 * X42 + 8 * X52 + 7 * X62 + 20 * X72,
  Buffer #= max(Time1, Time2),
  Time3 #= 10 * X13 + 9 * X23 + 7 * X33 + 4 * X43 + 8 * X53 + 7 * X63 + 20 * X73,
  OverallEndTime #= max(Buffer, Time3),
  % precedence cstr 
  % t3 finish before start t4
  T3 + 7 #=< T4,
  % t2 finish before t5 finishes
  T2 + 9 #=< T5 + 8,
  T1 #= 0, T2 #=0, T6 #=0,T7#=0, % ajout de cstr pour limiter le nb de solution
  % Goal : constraint propagation 
  % Goal = fd_labeling(Vars),   
% Goal = fd_labeling(Vars, [variable_method(ff)]), 
Goal = fd_labeling(Vars, [variable_method(most_constrained), value_method(max)]),
% Le predicat fd_minimize utilise un B&B avec redémarrage :
% A chaque succès de l'appel de Goal, 
% i.e. l'instanciation complète des variables 
% respecte toutes les contraintes, 
% Il calcule la valeur V de la fonction objectif z = OverallEndTime
% et redémarre le B&B  
% avec l'ajout de contrainte OverallEndTime #< V
% Quand un echec apparait, soit parce 
% qu'il n'y a plus de choix possible pour Goal,
% soit parce que la contrainte ajoutée 
% est inconsistante avec le reste des contraintes
% la dernière solution est alors recalculée et fournit l'optimale z*.
  Z #= OverallEndTime + T4 + T5,  % ajout de 
  fd_minimize(Goal, Z),nl, write('OverallEndTime = '), write(OverallEndTime), nl, write('Vars = '), write(Vars).
  

  
% variable_method(V): specifies the heuristics to select the variable to enumerate:
% standard: no heuristics, the leftmost variable is selected.
% first_fail (or ff): selects the variable with the smallest number of elements in its domain. If several variables have the same number of elements the leftmost variable is selected.
% most_constrained: like first_fail but when several variables have the same number of elements selects the variable that appears in most constraints.
% smallest: selects the variable that has the smallest value in its domain. If there is more than one such variable selects the variable that appears in most constraints.
% largest: selects the variable that has the greatest value in its domain. If there is more than one such variable selects the variable that appears in most constraints.
% max_regret: selects the variable that has the greatest difference between the smallest value and the next value of its domain. If there is more than one such variable selects the variable that appears in most constraints.
% random: selects randomly a variable. Each variable is chosen only once.
% The default value is standard.
%
% reorder(true/false): 
%
% specifies if the variable heuristics should dynamically 
% reorder the list of variable (true) or not (false). 
% Dynamic reordering is generally more efficient 
% but in some cases a static ordering is faster. The default value is true.
%
% value_method(V): 
%
% specifies the heuristics to select the value to assign to the chosen variable:
% min: enumerates the values from the smallest to the greatest (default).
% max: enumerates the values from the greatest to the smallest.
% middle: enumerates the values from the middle to the bounds.
% bounds: enumerates the values from the bounds to the middle.
% random: enumerates the values randomly. Each value is tried only once.
% bisect: recursively creates a choice between X #=< M and X #> M, where M is the midpoint of the domain of the variable. Values are thus tried from the smallest to the greatest. This is also known as domain splitting.
% The default value is min.

% backtracks(B): unifies B with the number of backtracks during the enumeration.
% fd_labeling(Vars) is equivalent to fd_labeling(Vars, []).

% fd_labelingff(Vars) is equivalent to fd_labeling(Vars, [variable_method(ff)]).

sol_ppc1(L,OverallEndTime) :-  
  L=[ X11, X21, X31, X41, X51, X61, X71,
	  X12, X22, X32, X42, X52, X62, X72,
	  X31, X23, X33, X43, X53, X63, X73 ],
  % boolean domain of the vars 	  
  fd_domain_bool(L),
  % cstr one task per machine : 
  X11 + X12 + X13 #= 1, X21 + X22 + X23 #= 1,
  X31 + X32 + X33 #= 1, X41 + X42 + X43 #= 1,
  X51 + X52 + X53 #= 1, X61 + X62 + X63 #= 1,
  X71 + X72 + X73 #= 1,
  % Objective function z = OverallEndTime = max on j ( sum on i( Xij * Di) ) 
  % end time is the max of times used by each machine to process the assigned tasks 
  Time1 #= 10 * X11 + 9 * X21 + 7 * X31 + 4 * X41 + 8 * X51 + 7 * X61 + 20 * X71,
  Time2 #= 10 * X12 + 9 * X22 + 7 * X32 + 4 * X42 + 8 * X52 + 7 * X62 + 20 * X72,
  Buffer #= max(Time1, Time2),
  Time3 #= 10 * X13 + 9 * X23 + 7 * X33 + 4 * X43 + 8 * X53 + 7 * X63 + 20 * X73,
  OverallEndTime #= max(Buffer, Time3),
  Goal = fd_labeling(L, [variable_method(most_constrained), value_method(max)]),
  fd_minimize(Goal, OverallEndTime).
  
 sol_ppc2(L,StartTimes) :-  
  sol_ppc1(L,OverallEndTime),!, 
  StartTimes = [T1,T2,T3,T4,T5,T6,T7],
  fd_domain(StartTimes, 0, OverallEndTime),
  append(L,StartTimes,Vars),
  % precedence cstr 
  T3 + 7 #=< T4,
  T2 + 9 #=< T5 + 8,
  % T1 #= 0, T2 #=0, T6 #=0,T7#=0, % ajout de cstr pour limiter le nb de solution
Goal = fd_labeling(Vars, [variable_method(most_constrained), value_method(max)]),  

Z#=  OverallEndTime +T1+T2+T3+T4+T5+T6+T7,
fd_minimize(Goal, Z),nl, write('OverallEndTime = '), write(OverallEndTime), nl, write('Vars = '), write(Vars). 