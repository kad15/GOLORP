
% prolog exam 2018

% exo 1
%1.1
% effacer un objet X D'UNE LISTE L 
eff(X,[X|L],L).   % si X est le 1er de la liste le resultat est la queue de la lsite
eff(X,[Y|T],[Y|T1]) :- eff(X,T,T1). % sinon on cherche Ã  supprimer X dans la queue de la liste

permu([],[]).  % cas de base
permu(L,[X|P]):- eff(X,L,L1),permu(L1,P). % la permutation d'une liste est la permutation de sa queue

%1.2  Programme non symétrique ; on a débordement de pile.
% récursion noon terminale

%1.3 : sorted/1 si trié
sorted([X]).
sorted([X,Y|L]):- X =< Y, sorted(L),!. 


%1.4
permusort([X],[X]).
permusort(L1,L2) :- sorted(L1), L2 = L1.
% trier L1  c'est trier la queue de L1 
permusort(L1, L2) :-  permu(L1, L), sorted(L), permusort(L, L2),L2=L.


% exo 2
%2.1 
family(homer, marge, none).
husband(H):- family(H,_,_).

%2.2
child(X):-family(_,_,c(X,none)) ; family(_,_,c(X,Y)),child(Y).

%2.3
husband(H):- family(H,_,_).
wife(W):- family(_,W,_).
personne(P):-husband(P) ;  wife(P) ; child(P).

live_at(P,V) :- personne(P), address(family(P,W,child), V).





%exo 3 tour de hanoi

%3.1
% S est valide si les 3 listes sont dans l'ordre croissant
valideState(S):- S=[L1, L2, L3], sorted(L1),sorted(L2),sorted(L3).

%3.2 
% M R1 R2 
validMove(S,M,R) :- M 






%exo 4 :

%4.1
sol(L) :- L=[X11, X12, X13,X21, X22, X23,X31, X32, X33,X41, X42, X43,X51, X52, X53,X61, X62, X63,X71, X72, X73],  
			fd_domain_bool(L),  /* Domaine boolean des variables */
			/*ctr */
			
			/*objectif */
			Endtime #=10*(X11+X12+X13)+
			9*(X21+ X22+ X23)+
			7*(X31+ X32+ X33)+
			4*(X41+ X42+ X43)+
			8*(X51+ X52+ X53)+
			7*(X61+ X62+ X63)+
			20*(X71+ X72+ X73) ,
			fd_minimize(fd_labeling(L), Endtime).

%4.2




