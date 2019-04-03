/* sudoku generer et tester */
% sudo 4 X4  12 vars X11 à X44 de domaine 1 2 3 4 => 
%4^12 = #S with S the space state
% V var, D Domaine   all_member vrai si 
%la tête de liste est dans D et si le reste de la liste
% R a toutes ses valeur dans D  
% all_member/2 all_member(L,D) est vrai si les elt de la liste L sont inclus dans la liste D                      
all_member([],_).  % condition d'arrêt
all_member([V|R],D) :- member(V,D), all_member(R,D). 

% all_diff/1 all_diff(L) elt de la liste L tous différents si 
% la tête V non dans la queue R et si la queue R est une liste
% toute différente. 
all_diff([]).
all_diff([V|R]) :- \+ member(V,R), all_diff(R).

gen(L) :- all_member(L, [1,2,3,4]).
sudo4(L) :- gen(L), test_sudo4(L).

test_sudo4([X11 ,X12 ,X13 ,X14 ,
     X21 ,X22 ,X23 ,X24, 
	 X31 ,X32 ,X33 ,X34, 
	 X41 ,X42 ,X43 ,X44 ]) :-
all_diff([X11 ,X12 ,X13 ,X14 ]) , all_diff([X21 ,X22 ,X23 ,X24 ])
, all_diff([X31 ,X32 ,X33 ,X34 ]) , all_diff([X41 ,X42 ,X43 ,X44 ])
, all_diff([X11 ,X21 ,X31 ,X41 ]) , all_diff([X14 ,X24 ,X34 ,X44 ])
, all_diff([X12 ,X22 ,X32 ,X42 ]) , all_diff([X13 ,X23 ,X33 ,X43 ])
, all_diff([X11 ,X12 ,X21 ,X22 ]) , all_diff([X13 ,X14 ,X23 ,X24 ])
, all_diff([X31 ,X32 ,X41 ,X42 ]) , all_diff([X33 ,X34 ,X43 ,X44 ]).

%sudo4([X11 ,2,X13 ,X14 ,1,X22 ,X23 ,X24 ,X31 ,X32 ,X33 ,4,X41 ,X42 ,1,X44 ]).


/* sudoku amélioration */
sudo4_v2(L) :- gen2(L), test_sudo4(L).
% predicat vrai si la tete de L N'EST PAS membre du reste R 
% select(V,D,S) est vrai si V est dans D et S=D\V 
all_member_diff1([],_).
all_member_diff1([V|R],D) :- select(V,D,S), all_member_diff(R,S).
all_member_diff(L) :- all_member_diff(L,[1,2,3,4]).

gen2([X11 ,X12 ,X13 ,X14 ,
     X21 ,X22 ,X23 ,X24, 
	 X31 ,X32 ,X33 ,X34, 
	 X41 ,X42 ,X43 ,X44 ] ) :-
all_member_diff([X11 ,X12 ,X13 ,X14 ]),
all_member_diff([X21 ,X22 ,X23 ,X24 ]),
all_member_diff([X31 ,X32 ,X33 ,X34 ]),
all_member_diff([X41 ,X42 ,X43 ,X44]).


% sudoku with the external constraint solver of gprolog
sudo_fd(L) :- L=[X11 ,X12 ,X13 ,X14 ,
     X21 ,X22 ,X23 ,X24, 
	 X31 ,X32 ,X33 ,X34, 
	 X41 ,X42 ,X43 ,X44 ],
	 fd_domain(L,[1,2,3,4]) % chaque var dans la liste L recoit un domaine initial
, fd_all_different([X11 ,X12 ,X13 ,X14 ]) , fd_all_different([X21 ,X22 ,X23 ,X24 ]) % contraintes stockées 
, fd_all_different([X31 ,X32 ,X33 ,X34 ]) , fd_all_different([X41 ,X42 ,X43 ,X44 ]) % avec reduction du domaine pour les var instanciées
, fd_all_different([X11 ,X21 ,X31 ,X41 ]) , fd_all_different([X14 ,X24 ,X34 ,X44 ]) % comme X12 = 2
, fd_all_different([X12 ,X22 ,X32 ,X42 ]) , fd_all_different([X13 ,X23 ,X33 ,X43 ])
, fd_all_different([X11 ,X12 ,X21 ,X22 ]) , fd_all_different([X13 ,X14 ,X23 ,X24 ])
, fd_all_different([X31 ,X32 ,X41 ,X42 ]) , fd_all_different([X33 ,X34 ,X43 ,X44 ])
, fd_labeling(L). % déclenche la recherche du solver externe
	 
	 % sudo_fd([X11 ,2,X13 ,X14 ,1,X22 ,X23 ,X24 ,X31 ,X32 ,X33 ,4,X41 ,X42 ,1,X44 ]).