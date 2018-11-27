/*
PL flot max sur une graphe G=(S,A):
max somme Xsu pour (s,u) in Ac
s.t.
somme Xuv = somme Xvu pour tout u dans S\{s,t}
0<=Xuv<=Cuv  pourtout (u,v) dans A
-----------------
Xuv flot dans l'arc uv de capa Cuv
*/

sol(L) :- 
	L=[X12, X13, X14,X32,X43,X27,X62,X36,X45,X76,X65,X78,X68,X58],
	fd_domain(L,0,5),  /* Domaine de 0 à 5, 5 étant la capa max du graphe */
	/*ctr : de capacité */
	X12 #<= 3, X13 #<=2, X14#<=,X32#<=,X43#<=,X27#<=,X62#<=,
	X36#<=1,X45#<=2,X76#<=2,X65#<=2,X78#<=3,X68#<=1,X58#<=5,
	/*ctr de conservation de flux */
	X12 + X32 + X62 #= X27,  /* conservation au noeud 2   */
	
	/*objectif */
	Flot #= X12+X13+X14,
	fd_maximize(fd_labeling(L), Flot).