% 5.01 Write a predicate istree/1 which succeeds if and only if its argument
%       is a Prolog term representing a multiway tree.
%
% istree(T) :- T is a term representing a multiway tree (i), (o)

% the following is a test case:
tree(1,t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])])).

istree(t(_,F)) :- isforest(F).

isforest([]).
isforest([T|Ts]) :- istree(T), isforest(Ts).



% 5.02 Write a predicate nnodes/2 to count the nodes of a multiway tree.
%
% nnodes(T,N) :- the multiway tree T has N nodes (i,o))

% the following is a test case:
tree(1,t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])])).

nnodes(t(_,F),N) :- nnodes(F,NF), N is NF+1.

nnodes([],0).
nnodes([T|Ts],N) :- nnodes(T,NT), nnodes(Ts,NTs), N is NT+NTs.

% Note that nnodes is called for trees and for forests. An early
% form of polymorphism!

% For the flow pattern (o,i) we can write:

nnodes2(t(_,F),N) :- N > 0, NF is N-1, nnodes2F(F,NF).

nnodes2F([],0).
nnodes2F([T|Ts],N) :- N > 0, 
   between(1,N,NT), nnodes2(T,NT), 
   NTs is N-NT, nnodes2F(Ts,NTs).

 % 5.03 (**) Multiway tree construction from a node string

% We suppose that the nodes of a multiway tree contain single
% characters. In the depth-first order sequence of its nodes, a
% special character ^ has been inserted whenever, during the
% tree traversal, the move is a backtrack to the previous level.

% Define the syntax of the string and write a predicate tree(String,Tree)
% to construct the Tree when the String is given. Work with atoms (instead
% of strings). Make your predicate work in both directions.
%

% Syntax in BNF:

% <tree> ::= <letter> <forest> '^'

% <forest> ::= | <tree> <forest> 


% First a nice solution using difference lists

tree(TS,T) :- atom(TS), !, atom_chars(TS,TL), tree_d(TL-[],T). % (+,?)
tree(TS,T) :- nonvar(T), tree_d(TL-[],T), atom_chars(TS,TL).   % (?,+)

tree_d([X|F1]-T, t(X,F)) :- forest_d(F1-['^'|T],F).

forest_d(F-F,[]).
forest_d(F1-F3,[T|F]) :- tree_d(F1-F2,T), forest_d(F2-F3,F).


% Another solution, not as elegant as the previous one.

tree_2(TS,T) :- atom(TS), !, atom_chars(TS,TL), tree_a(TL,T). % (+,?)
tree_2(TS,T) :- nonvar(T), tree_a(TL,T), atom_chars(TS,TL).   % (?,+)

tree_a(TL,t(X,F)) :- 
   append([X],FL,L1), append(L1,['^'],TL), forest_a(FL,F).

forest_a([],[]).
forest_a(FL,[T|Ts]) :- append(TL,TsL,FL), 
   tree_a(TL,T), forest_a(TsL,Ts).

% 5.04 (*) Determine the internal path length of a tree

% We define the internal path length of a multiway tree as the
% total sum of the path lengths from the root to all nodes of the tree.

% ipl(Tree,L) :- L is the internal path length of the tree Tree
%    (multiway-tree, integer) (+,?)

ipl(T,L) :- ipl(T,0,L).

ipl(t(_,F),D,L) :- D1 is D+1, ipl(F,D1,LF), L is LF+D.

ipl([],_,0).
ipl([T1|Ts],D,L) :- ipl(T1,D,L1), ipl(Ts,D,Ls), L is L1+Ls.

% Notice the polymorphism: ipl is called with trees and with forests
% as first argument.

% 5.05 (*) Construct the bottom-up order sequence of the tree nodes

% bottom_up(Tree,Seq) :- Seq is the bottom-up sequence of the nodes of
%    the multiway tree Tree. (+,?)

bottom_up_f(t(X,F),Seq) :- 
	bottom_up_f(F,SeqF), append(SeqF,[X],Seq).

