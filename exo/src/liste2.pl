%  1 affiche(L) est vrai si tous les �l�ments de la liste L sont �crits.

affiche([]).
affiche([X|R]) :- write(X), nl, affiche(R).

% 2 affiche2(L) est vrai si tous les �l�ments de la liste L sont �crits en ordre inverse.

affiche2([]).
affiche2([X|R]) :- affiche2(R), write(X), nl.

% 3 Retrouver le premier �l�ment d'une liste : premier1(L,X) est vrai si X est le premier �lement de L.

premier1([X|_],X).

% 4 Afficher le premier �l�ment d'une liste (bis) : premier2(L) est vrai si le premier �l�ment de la liste L est affich� (et aucun autre).

premier2([X|_]) :- write(X),nl.

% 5 Retrouver le dernier �l�ment d'une liste : dernier1(L,X) est vrai si X est le dernier �lement de L.

dernier1([X],X).
dernier1([_|L],X) :- dernier1(L,X).

% 6 Afficher le dernier �l�ment d'une liste (bis) : dernier2(L) est vrai si le dernier �l�ment de la liste L est affich� (et aucun autre).

dernier2([X]) :- write(X),nl.
dernier2([_|L]) :- dernier2(L).

% 7 element(X,L) est vrai si X est �l�ment de la liste L.

element(X,[X|_]).
element(X,[_|R]) :- element(X,R).

%On peut l'utiliser sous la forme element(2,[1,3,5,8]) mais aussi element(X,[1,3,5,8]).
%En fait il existe un pr�dicat pr�d�fini en Prolog qui fait exactement la m�me chose : member(X,L), vrai si X est dans la liste L.


% 8 compte(L,N) est vrai si N est le nombre d'�l�ments dans la liste L.

compte([],0).
compte([_|R],N) :- compte(R,N1), N is N1+1, N>0.

% somme(L,N) est vrai si N est la somme des �l�ments de la liste d'entiers L.

somme([],0).
somme([X|R],N) :- somme(R,N1), N is N1+X.

%Attention, un pr�dicat somme(...) a d�j� �t� d�fini dans le TD n�2. Si vous rangez toutes vos d�finitions dans le m�me fichier cela va entra�ner des conflits. Dans ce cas il faut en renommer un des deux.
% nieme(N,L,X) est vrai si X est le N-�me �l�ment de la liste L.

nieme(1,[X|_],X) :- !.
nieme(N,[_|R],X) :- N1 is N-1, nieme(N1,R,X).

% occurrence(L,X,N) est vrai si N est le nombre de fois o� X est pr�sent dans la liste L.

occurrence([],_,0).
occurrence([X|L],X,N) :- occurrence(L,X,N1),N is N1+1.
occurrence([Y|L],X,N) :- X\==Y,occurrence(L,X,N).
%Fonctionne sous la forme occurrence([1,5,3,5,5,2,2,8],2,X) et, moins bien, sous la forme occurrence([1,5,3,5,5,2,2,8],X,2).

%sous-ensemble(L1,L2) est vrai si tous les �l�ments de la liste L1 font partie de la liste L2.

sous-ensemble([],_).
sous-ensemble([X|R],L2) :- element(X,L2),sous-ensemble(R,L2).

%On peut l'utiliser sous la forme sous-ensemble([1,2,8],[1,3,5,2,8]) et pas sous la forme sous-ensemble(X,[1,3,5,2,8]).

%substitue(X,Y,L1,L2) est vrai si L2 est le r�sultat du remplacement de X par Y dans L1.

remplace(_,_,[],[]).
remplace(X,Y,[X|R],[Y|R1]) :- remplace(X,Y,R,R1).
remplace(X,Y,[Z|R],[Z|R1]) :- X\==Z,remplace(X,Y,R,R1).

%retourne(L,L1) est vrai si la liste L1 est la liste L dans l'ordre inverse

retourne([],[]).
retourne([X|R],L1) :- retourne(R,R1),append(R1,[X],L1).


%factoriel
factoriel(0,1).
factoriel(1,1).
factoriel(N,F) :-  M is N-1,factoriel(M,R), F is (R * (M+1)).

%


