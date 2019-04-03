% inversion d'une liste avec uccumulateur 
 rev([],Toto, Toto). %cas d'arret lorsque liste L vide accu = resultat
rev([H|T], A, R) :-  rev(T,[H|A],R). % on acumule les ttête de liste dans l'accu
rev(L,R) :- rev(L,[], R). % on appel rev/3 avec un accu vide

%true if X is the last elt of list L
% X dernier elt si L est le singleton X sinon le dernier elt est dans la queue
is_last(X,L):- L=[X]; 
				L=[_|T], is_last(X,T).

last_(X,[X]). % soit 
last_(X,[_|T]):-last_(X,T).
				
%member1(X,L) is true if X is elt of L
% X membre de L si la tete de liste vaut X ou si X est dans la queue
member1(X,L) :- L=[X|T]; L=[_|T], member1(X,T). 

mem2(X,[X|_]). % case X is the head of the list
mem2(X,[_|T]):- mem2(X,T). 

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

% random(a,b,X) donne un nombre aléatoire de a à b-1 inclus et le met dans X

% 3eme arg = liste nbr choisis
%decomp d'un entier S donné en choississant des nbr ds une liste
%cpt(7,[1,2,3,4,5,6],R).
% résoudre ce problème c'est résoudre le problème avec liste L \X et nouvel entier T = S-X
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
	


length(L,n):-
% vrai si N est la longueur de la liste L        [a,b,c],res
   L=[_|R],length(R,M),
   N is M+1;
   L=[],N=0.
   
length(L,N):-
  N>0, M is N-1,
  length(LL,M);
  N=0,L=[]





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


% liste /1
liste([]).
liste([ _ | Q ]) : - liste( Q ).

% premier /2
premier(X ,[ X | _ ]).

% dernier /2
dernier(X ,[ X ]).
dernier(X ,[ _ | Q ]) : - dernier(X , Q ).

% nieme /3
nieme(1 ,T ,[ T | _ ]).

nieme(N ,X ,[ _ | Q ]) : - nieme(M ,X , Q ) , N is M + 1.

% longueur /2
longueur(0 ,[]).
longueur(N ,[ _ | Q ]) : - longueur(M , Q ) , N is M + 1.

% dans /2
dans(X ,[ X | _ ]).
dans(X ,[ _ | Q ]) : - dans(X , Q ).

% hors /2
hors(X ,[]) : - nonvar( X ).
hors(X ,[ T | Q ]) : - X \== T , hors(X , Q ).

% suivants /3
suivants(X ,Y ,[ X , Y | _ ]).
suivants(X ,Y ,[ _ | Q ]) : - suivants(X ,Y , Q ).


% unique /2
unique(X ,[ X | Q ]) : - hors(X , Q ).
unique(X ,[ T | Q ]) : - unique(X , Q ) , X \== T .

% occurence /3
occurences(X ,0 ,[]) : - nonvar( X ).
occurences(X ,N ,[ X | Q ]) : - occurences(X ,M , Q ) , N is M + 1.
occurences(X ,N ,[ T | Q ]) : - occurences(X ,N , Q ) , X \== T .

% prefixe /2
prefixe([] , _ ).
prefixe([ T | P ] ,[ T | Q ]) : - prefixe(P , Q ).

% suffixe /2
suffixe(L , L ).
suffixe(S ,[ _ | Q ]) : - suffixe(S , Q ).

% sousListe /2
sousListe([] , _ ).
sousListe([ T | Q ] , L ) : - prefixe(P , L ) , suffixe([ T | Q ] , P ).
% sousListe([ T | Q ] , L ) : - suffixe(S , L ) , prefixe([ T | Q ] , S ).


% conc /3
conc ([] , L , L ).
conc ([ T | Q ] ,L ,[ T | QL ]) : - conc (Q ,L , QL ).

% inserer /3
inserer (X ,L ,[ X | L ]).

% ajouter /3
ajouter (X ,[] ,[ X ]).
ajouter (X ,[ T | Q ] ,[ T | L ]) : - ajouter (X ,Q , L ).

% supprimer /3
supprimer (_ ,[] ,[]).
supprimer (X ,[ X | L1 ] , L2 ) : - supprimer (X , L1 , L2 ).
supprimer (X ,[ T | L1 ] ,[ T | L2 ]) : - supprimer (X , L1 , L2 ) , X \= T .

% inverser /2
inverser ([] ,[]).
inverser ([ T | Q ] , L ) : - inverser (Q , L1 ) , conc ( L1 ,[ T ] , L ).

% substituer /3
substituer (_ ,_ ,[] ,[]).
substituer (X ,Y ,[ X | L1 ] ,[ Y | L2 ]) : - substituer (X ,Y , L1 , L2 ).
substituer (X ,Y ,[ T | L1 ] ,[ T | L2 ]) : - substituer (X ,Y , L1 , L2 ) , X \= T .

% decaler /2
decaler (L , LD ) : - conc ( L1 ,[ D ] , L ) , conc ([ D ] , L1 , LD ).

% convertir /2
: - op (100 , xfy , et ).

