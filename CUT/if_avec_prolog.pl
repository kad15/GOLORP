% prédicat positifs(L1,L2)  
% L1 liste de nombre et L2 liste des nombre >0 de L1 
% P :- Test, !, vrai.
% P :- faux.
positifs([],[]):- !.
positifs([A|B], [A|C]):- A>=0, !, positifs(B,C).
positifs([A|B], R):- A<0, positifs(B,R).

positifs2([],[]).
positifs2([A|B], [A|C]):- A>=0, positifs2(B,C).
positifs2([A|B], R):- A<0, positifs2(B,R).
