si Condition alors But1 sinon But2

Condition, !, % cond vraie ?
But1; % si oui But&
But2. % sinon but 2



Le premier pattern nous permet de dire « en cas de paramètres incorrects, le prédicat échoue ».
Il se présente sous cette forme:
predicat(parametres) :-
conditon_echec,
!, fail.

pattern 2 : si condition_1 alors action_1
predicat(parametres) :-
conditon_1, !,
action_1.