convertir ([] , fin ).
convertir ([ T | Q ] , T et L ) : - convertir (Q , L ).

% aplatir /2
aplatir ([] ,[]).
aplatir (T ,[ T ]) : - T \= [] , T \= [ _ | _ ].
aplatir ([ T | Q ] , L ) : -
aplatir (T , TA ) , aplatir (Q , QA ) , conc ( TA , QA , L ).

% transposer /2
transposer ([ T | Q ] , L ) : - longueur (N , T ) , transposer (N ,[ T | Q ] , L ).


% transposer /3
transposer (0 ,_ ,[]).
transposer (N ,[ T | Q ] ,[ Ts | Qs ]) : -
N > 0 , transposerPremiers ([ T | Q ] , Ts , L1 ) , N1 is N - 1 ,
transposer ( N1 , L1 , Qs ).

% tr an sposerPremiers /3
tr an sp oserPremiers ([] ,[] ,[]).
tr an sp oserPremiers ([[ T | Q ]| R ] ,[ T | TQ ] ,[ Q | QQ ]) : -
transposerPremiers (R , TQ , QQ ).

% creerListe /3
creerListe (X ,1 ,[ X ]) : - !.
creerListe (X ,N ,[ X | L ]) : - N > 1 , N1 is N -1 , creerListe (X , N1 , L ).

CORRIGÉS TD 3. LISTES
% univ /2
univ (F ,[ T | Q ]) : -
nonvar ( F ) , functor (F ,T , N ) , univ (F ,1 ,N , Q ).
univ (F ,[ T | Q ]) : -
var ( F ) , longueur (N , Q ) , functor (F ,T , N ) , univ (F ,1 ,N , Q ).

% univ /4
univ (F , Accu ,N ,[ Arg | Q ]) : -
N > 0 , Accu < N , arg ( Accu ,F , Arg ) ,
Accu1 is Accu + 1 , univ (F , Accu1 ,N , Q ).
univ (F ,N ,N ,[ Arg ]) : - arg (N ,F , Arg ).
univ (_ ,_ ,0 ,[]).




*/


/*conc([],L,L).
conc([X|L1],L2,[X|L3]):-conc(L1,L2,L3).



%applatir ap transforme une liste de listes en une liste unique i;e liste applatie A 
ap([],[]). % applatir liste vide
ap(X,[X]). %applatir un elt qui n'est pas une liste
ap([Tete|Queue],ListePlate):-
	ap(Tete,TetePlate),
	ap(Queue, QueuePlate),
	conc(TetePlate,QueuePlate,ListePlate).
	
	
	
% 1.07 (**): Flatten a nested list structure.

% my_flatten(L1,L2) :- the list L2 is obtained from the list L1 by
%    flattening; i.e. if an element of L1 is a list then it is replaced
%    by its elements, recursively. 
%    (list,list) (+,?)

% Note: flatten(+List1, -List2) is a predefined predicate

my_flatten(X,[X]) :- \+ is_list(X).
my_flatten([],[]).
my_flatten([X|Xs],Zs) :- my_flatten(X,Y), my_flatten(Xs,Ys), append(Y,Ys,Zs).

	*/


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


