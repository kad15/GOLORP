% The simplest case is that of an empty list. There’s just one possible permutation, the
% empty list itself
permu([],[]). % cas de base

%si la liste en entrée est n'est pas vide
% le sous but select réussit et unifie la var H avec un élement de List


% H est la tête de la liste de sortie et on appelle
% recursivement permu avec le reste de la liste d'entrée.
% La 1ere réponse à une requete reproduira simplement la liste
% car H sera tjrs affecté avec la valeur de la tete de liste.
% si davantage d'alternatives sont demandées cpdt le bacjktrack intervient
% dans le sub goal select, ie à chaque fois que H est instancié avec un autre elt
% de la liste L. ceci générera tous les ordres possibles de la liste d'entré L.
permu(L,[H|T]) :-
		select(H,L,R), % on enlève H de la liste L qui donne R
		permu(R,T). % la permutation de R est calculée pour donner  

% test : permu([3,1,5,4],P).		
% 2
% l'utilisation dans l'autre sens à savoir permu(P,[3,1,5,4]).
% donne un debordement de pile. 



 