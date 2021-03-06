%appartenance prolog fournit member()
%appartient(X,L).  % X objet, L liste

% X est membre de de L si 
% X est la tête de L ou si
% X est membre de la queue
appartient(X,[X,_]).
appartient(X,[_|T]):- appartient(X,T).
test:- appartient(a,[b,d,c]).

%concaténation conc(L1,L2,L3) L3 est la concat de L1 et L2

conc([],L,L). %cas liste vide 
% cas liste non vide. on a X L3 = X L1 L2
conc([X|L1],L2,[X|L3]):-conc(L1,L2,L3).

test1(L):- conc([a,b],[b,d,c],L).
test2(L1,L2):- conc(L1,L2,[a,b,c]).

% implé de member() en utilisant conc
% X member of list L si elle peut être décomposée en deux listes
% avec X tête de la seconde
member2(X,L):-conc(_,[X,_],L).

eff3d(L,L1):-   conc(L1,[_,_,_],L).                   %conc(L,L1,[_,_,_]).
eff3dp(L,L1):-   conc([_,_,_|L1],[_,_,_],L). 


%dernier(Objet,Liste)
der1(X,[X]).
der1(X,[_|L]):-der1(X,L).

% version avec conc

der2(X,L) :- conc(_,[X],L).

% effacer un objet X D'UNE LISTE L 
eff(X,[X|L],L).   % si X est le 1er de la liste le rsultat est la queue de la lsite
eff(X,[Y|T],[Y|T1]) :- eff(X,T,T1). % sinon on cherche à supprimer X dans la queue de la liste

inser(X,L,LL):- eff(X,LL,L).

member3(X,L):- eff(X,L,_).

%SOUS LISTE CONTINUE i.e cde et sous liste de abcdef mais ce n'est pas sous liste de abcdef

% principe S est sous liste de L si
%1 L peut se décomposer en 2 sous listes L1 et L2 et si
%2 L2 peut de decomp en deux liste S et L3
% ainsi L = l1+S+L3  et L2 = S + L3
%sousListe(S,L):- conc(L1,L2,L),conc(S,L3,L2).

sousListe(S,L):- conc(_,L2,L),conc(S,_,L2).
%sousListe(S,L):- 
%	conc(S,L3,L2).
	
%permutation permut(L,P)  P liste permutée de L
% si la 1er liste est vide alors P es tvide sinon
% alors elle est de la forme X|L et l'on peut construire 
% la permutation ; permuter L en premier ce qui donne L1
% puis insérer X à toutes les possition de L1
permut([],[]).
permut([X|L],P):-  permut(L,L1), inser(X,L1,P).  

permut2([],[]).
permut2(L,[X|P]):- eff(X,L,L1),permut2(L1,P).


% longueur pair d'une liste paire(L) est vrai si le nombre d'elt de L est pair
paire([]).
paire([_,_|T]):-paire(T).
% impaire
impaire(L):- \+paire(L).

%inverse d'une liste R liste retoournée de L
inv([],[]).
inv([X|T],R) :- inv(T,R1),conc(R1,[X],R). 


%palindrome(L)
pal(L):- inv(L,L).

%décale
decale([X|R],D):- conc(R,[X],D).

% traduction
vaut(0,zero).
vaut(1,un).
vaut(3,trois).
vaut(5,cinq).
trad([],[]).
trad([H|T],[H1|T1]):- vaut(H,H1),trad(T,T1).


%sous ensemble
contient([],[]).
contient([P|R],[P|S]):- contient(R,S). % cas ou les elt de tête sont identiques
contient([_|R],S):- contient(R,S).


%divliste
div([],[],[]).
div([X],[X],[]).
div([X,Y|L],[X|L1],[Y|L3]):- div(L,L1,L3).


%applatir ap transforme une liste de listes en une liste unique i;e liste applatie A 
ap([],[]). % applatir liste vide
ap(X,[X]). %applatir un elt qui n'est pas une liste
ap([Tete|Queue],ListePlate):-
	ap(Tete,TetePlate),
	ap(Queue, QueuePlate),
	conc(TetePlate,QueuePlate,ListePlate).
	








% 1.20 (*): Remove the K'th element from a list.
% The first element in the list is number 1.

% remove_at(X,L,K,R) :- X is the K'th element of the list L; R is the
%    list that remains when the K'th element is removed from L.
%    (element,list,integer,list) (?,?,+,?)

remove_at(X,[X|Xs],1,Xs).
remove_at(X,[Y|Xs],K,[Y|Ys]) :- K > 1, 
   K1 is K - 1, remove_at(X,Xs,K1,Ys).

% 1.22 (*):  Create a list containing all integers within a given range.

% range(I,K,L) :- I <= K, and L is the list containing all 
%    consecutive integers from I to K.
%    (integer,integer,list) (+,+,?)

range(I,I,[I]).
range(I,K,[I|L]) :- I < K, I1 is I + 1, range(I1,K,L).



% 1.23 (**): Extract a given number of randomly selected elements 
%    from a list.

% rnd_select(L,N,R) :- the list R contains N randomly selected 
%    items taken from the list L.
%    (list,integer,list) (+,+,-)

%:- ensure_loaded(p1_20).

rnd_select(_,0,[]).
rnd_select(Xs,N,[X|Zs]) :- N > 0,
    length(Xs,L),
    I is random(L) + 1,
    remove_at(X,Xs,I,Ys),
    N1 is N - 1,
    rnd_select(Ys,N1,Zs).
    
    
% 1.24 (*): Lotto: Draw N different random numbers from the set 1..M

% lotto(N,M,L) :- the list L contains N randomly selected distinct
%    integer numbers from the interval 1..M
%    (integer,integer,number-list) (+,+,-)


% importe un fichier prolog externe
%:- ensure_loaded(p1_22).
%:- ensure_loaded(p1_23).

lotto(N,M,L) :- range(1,M,R), rnd_select(R,N,L).