/*

% liste /1
liste([]).
liste([ _ | Q ]) : - liste( Q ).

% premier /2
premier(X ,[ X | _ ]).

% dernier /2
dernier(X ,[ X ]).
dernier(X ,[ _ | Q ]) : - dernier(X , Q ).

% nieme /3
nieme(1 ,T ,[ T | _ ]).

nieme(N ,X ,[ _ | Q ]) : - nieme(M ,X , Q ) , N is M + 1.

% longueur /2
longueur(0 ,[]).
longueur(N ,[ _ | Q ]) : - longueur(M , Q ) , N is M + 1.

% dans /2
dans(X ,[ X | _ ]).
dans(X ,[ _ | Q ]) : - dans(X , Q ).

% hors /2
hors(X ,[]) : - nonvar( X ).
hors(X ,[ T | Q ]) : - X \== T , hors(X , Q ).

% suivants /3
suivants(X ,Y ,[ X , Y | _ ]).
suivants(X ,Y ,[ _ | Q ]) : - suivants(X ,Y , Q ).


% unique /2
unique(X ,[ X | Q ]) : - hors(X , Q ).
unique(X ,[ T | Q ]) : - unique(X , Q ) , X \== T .

% occurence /3
occurences(X ,0 ,[]) : - nonvar( X ).
occurences(X ,N ,[ X | Q ]) : - occurences(X ,M , Q ) , N is M + 1.
occurences(X ,N ,[ T | Q ]) : - occurences(X ,N , Q ) , X \== T .

% prefixe /2
prefixe([] , _ ).
prefixe([ T | P ] ,[ T | Q ]) : - prefixe(P , Q ).

% suffixe /2
suffixe(L , L ).
suffixe(S ,[ _ | Q ]) : - suffixe(S , Q ).

% sousListe /2
sousListe([] , _ ).
sousListe([ T | Q ] , L ) : - prefixe(P , L ) , suffixe([ T | Q ] , P ).
% sousListe([ T | Q ] , L ) : - suffixe(S , L ) , prefixe([ T | Q ] , S ).


% conc /3
conc ([] , L , L ).
conc ([ T | Q ] ,L ,[ T | QL ]) : - conc (Q ,L , QL ).

% inserer /3
inserer (X ,L ,[ X | L ]).

% ajouter /3
ajouter (X ,[] ,[ X ]).
ajouter (X ,[ T | Q ] ,[ T | L ]) : - ajouter (X ,Q , L ).

% supprimer /3
supprimer (_ ,[] ,[]).
supprimer (X ,[ X | L1 ] , L2 ) : - supprimer (X , L1 , L2 ).
supprimer (X ,[ T | L1 ] ,[ T | L2 ]) : - supprimer (X , L1 , L2 ) , X \= T .

% inverser /2
inverser ([] ,[]).
inverser ([ T | Q ] , L ) : - inverser (Q , L1 ) , conc ( L1 ,[ T ] , L ).

% substituer /3
substituer (_ ,_ ,[] ,[]).
substituer (X ,Y ,[ X | L1 ] ,[ Y | L2 ]) : - substituer (X ,Y , L1 , L2 ).
substituer (X ,Y ,[ T | L1 ] ,[ T | L2 ]) : - substituer (X ,Y , L1 , L2 ) , X \= T .

% decaler /2
decaler (L , LD ) : - conc ( L1 ,[ D ] , L ) , conc ([ D ] , L1 , LD ).

% convertir /2
: - op (100 , xfy , et ).

convertir ([] , fin ).
convertir ([ T | Q ] , T et L ) : - convertir (Q , L ).

% aplatir /2
aplatir ([] ,[]).
aplatir (T ,[ T ]) : - T \= [] , T \= [ _ | _ ].
aplatir ([ T | Q ] , L ) : -
aplatir (T , TA ) , aplatir (Q , QA ) , conc ( TA , QA , L ).

% transposer /2
transposer ([ T | Q ] , L ) : - longueur (N , T ) , transposer (N ,[ T | Q ] , L ).


% transposer /3
transposer (0 ,_ ,[]).
transposer (N ,[ T | Q ] ,[ Ts | Qs ]) : -
N > 0 , transposerPremiers ([ T | Q ] , Ts , L1 ) , N1 is N - 1 ,
transposer ( N1 , L1 , Qs ).

% tr an sposerPremiers /3
tr an sp oserPremiers ([] ,[] ,[]).
tr an sp oserPremiers ([[ T | Q ]| R ] ,[ T | TQ ] ,[ Q | QQ ]) : -
transposerPremiers (R , TQ , QQ ).

% creerListe /3
creerListe (X ,1 ,[ X ]) : - !.
creerListe (X ,N ,[ X | L ]) : - N > 1 , N1 is N -1 , creerListe (X , N1 , L ).

CORRIGÉS TD 3. LISTES
% univ /2
univ (F ,[ T | Q ]) : -
nonvar ( F ) , functor (F ,T , N ) , univ (F ,1 ,N , Q ).
univ (F ,[ T | Q ]) : -
var ( F ) , longueur (N , Q ) , functor (F ,T , N ) , univ (F ,1 ,N , Q ).

% univ /4
univ (F , Accu ,N ,[ Arg | Q ]) : -
N > 0 , Accu < N , arg ( Accu ,F , Arg ) ,
Accu1 is Accu + 1 , univ (F , Accu1 ,N , Q ).
univ (F ,N ,N ,[ Arg ]) : - arg (N ,F , Arg ).
univ (_ ,_ ,0 ,[]).

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


arc(a,b).
arc(b,c).
arc(b,d).
path(X, Y) :- arc(X,Y);arc(X,Z), path(Z,Y).


%suffixe d'une liste ie sous liste finissante
suf(L,L).
suf(S,[_|L]) :- suf(S,L).  

conc([],L,L).
conc([X|L], M, [X|N]) :- conc(L,M,N).

% effacer la 1ere occurrence d'un objet dans une liste : delete = del/3
del(X,[X|L],L).
del(X,[Y|L],[Y|M]) :- del(X,L,M).
%  delete une des occurences 
%  del(X,[Y|L],[Y|M]) :- del(X,L,M)

% effacer toutes les occurrence d'un objet dans une liste : delete tout = delt/3
delt(_,[],[]).
delt(X, [X|L],R) :- R=[Y|Z],Y\=X, delt(X,L,R). %,!.
delt(X, [Y|L],[Y|M]) :-  delt(X,L,M).
 
% sous liste
%sub(L,L).
sub(S,L) :- conc(L1,L2,L),conc(S,_,L2). 

% conseq/3 vrai si les elt x et y sont conseq dans L1
conseq(X,Y,[X,Y|_]).
conseq(X,Y,[_|L]) :- conseq(X,Y,L).

conseq2(X,Y,L) :- member(X,L),member(Y,L),conc(_,[X|_],R),conc(R,[Y|_], L).

%conseq2(a,b, [c,d,e, a, e,r,t,b, q,s]).

















