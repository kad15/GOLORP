% RESUME : 

% findall et bagof se comportent de la même manière
% car ils donnent une liste non triée (elle est dans l'ordre des faits 
% de la base de données) et  avec doublons.
% mais findall ne connait pas la syntaxe "il existe" avec le ^.

% ci-dessous trouve tous les enfants qui possède un age
% testbagof(Results) :- bagof(Child, Age^age(Child,Age), Results).

% setof classe par ordre croissant les élements de la liste et 
% élimine les doublons






classe(a, voy).
classe(b, cons).
classe(c, cons).
classe(d, cons).
classe(e, voy).
classe(f, cons).

age(peter,7).
age(pat,8).
age(tom,5).
age(ann,5).
age(toto,5).
age(ann,5).

habite(jean, belfort).
habite(lucie, paris).
habite(christian, toulouse).
habite(adeline, paris).
habite(nicolas, paris).
habite(nicolas, paris).

enfants5bagof(L)   :- bagof(Child, age(Child,9), L).
enfants5setof(L)   :- setof(Child, age(Child,9), L).
enfants5findall(L) :- findall(Child, age(Child,9), L).

% si on n'a pas besoin d'une variables
% qui n'est pas le 1er argument de setof/3
% alors on peut utiliser la forme quivante
% qui se lit "trouve l'ens des enfants tel que
% l'enfant a un âge, peu importe ce dernier,( existence) 
% et met les resultats
% dans results.

% trouve tous les enfants qui ont un age
testsetof(Results) :- setof(Child, Age^age(Child,Age), Results).
testbagof(Results) :- bagof(Child, Age^age(Child,Age), Results).
% ne fonctionne pas avec findall
testfindall(Results) :- findall([Child,Age], age(Child,Age), Results).
% réponsz : L = [[peter,7],[pat,8],[tom,5],[ann,5],[toto,5],[ann,5]]
% on récupère la base de donnée sous forme de liste de listes
% trouve tous les enfants pour lesquels il existe un âge.
