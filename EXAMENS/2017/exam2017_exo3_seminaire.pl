% exo 3 seminaire

% 3.1
% problème de type graphe coloring
 % on trace le graphe avec les noeuds = séminaires
 % Les aretes existent entre noeuds si les horaires 
 % se recouvrent. ainsi les salles correspondent 
 % aux couleurs.
sol(L) :- L=[A,B,C,D,E,F],
	fd_domain(L,1,4),
	fd_all_different([A,B,C]), % clique ABC
	fd_all_different([D,E,F]),
	A #\=D, A#\=E, 
	Goal = fd_labeling(L),
	MaxAB #= max(A,B), MaxCD #= max(C,D), MaxEF #= max(E,F),
	Max1 #= max(MaxAB,MaxCD), Max #= max(Max1, MaxEF),
	% Obj #= A+B+C+D+E+F,
	fd_minimize(Goal,Max), nl, write('Number of rooms used : '), write(Max).

%test  L=[A,B,C,D,E,F], sol(L).

% 3.2 

sol(L) :- findall(N, client(N,A,D), L), 
	fd_domain(L,1,70).
	% cstr
	