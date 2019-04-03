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




*/