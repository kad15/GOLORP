% exam 2018

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