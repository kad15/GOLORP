% 1.26 (**):  Generate the combinations of k distinct objects
%            chosen from the n elements of a list.

% combinaison(K,L,C) :- C  est une combinaison de K elements de L


combinaison(0,_,[]). % cas de base si on choisit 0 element d'une liste qcq
% on a la liste vide sinon ...
combinaison(K,L,[H|T]) :- K > 0,
   sous_liste_droite(H,L,R), K1 is K-1, combinaison(K1,R,T).   
   % combinaison est vrai si K >0
   % si la sous-liste de L à droite de H est 


% el renvoie la sous liste à droite de l'élément X, X non inclus.
% seule la 1ere occurence de X est prise en compte?
%  el(a,[b,b,b,a,c,d,a,a],L). donne
% L = [c,d,a,a]  
sous_liste_droite(H,[H|T],T). % si H tete de liste, 
% la réponse est simplement la queue de liste
sous_liste_droite(H,[_|T],R) :- sous_liste_droite(H,T,R). 
% si H pas la tete de liste le prédicat est vrai si R est 
%la sous liste à droite de la tail T par rapport l'elt H
