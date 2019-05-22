% consult('C:/Users/toto/Desktop/findall_bagof_setof.pl').
% ***************************************************
%findall(+Motif, + But, -Liste)

classe(a, voy).
classe(b, cons).
classe(c, cons).
classe(d, cons).
classe(e, voy).
classe(f, cons).

age(peter,7).
age(ann,5).
age(pat,8).
age(tom,5).
age(ann,5).

habite(jean, belfort).
habite(lucie, paris).
habite(christian, toulouse).
habite(adeline, paris).
habite(nicolas, paris).
habite(nicolas, paris).
% crée dans la liste R avec les var X 
% pour lesquels le predicat habite est vrai.
% "Trouve tous ceux qui habitent Paris.
% findall(X, habite(X,paris), R).
% R = [lucie,adeline,nicolas,nicolas]
%bagof(X, habite(X,paris), R). donne le meme resultat
%setof élimine les doublons
%R = [adeline,lucie,nicolas]

% ***************************************************
% bagof

% bagof(+Motif, +But, -Liste)
% Se comporte comme findall/3, à la différence que:
% - bagof/3 échoue si But n'a pas de solution
% - a un comportement différent concernant 
%les variables libres de Motif (voir plus
% loin)



%liste des enfants de 5 ans 
enfants5ans(L) :- bagof(Child, age(Child,5), L).


% bagof(Z, classe(Z,cons), R).
% R = [b,c,d,f]

% bagof(Z, classe(Z,Type), R).
% R = [b,c,d,f]
% Type = cons ? a
% R = [a,e]
% Type = voy

% findall(Z, classe(Z,cons), R).
% R = [b,c,d,f]

% si pas de solutions findall renvoie liste vide
%findall(Z, classe(Z,toto), R).
% R = []
% mais bagof renvoie faux i.e. echoue comme setof/3
%bagof(Z, classe(Z,toto), R).
% no


% ***************************************************
% setof(+Motif, +But, -Liste)
% SETOF = BAGOF MAIS AVEC SUPPRESSION DES DOUBLONS ET
% LISTE ORDONNEE 
% Se comporte comme bagof/3, à la différence que:
% - il y a suppression des doublons
% - les résultats sont triés en utilisant 
%le prédicat sort/2

% age(peter,7).
% age(ann,5).
% age(pat,8).
% age(tom,5).
% age(ann,5).

test(Allresults) :- 
setof(Age/Children,
  setof(Child,age(Child,Age),Children), 
  Allresults
  ).

% si on n'a pas besoin d'une variables
% qui n'est pas le 1er argument de setof/3
% alors on peut utiliser la forme quivante
% qui se lit "trouve l'ens des enfants tel que
% l'enfant a un âge, peu importe ce dernier,( existence) 
% et met les resultats
% dans results.
test2(Results) :- setof(Child, Age^age(Child,Age), Results).
% trouve tous les enfants pour lesquels i lexiste un âge.