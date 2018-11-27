%exo 2 
%m personnes, n journaux

% variables : temps de début de lecture pour chaque personnes et chaque journal => m * n

% base de faits et générer les contraint en lisant la base de faits

/*
variables : temps de de dedut de lecture pour chaque pers et chaque journal  ---> m * n

contraintes : pour chaque personne: pour chaque paires de journaux J1 J2:contraintes sur les heures => m * C n 2
--------------------------journal: -----------------------personne P1 P2: contrainte sur les heures => n * C m 2

pour l'objectif : minimioser le temps de fin de lecture max

on ajoute une var Tmax dont on veut minimiser la varet on ajoute m*n contrainte :
pour chaque personne 
pour chaque journal le tps de fin de lect <= Tmax




predicat récursif qui élimine les paires
*/


% base de faits
hreveil(a,0).
hreveil(b,15).
hreveil(c,15).
hreveil(d,60).


duree(a, g, 60).
duree(b, g, 75).
duree(c, g, 5).
duree(d, g, 90).

duree(a, m, 30).
duree(b, m, 3).
duree(c, m, 15).
duree(d, m, 1).

duree(a, p, 2).
duree(b, p, 15).
duree(c, p, 10).
duree(d, p, 1).

duree(a, t, 5).
duree(b, t, 10).
duree(c, t, 30).
duree(d, t, 1).


% contrainte
%variables : temps de 





% solition en prolog liste de tuples : [P, J, DPJ, FPJ] DPJ : debut 

% générer un predicat qui génère m*n tuples.
genere_tuple(L) :- findall( [P,J,DPJ,FPJ],duree(P,J,_),L).  

% findall(motif, but, listedesol)

% générer les contraintes récurssivement
% aff toutes les paires sans rep d'objet
P(L) :- L=[];
	L=[X|R],q(X,R),P(R).

	
	/*
q(X,L):- L=[];
	L=[Y|R], write([X,Y]),q(X,R).  % on poste les contraintess a la place du write
*/



q(X,L):- L=[];
	L=[Y|R], exclu(X,Y), q(X,R).  % on poste les contraintess a la place du write
	
exclu([P,J,DPJ1,FPJ1],[P,J,DPJ2,FPJ2]):- (P1=P2;J1=J2), (FPJ1 #=<DPJ2; FPJ2 #=< DPJ1).
%exclu(X,Y) :- 

/*fd_labelli,ng
*/
solution(L) :- generer_tuple(L),P(L),r(L,LV),fd_labeling(LV).

% pour minimiser introduire Tmax et poster les contraintes sur Tmax


% creation liste var
r(L,V) :- L=[];V=[];L[[_,_,D,F]|R];r(R,VR);V=[D, [F|VR]].


