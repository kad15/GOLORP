%suffixe d'une liste ie sous liste finissante
suf(L,L).
suf(S,[_|L]) :- suf(S,L).

arc(a,b).
arc(b,c).
arc(b,d).
path(X, Y) :- arc(X,Y);arc(X,Z), path(Z,Y).


conc([],L,L).
conc([X|L], M, [X|N]) :- conc(L,M,N).

% effacer la 1ere occurrence d'un objet dans une liste : delete = del/3
del(X,[X|L],L).
del(X,[Y|L],[Y|M]) :- del(X,L,M).
%  delete une des occurences 
%  del(X,[Y|L],[Y|M]) :- del(X,L,M)

% effacer toutes les occurrence d'un objet dans une liste : delete tout = delt/3
delt(_,[],[]).
delt(X, [X|L],R) :-  delt(X,L,R),!.
delt(X, [Y|L],[Y|M]) :-  delt(X,L,M).
 
% sous liste
%sub(L,L).
sub(S,L) :- conc(_,L2,L),conc(S,_,L2). 

% conseq/3 vrai si les elt x et y sont conseq dans L1
conseq(X,Y,[X,Y|_]).
conseq(X,Y,[_|L]) :- conseq(X,Y,L).

conseq2(X,Y,L) :- member(X,L),member(Y,L),conc(_,[X|_],R),conc(R,[Y|_], L).

%conseq2(a,b, [c,d,e, a, e,r,t,b, q,s]).

conseq3(X,Y,L):- sub([X,Y],L).

% random(a,b,X) donne un nombre al�atoire de a � b-1 inclus et le met dans X

% 3eme arg = liste nbr choisis
%decomp d'un entier S donn� en choississant des nbr ds une liste
%cpt(7,[1,2,3,4,5,6],R).
% r�soudre ce probl�me c'est r�soudre le probl�me avec liste L \X et nouvel entier T = S-X
cpt(S,L,R) :- cpt(S,L,[],R).
cpt(0,_, R, R).
cpt(S, L, LC, R):- del(X, L, LS), /* on retire X de la liste */
				X =< S,
				T is S - X,
				cpt(T, LS, [X|LC], R). 
				
				
% moy([12,14], M).				
moy(L,N) :- moyenne(L,0,0,N).
moyenne([],N,S,M) :- M is S/N.
moyenne([X|L], N,S,M) :-SS is S+X, NS is N+1, moyenne(L , NS, SS,M).


% inversion en O(n**2)
inv([],[]).
inv([X|L], M) :- inv(L,M1), conc(M1,[X],M). 

% inversion avec un 3eme buffer et deux predicat
inv([],R,R). % inverse de 
inv([X|D], T,R):- inv(D, [X|T], R).
inverse(L,R) :- inv(L,[],R).

