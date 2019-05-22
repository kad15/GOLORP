% exo 2 sept 2015
% var de décisions Xij : flot du noeud i au noeud j

sol(L) :-
	L = [X12, X13, X14, X32, X43, X27, X36, X45, X62, X76, X65, X78, X68, X58],
	%domain
	fd_domain(L,0,5),
	% cstr sur les capacités
	 X12 #=<3,X13 #=<2,X14 #=<3,
	 X32#=<1, X43#=<2, X27#=<5, X36#=<1, X45#=<2, X62#=<4, X76#=<2, X65#=<2, X78#=<3, X68#=<1, X58#=<5,
	 % cstr kirchoff en chaque noeud
	 X12+X32+ X62 #= X27, X13+X43#=X36+X32,X14 #=X42+X45, X45+X65#=X58,X36+X76#=X65+X68+X62, X27#=X76 + X78,
	 Xmax #=X78+ X68+ X58,
	 Goal = fd_labeling(L),
	 fd_maximize(Goal, Xmax), nl,write('Flow max = '), write(Xmax),nl.
	 
	 % consult('C:/Users/toto/Desktop/max_flow.pl').
	 
	 sol2(L) :-
	L = [XSA, XSC, XAC, XAB, XAD, XCD, XDB, XDT, XBT],
	%domain
	%fd_domain(L,1,5),
	% cstr
	 XSA #=<10,XSC #=<10,XAC #=<2,
	 XAB#=<14, XAD#=<8, XCD#=<9, XDB#=<6, XDT#=<10, XBT#=<10,
	 XSA #= XAB+XAD+XAC, XSC+XAC  #= XCD, XAB +XDB #= XBT,
	 XAD+XCD #= XDB+XDT, 
	 Xmax #=XBT+XDT,
	 Goal = fd_labeling(L),
	 fd_maximize(Goal, Xmax), nl,write('Flow max = '), write(Xmax),nl.