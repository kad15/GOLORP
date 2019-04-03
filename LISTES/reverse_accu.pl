% inversion d'une liste avec uccumulateur 
 rev([],Toto, Toto). %cas d'arret lorsque liste L vide accu = resultat
rev([H|T], A, R) :-  rev(T,[H|A],R). % on acumule les ttête de liste dans l'accu
rev(L,R) :- rev(L,[], R). % on appel rev/3 avec un accu vide