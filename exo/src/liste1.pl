%der(X,[X]).  % cas de base : l'element est le dernier car le seul de la liste
%der(X,[_|R]) :- write('toto'),nl, der(X,R). 


% true if X elt de L
%soit X est la tete de liste

%appartient(X,[X|_]). % soit X est en tete de liste
%appartient(X,[_|R]) :- appartient(X,R). % soit X est dans la queue

% appartenance � une liste
%membre(X, [X|_]).  % soit X est en t�te de liste
%membre(X, [_|T]) :- membre(X, T). % soit il est dans la queue de liste (Tail)
%mem(X, [H|T]) :- X = H; mem(X, T). % member en une ligne


% calcul les solutions d'un trinome du 2nd degr� 
%quad(A,B,C,X) :- DELTA is sqrt(B*B - 4*A*C), (X is (-B + DELTA)/(2*A) ;X is (-B - DELTA)/(2*A)) .





% soit on ajoute une liste vide � une liste L qcq et on obtient L
% soit on ajoute une liste non vide H|T � la liste r�sultat qui on aura donc la forme H|T+L2
% r�sonnement par r�currence : le cas de base est le cas n=0 qui assure que le programme termine
% ici on pr�l�ve la t�te de liste H de la 1er liste qui va donc finir par �tre vide
% ce qui appelle le cas de base et on aura la 3eme liste qui sera initialis�e � la 2nd liste L2
%connaisant L2 on d�pile   et on ajoute � gauche de l2 les elements de L1 dans l'odre inverse.
% on doit r�sonner math�matiquement : l'hypoth�se de recurrence est situ�e � droite de la r�gle
% qui peut se lire de droite � gauche comme une implication.
% � droite, on suppose donc connu le r�sultat de la concat d'une liste T avec une liste L2 qui donne
% donc L3= T+L2 et pour obtenir la liste au rang suivant il suffit d'avoir une premier liste L1= H|T 
% L2 ne change pas et la 3eme liste doit aussi avoir H comme rpemier �lement et donc 
% le reste doit �tre de la forme H|L3 = H|T+L2, qu'on a calcul� pr�c�demment ou qu'on a suppos� vrai ou calculable
%precedemment. 
app([],L,L).
app([H|T],L2,[H|L3])  :-  app(T,L2,L3).

%****************************************************************************************************************
%sous liste sl tel que les elements de la premi�re se trouvent ds la 2nd
% dans l'ordre de la premi�re mais pas n�cessairement successivment
%sl([1,2,3], [2,5,8]).  false
%sl([1,2,3], [1,5,6,4,2,5,8,3,7,7,7]).=> true



%sl([],_).
%sl([X|L1],[X|L2]):- sl(L1,L2).
%sl(L1,[_|L2]):- sl(L1,L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%sl([1,2,3], [2,5,8]).  false
%sl([1,2,3], [1,3,2,5,8,3,7,7,7]). => true

sl([],_). % cas de base
sl([H|L1],[H|L2]):-sl(L1,L2). % 1er elements des deux listes �gaux
sl(L1,[_|L2]):-sl(L1,L2).  % 

%vrai si tous les �l�ments de la liste L sont �crits.

affiche([]).
affiche([X|R]) :- write(X), nl, affiche(R).

%donne l'inverse d'une liste
inverse([],[]).
inverse([H|T], I) :- inverse(T,R), app(R,[H],I).

%vrai si dernier elt de la Liste est X
dernier1([X],X).
dernier1([_|T],X) :- dernier1(T,X). % si X est le dernier element de la 
%queue T alors le dernier elt de la liste L = _|T est aussi X

%Afficher le dernier �l�ment d'une liste (bis) : dernier2(T) est vrai 
%si le dernier �l�ment de la liste L est affich� (et aucun autre).

dernier2([X]) :- write(X),nl. % si la liste est un singleton le dernier elt est ce singleton
dernier2([_|T]) :- dernier2(T).% si le dernier elt de T  est vrai/connu alors c aussi celui de la liste entiere
% la liste L=_|T est lue r�cursivement, on extrait r�cursivement le 1er elt de L 


%7-element(X,L) est vrai si X est �l�ment de la liste L.

element(X,[X|_]).
element(X,[_|R]) :- element(X,R).

%sous-ensemble(L1,L2) est vrai si tous les �l�ments de la liste L1 font partie de la liste L2.
sous-ensemble([],_).
sous-ensemble([X|R],L2) :- element(X,L2),sous-ensemble(R,L2).

%13 substitue(X,Y,L1,L2) est vrai si L2 est le r�sultat du remplacement de X par Y dans L1.
substitue(_,_,[],[]).
substitue(X,Y,[X|R],[Y|R1]) :- substitue(X,Y,R,R1).
substitue(X,Y,[Z|R],[Z|R1]) :- X\==Z, substitue(X,Y,R,R1).






















