% exam 2018
% exo 1 
% 1.1 permu/2).
member2(X, [X|_]).
member2(X, [_|T]):- member2(X,T).

dernier(X,[X]).
dernier(X,[Y|T]) :- dernier(X,T). 

eff(X,[X|T],T).
eff(X,[Y|T],[Y|Q]):- eff(X,T,Q). 
%concat = append si le 1a 1ere liste est vide
% on a le rsultat qui est L sinon elle possède une tete et une
%queue comme suit
conc([],L, L).
conc([X|P], Q, [X|R]) :- conc(P, Q, R).

reverse([],[]).
reverse([X|L],R) :- reverse(L,Q), conc(Q,[X],R).

member3(X,L) :- conc(_,[X|_],L).

ins(X,L,[X|L]).
ins(X,[Y|T1],[Y|T2]) :- ins(X, T1, T2).

inser(X, R, L) :- eff(X, L, R).  %conc(_, [X|_],L). 
% si la 1er liste est vide alors la seconde également
% si la liste est non vide de la forme X|L on permute L
%et on insere X dans L
permu([],[]).
permu([X|L], P):- permu(L,R), inser(X,R,P).

% methode 2 : on enlève l'elt X de la liste L et on permute
% la liste privée de X obtenue et 
%on rajoute X en tete de la liste permutée
permu2([],[]).
permu2(L,[X|P]) :-  eff(X,L,Q), permu2(Q,P).

 
