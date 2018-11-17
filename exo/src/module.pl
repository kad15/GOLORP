/*
Formellement :
• 
• Si a 1 , . . . , a m sont des nests, alors n([a 1 , . . . a m ]) est un nest.
Par exemple, e(4),
n([e(4),e(7),e(2)]),
n([e(3),e(0),e(1),e(8)]),
n([n([e(4),e(7),e(2)]),n([e(3),e(0),e(1),e(8)])]) sont des nests.
Question 1.1. Écrivez un prédicat is_nest/1 qui sera vrai si l’argument est un nest (on pourra
aussi l’appeler avec une variable non-instantié, dans ce cas le prédicat devrait énumérer des
nests). Par exemple, is_nest(n([e(3),e(0),e(1),e(8)])) devrait donner le réponse “true” et
is_nest(n([n(3),e(0),e(1),e(8)])) ou is_nest([1,2,3]) devraient donner “false”.
*/

/*
:- op(600,fx, e).
e(1).
e(2).
e(3).
%e(K) :-[e[K]].

is_nest(X) :- e(K), integer(K).  % Pour tous entier k, e(k) est un nest;


conc([],L,L).
conc([X|L1],L2,[X|L3]):-conc(L1,L2,L3).
*/

/*
     8.20.1  append/3
    8.20.2  member/2, memberchk/2
    8.20.3  reverse/2
    8.20.4  delete/3, select/3
    8.20.5  subtract/3
    8.20.6  permutation/2
    8.20.7  prefix/2, suffix/2
    8.20.8  sublist/2
    8.20.9  last/2
    8.20.10  flatten/2
    8.20.11  length/2
    8.20.12  nth/3
    8.20.13  max_list/2, min_list/2, sum_list/2
    8.20.14  maplist/2-8
    8.20.15  sort/2, msort/2, keysort/2 sort/1, msort/1, keysort/1 
    
    var(?term)
nonvar(?term)
atom(?term)
integer(?term)
float(?term)
number(?term)
atomic(?term)
compound(?term)
callable(?term)
ground(?term)
is_list(?term)
list(?term)
partial_list(?term)
list_or_partial_list(?term)

*/

liste(X) :- var(X), !,fail.
liste([]).
liste([_|T]) :-liste(T).

% concatener deux listes c'est soit concanténer une liste vide avec L qui donne L
% soit concaténer deux listes non vides T1 et T2  
conc([],L,L).
conc([X|L1],[L2],[X|L3]):- conc(L1,L2,L3).



my_flatten(X,[X]) :- \+ is_list(X).
my_flatten([],[]).
my_flatten([T|Q],R) :- my_flatten(T,Tp), my_flatten(Q,Qp), append(Tp,Qp,R).
