% exam 2018

% EXO 2 
address(family(homer,marge,c(bart,c(lisa,c(maggie,none)))), usa).
address(family(gabriel, isabelle, c(paul,c(laetitia, c(jules,none)))),sevres).
address(family(loulou, line,none),paris).
%1- 
husband(H) :- address(family(H,_,_),_).

 
% 2-  child(X) est vrai si X est present dans la structure récursive c(X,Y)% pour que X soit un enfant il faut 
%qu'il appartienne à la structure "address(famille ..."
%dans la position réservée aux enfants notée Z
% et qu'il appartienne à Z, structure recursive qui 
% est soit none soit de la forme c(x,y)

child(X) :- address(family(_,_,Z),_), dans(X,Z).
dans(_,none):-!,fail. % si Z=none pas d'enfants donc on peut pruner l'arbre
dans(X,c(X,_)). % soit X est dans la tete x de la structure c(x,y)
dans(X, c(_,Y)) :- dans(X,Y). % soit X est dans la queue y de la structure c(x,y)


%3- lives_at/2

% W est une épouse si elle est présente dans la position
% prévue dans le prédicat address(family( ....
wife(W) :- address(family(_,W,_),_).
% une personne est soit un mari, soit une épouse, soit un enfant
person(X) :- wife(X); husband(X);child(X).

% P vit dans la ville City si P est une personne et fait partie du prédicat address(......., City) 
lives_at(P, City) :- person(P),address(family(_,_,_),City).

%tests
% lives_at(homer,usa).

%4 -  married/2 : married(
                    
married(H,W) :- address(family(H,W,_),_). % H est marié à W
married(W,H) :- address(family(H,W,_),_). % et reciproquement

%5- same/2 : same(Famille1, Famille2) est vrai si
% Famille1 et Famille2 sont les mêmes à l'ordre près des enfants 
% same( family(homer,marge,c(bart,c(lisa,c(maggie,none)))), F ).

% on transforme la structure c(x,y) en .(x,y) = [X|Y] avec none=[]
listify(c(X,none), [X]). % cas du singleton [X,[]] = [X]
listify(c(X,T),L) :- listify(T,Q), L = [X|Q]. % on transforme
% T qui a une structure C(x',y') en la liste Q à laquelle on ajoute
% X qui décrit un enfant.  
same(F1,F2) :- F1 = family(H1,W1,Z1),
				F2 = family(H2,W2,Z2), % F1 et F2 doivent être des familles
				H1=H2, W1=W2, % avec les mêmes parents 
				listify(Z1,L1), 
				listify(Z2,L2), % transformation en liste d'enfants 
				permutation(L1,P2), L2=P2. % vrai si la liste d'enfants
% 				de la famille 2 s'identifie aux permutations de L1
		
% test 
% same(family(homer,marge,c(bart,c(lisa,c(maggie,none)))), F).
