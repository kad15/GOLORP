% état fermier, loup, oie, haricots
% un état est representé par le predicat etat(Fermier,Loup,Oie,Haricots)
% avec F L O et C qui peuvent prendre les valeur g et d
% en fct de la position à rive gauche, rive droite
% etat initial etat(g,g,g,g), etat final etat(d,d,d,d)
etat_initial(etat(g,g,g,g)).
etat_final(etat(d,d,d,d)).

% états admissibles :
% 4-0 gggg  état avec 4 objets du même côté
% 0-4 dddd
% 3-1 gdgg ggdg gggd  X_XX XX_X XXX_
% 1-3 dgdd ddgd dddg
% 2-2 dgdg gdgd       X_X_

% etat(Fermier, Loup, Oie, Haricots).
etat_possible(etat(X,_,X,_)).  % fermier et oie sur la meme rive
etat_possible(etat(X,_,X,X)).  % fermier Oie et haricots
etat_possible(etat(X,X,_,X)).  % fermier  loup et haricot
etat_possible(etat(X,X,X,_)).     % fermier loup et oie  


% etat_possible(etat(g,g,g,d)).

%rive opposée
cross(g,d).
cross(d,g).



% traversée du fermier avec le loup
transition(etat(P1,P2,P3,P4), etat(Q1,Q2,P3,P4)) :-
	cross(P1,Q1), cross(P2,Q2).

% traversée du fermier avec l'oie
transition(etat(P1,P2,P3,P4), etat(Q1,P2,Q3,P4)) :-
	cross(P1,Q1), cross(P3,Q3).

% traversée du fermier avec les haricots
transition(etat(P1,P2,P3,P4), etat(Q1,P2,P3,Q4)) :-
	cross(P1,Q1), cross(P4,Q4).

% traversée du fermier seul
% traversée du fermier et de l'oie
transition(etat(P1,P2,P3,P4), etat(Q1,P2,P3,P4)) :-
	cross(P1,Q1).

% test : trans(etat(d,g,g,g), etat(d,g,g,g)). 
% transition possible est une transition conduisant 
% à un état possible
transition_possible(Etat1,Etat2) :-
	transition(Etat1, Etat2), etat_possible(Etat1),
	etat_possible(Etat2).


sol(I,F,V,S) :- 
		transition_possible(I,F),S=[];
		transition_possible(I,Z),
		\+ member(Z,V),
		sol(Z,F,[Z|V],S1), S=[Z|S1].
		
sol(S) :- I=etat(g,g,g,g), F=etat(d,d,d,d),
		 sol(I, F, [], T),
		 reverse(T,R), R1 = [F|R],
		 reverse(R1,S1), S=[I|S1].
		
		
		