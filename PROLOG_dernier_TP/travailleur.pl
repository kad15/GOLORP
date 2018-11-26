% avec variables booléennes : Xij = si travailleur i réalise le produit j
% modélisation : variables V, Domaine D et Contraintes C
sol(L) :- L=[X11, X12, X13,X14,X21,X22,X23,X24,X31,X32,X33,X34,X41,X42,X43,X44],  
			fd_domain_bool(L),  /* Domaine boolean */
			/*ctr : chaque travailleur n'a qu'un produit */
			X11+X12+X13+X14 #= 1, 
			X21+X22+X23+X24 #= 1,
			X31+X32+X33+X34 #= 1,
			X41+X42+X43+X44 #= 1,
			/* ctr : chaque produit est réalisé par un seul travailleur1*/
			X11+X21 +X31+X41 #= 1,   
			X11+X21 +X31+X41 #= 1, 
			X11+X21 +X31+X41 #= 1,
			X11+X21 +X31+X41 #= 1,
			/*objectif */
			Profit #= 7 * X11 + 1 * X12 + 3 * X13 + 4 * X14 +8 * X21 + 2 * X22 + 5 * X23 + 1* X24 +4 * X31 + 3 * X32 + 7 * X33 + 2 * X34 +3 * X41 + X42 + 6 * X43 + 3 * X44,
			fd_maximize(fd_labelling(L), Profit).
			
/*
fd_minimize(Goal, X) repeatedly calls Goal to find a value that minimizes 
the variable X. Goal is a Prolog goal that should instantiate X, 
a common case being the use of fd_labeling/2 (section 9.9.1)

fd_labeling(Vars, Options) assigns a value to each variable X 
 of the list Vars according to the list of labeling options given by Options. 
*/
%résolution
%fd_maximize(fd_labelling(L), Profit)

% travailleur 1 affecté à 1, 2 à 2, etc 
% 4 1 2 3  w1 fait le prod 4, 1 fait 2,
% profit max = 19