bottom_up_f([],[]).
bottom_up_f([T|Ts],Seq):-
	bottom_up_f(T,SeqT), bottom_up_f(Ts,SeqTs), append(SeqT,SeqTs,Seq).

% The predicate bottom_up/2 produces a stack overflow when called
% in the (-,+) flow pattern. There are two problems with that.
% First, the polymorphism does not work properly, because during
% decomposing the string, the program cannot guess whether it should
% construct a tree or a forest next. We can fix this using two
% separate predicates bottom_up_tree/2 and bottom_up_forset/2.
% Secondly, if we maintain the order of the subgoals, then
% the interpreter falls into an endless loop after finding the
% first solution. We can fix this by changing the order of the
% goals as follows:

bottom_up_tree(t(X,F),Seq) :-                        % (?,+)
	append(SeqF,[X],Seq), bottom_up_forest(F,SeqF).

bottom_up_forest([],[]).
bottom_up_forest([T|Ts],Seq):-
	append(SeqT,SeqTs,Seq),
	bottom_up_tree(T,SeqT), bottom_up_forest(Ts,SeqTs).

% Unfortunately, this version doesn't run in both directions either.

% In order to have a predicate which runs forward and backward, we
% have to determine the flow pattern and then call one of the above
% predicates, as follows:

bottom_up(T,Seq) :- nonvar(T), !, bottom_up_f(T,Seq).
bottom_up(T,Seq) :- nonvar(Seq), bottom_up_tree(T,Seq).

% This is not very elegant, I agree.

% 5.06a (**)  Lisp-like tree representation

% This is a simple solution for the conversion of trees
% into "lispy token lists"  (i,o)

% tree_ltl(T,L) :- L is the "lispy token list" of the multiway tree T
% (i,o)

tree_ltl(t(X,[]),[X]).
tree_ltl(t(X,[T|Ts]),L) :-
   tree_ltl(T,L1),
   append(['(',X],L1,L2),
   rest_ltl(Ts,L3),
   append(L2,L3,L).

rest_ltl([],[')']).
rest_ltl([T|Ts],L) :-
   tree_ltl(T,L1),
   rest_ltl(Ts,L2),
   append(L1,L2,L).


% some auxiliary predicates

write_ltl([]) :- nl.
write_ltl([X|Xs]) :- write(X), write(' '), write_ltl(Xs).

dotest(T) :- write(T), nl, tree_ltl(T,L), write_ltl(L).

test(1) :- T = t(a,[t(b,[]),t(c,[])]), dotest(T).

test(2) :- T = t(a,[t(b,[t(c,[])])]), dotest(T).
test(3) :- T = t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])]), dotest(T).


 % 5.06 (**)  Lisp-like tree representation

% Here is my most elegant solution: a single predicate for both flow 
% patterns (i,o) and (o,i)

% tree_ltl(T,L) :- L is the "lispy token list" of the multiway tree T

tree_ltl(T,L) :- tree_ltl_d(T,L-[]).

% using difference lists

tree_ltl_d(t(X,[]),[X|L]-L) :- X \= '('.
tree_ltl_d(t(X,[T|Ts]),['(',X|L]-R) :- forest_ltl_d([T|Ts],L-[')'|R]).

forest_ltl_d([],L-L).
forest_ltl_d([T|Ts],L-R) :- tree_ltl_d(T,L-M), forest_ltl_d(Ts,M-R).
 
% some auxiliary predicates

write_ltl([]) :- nl.
write_ltl([X|Xs]) :- write(X), write(' '), write_ltl(Xs).

dotest(T) :- write(T), nl, tree_ltl(T,L),
   write_ltl(L), tree_ltl(T1,L), write(T1), nl.

test(1) :- T = t(a,[t(b,[]),t(c,[])]), dotest(T).
test(2) :- T = t(a,[t(b,[t(c,[])])]), dotest(T).
test(3) :- T = t(a,[t(f,[t(g,[])]),t(c,[]),t(b,[t(d,[]),t(e,[])])]), 
   dotest(T).
  