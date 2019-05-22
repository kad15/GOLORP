% arbre si c'est un arbre vide ou constitué d'un node racine et de deux fils eft et right t(X,L,R)
istree(nil).
istree(t(X,L,R)):- atomic(X),istree(L),istree(R).

% 4.01 Write a predicate istree/1 which succeeds if and only if its argument
%      is a Prolog term representing a binary tree.
%
% istree(T) :- T is a term representing a binary tree (i), (o)

istree(nil).
istree(t(_,L,R)) :- istree(L), istree(R).


% Test cases (can be used for other binary tree problems as well)

tree(1,t(a,t(b,t(d,nil,nil),t(e,nil,nil)),t(c,nil,t(f,t(g,nil,nil),nil)))).
tree(2,t(a,nil,nil)).
tree(3,nil).

% 4.02 (**) Construct completely balanced binary trees for a given 
% number of nodes.

% cbal_tree(N,T) :- T is a completely balanced binary tree with N nodes.
% (integer, tree)  (+,?)

cbal_tree(0,nil) :- !.
cbal_tree(N,t(x,L,R)) :- N > 0,
	N0 is N - 1, 
	N1 is N0//2, N2 is N0 - N1,
	distrib(N1,N2,NL,NR),
	cbal_tree(NL,L), cbal_tree(NR,R).

distrib(N,N,N,N) :- !.
distrib(N1,N2,N1,N2).
distrib(N1,N2,N2,N1).

% 4.03 (**) Symmetric binary trees 
% Let us call a binary tree symmetric if you can draw a vertical 
% line through the root node and then the right subtree is the mirror
% image of the left subtree.
% Write a predicate symmetric/1 to check whether a given binary
% tree is symmetric. Hint: Write a predicate mirror/2 first to check
% whether one tree is the mirror image of another.

% symmetric(T) :- the binary tree T is symmetric.

symmetric(nil).
symmetric(t(_,L,R)) :- mirror(L,R).

mirror(nil,nil).
mirror(t(_,L1,R1),t(_,L2,R2)) :- mirror(L1,R2), mirror(R1,L2).

% 4.04 (**) Binary search trees (dictionaries)

% Use the predicate add/3, developed in chapter 4 of the course,
% to write a predicate to construct a binary search tree 
% from a list of integer numbers. Then use this predicate to test 
% the solution of the problem P56

:- ensure_loaded(p4_03).

% add(X,T1,T2) :- the binary dictionary T2 is obtained by 
% adding the item X to the binary dictionary T1
% (element,binary-dictionary,binary-dictionary) (i,i,o)

add(X,nil,t(X,nil,nil)).
add(X,t(Root,L,R),t(Root,L1,R)) :- X @< Root, add(X,L,L1).
add(X,t(Root,L,R),t(Root,L,R1)) :- X @> Root, add(X,R,R1).

construct(L,T) :- construct(L,T,nil).

construct([],T,T).
construct([N|Ns],T,T0) :- add(N,T0,T1), construct(Ns,T,T1).
 	
test_symmetric(L) :- construct(L,T), symmetric(T).

% 4.05 (**) Generate-and-test paradigm

% Apply the generate-and-test paradigm to construct all symmetric,
% completely balanced binary trees with a given number of nodes.

:- ensure_loaded(p4_02).
:- ensure_loaded(p4_03).


sym_cbal_tree(N,T) :- cbal_tree(N,T), symmetric(T).

sym_cbal_trees(N,Ts) :- setof(T,sym_cbal_tree(N,T),Ts).

investigate(A,B) :-
	between(A,B,N),
	sym_cbal_trees(N,Ts), length(Ts,L),
	writef('%w   %w',[N,L]), nl,
    fail.
investigate(_,_).

% 4.06 (**) Construct height-balanced binary trees
% In a height-balanced binary tree, the following property holds for
% every node: The height of its left subtree and the height of  
% its right subtree are almost equal, which means their
% difference is not greater than one.
% Write a predicate hbal_tree/2 to construct height-balanced
% binary trees for a given height. The predicate should
% generate all solutions via backtracking. Put the letter 'x'
% as information into all nodes of the tree.

% hbal_tree(D,T) :- T is a height-balanced binary tree with depth T

hbal_tree(0,nil) :- !.
hbal_tree(1,t(x,nil,nil)) :- !.
hbal_tree(D,t(x,L,R)) :- D > 1,
	D1 is D - 1, D2 is D - 2,
	distr(D1,D2,DL,DR),
	hbal_tree(DL,L), hbal_tree(DR,R).

distr(D1,_,D1,D1).
distr(D1,D2,D1,D2).
distr(D1,D2,D2,D1).

% 4.07 (**) Construct height-balanced binary trees with a given number of nodes

:- ensure_loaded(p4_06).

% minNodes(H,N) :- N is the minimum number of nodes in a height-balanced 
% binary tree of height H
% (integer,integer) (+,?)

minNodes(0,0) :- !.
minNodes(1,1) :- !.
minNodes(H,N) :- H > 1, 
	H1 is H - 1, H2 is H - 2,
	minNodes(H1,N1), minNodes(H2,N2),
	N is 1 + N1 + N2.

% maxNodes(H,N) :- N is the maximum number of nodes in a height-balanced 
% binary tree of height H
% (integer,integer) (+,?)

maxNodes(H,N) :- N is 2**H - 1.

% minHeight(N,H) :- H is the minimum height of a height-balanced 
% binary tree with N nodes
% (integer,integer) (+,?)

minHeight(0,0) :- !.
minHeight(N,H) :- N > 0, N1 is N//2, minHeight(N1,H1), H is H1 + 1.

% maxHeight(N,H) :- H is the maximum height of a height-balanced 
% binary tree with N nodes
% (integer,integer) (+,?)

maxHeight(N,H) :- maxHeight(N,H,1,1).

maxHeight(N,H,H1,N1) :- N1 > N, !, H is H1 - 1.
maxHeight(N,H,H1,N1) :- N1 =< N, 
	H2 is H1 + 1, minNodes(H2,N2), maxHeight(N,H,H2,N2).

% hbal_tree_nodes(N,T) :- T is a height-balanced binary tree with N nodes.

hbal_tree_nodes(N,T) :- 
	minHeight(N,Hmin), maxHeight(N,Hmax),
	between(Hmin,Hmax,H),
	hbal_tree(H,T), nodes(T,N).

% the following predicate is from the course (chapter 4)

%  nodes(T,N) :- the binary tree T has N nodes
% (tree,integer);  (i,*) 
 
nodes(nil,0).
nodes(t(_,Left,Right),N) :-
   nodes(Left,NLeft),
   nodes(Right,NRight),
   N is NLeft + NRight + 1.

% count_hbal_trees(N,C) :- there are C different height-balanced binary
% trees with N nodes.

count_hbal_trees(N,C) :- setof(T,hbal_tree_nodes(N,T),Ts), length(Ts,C). 



% 4.08 (*) Count the leaves of a binary tree

:- ensure_loaded(p4_01).

% count_leaves(T,N) :- the binary tree T has N leaves

count_leaves(nil,0).
count_leaves(t(_,nil,nil),1).
count_leaves(t(_,L,nil),N) :- L = t(_,_,_), count_leaves(L,N).
count_leaves(t(_,nil,R),N) :- R = t(_,_,_), count_leaves(R,N).
count_leaves(t(_,L,R),N) :- L = t(_,_,_), R = t(_,_,_),
   count_leaves(L,NL), count_leaves(R,NR), N is NL + NR.

% The above solution works in the flow patterns (i,o) and (i,i)
% without cut and produces a single correct result. Using a cut 
% we can obtain the same result in a much shorter program, like this:

count_leaves1(nil,0).
count_leaves1(t(_,nil,nil),1) :- !.
count_leaves1(t(_,L,R),N) :- 
    count_leaves1(L,NL), count_leaves1(R,NR), N is NL+NR.

% For the flow pattern (o,i) see problem 4.09


% 4.09 (*) Collect the leaves of a binary tree in a list

:- ensure_loaded(p4_01).

% leaves(T,S) :- S is the list of the leaves of the binary tree T

leaves(nil,[]).
leaves(t(X,nil,nil),[X]).
leaves(t(_,L,nil),S) :- L = t(_,_,_), leaves(L,S).
leaves(t(_,nil,R),S) :- R = t(_,_,_), leaves(R,S).
leaves(t(_,L,R),S) :- L = t(_,_,_), R = t(_,_,_),
    leaves(L,SL), leaves(R,SR), append(SL,SR,S).

% The above solution works in the flow patterns (i,o) and (i,i)
% without cut and produces a single correct result. Using a cut 
% we can obtain the same result in a much shorter program, like this:

leaves1(nil,[]).
leaves1(t(X,nil,nil),[X]) :- !.
leaves1(t(_,L,R),S) :- 
    leaves1(L,SL), leaves1(R,SR), append(SL,SR,S).

% To write a predicate that works in the flow pattern (o,i)
% is a more difficult problem, because using append/3 in
% the flow pattern (o,o,i) always generates an empty list 
% as first solution and the result is an infinite recursion
% along the left subtree of the generated binary tree.
% A possible solution is the following trick: we successively
% construct binary tree structures for a given number of nodes
% and fill the leaf nodes with the elements of the leaf list.
% We then increment the number of tree nodes successively,
% and so on. 

% nnodes(T,N) :- T is a binary tree with N nodes (o,i)
nnodes(nil,0) :- !.
nnodes(t(_,L,R),N) :- N > 0, N1 is N-1, 
   between(0,N1,NL), NR is N1-NL,
   nnodes(L,NL), nnodes(R,NR).


% leaves2(T,S) :- S is the list of leaves of the tree T (o,i)

leaves2(T,S) :- leaves2(T,S,0).

leaves2(T,S,N) :- nnodes(T,N), leaves1(T,S).
leaves2(T,S,N) :- N1 is N+1, leaves2(T,S,N1).

% OK, this was difficulty (**)

% 4.10 (*) Collect the internal nodes of a binary tree in a list

:- ensure_loaded(p4_01).

% internals(T,S) :- S is the list of internal nodes of the binary tree T.

internals(nil,[]).
internals(t(_,nil,nil),[]).
internals(t(X,L,nil),[X|S]) :- L = t(_,_,_), internals(L,S).
internals(t(X,nil,R),[X|S]) :- R = t(_,_,_), internals(R,S).
internals(t(X,L,R),[X|S]) :- L = t(_,_,_), R = t(_,_,_), 
   internals(L,SL), internals(R,SR), append(SL,SR,S).

% The above solution works in the flow patterns (i,o) and (i,i)
% without cut and produces a single correct result. Using a cut 
% we can obtain the same result in a much shorter program, like this:

internals1(nil,[]).
internals1(t(_,nil,nil),[]) :- !.
internals1(t(X,L,R),[X|S]) :- 
    internals1(L,SL), internals1(R,SR), append(SL,SR,S).

% For the flow pattern (o,i) there is the following very
% elegant solution:

internals2(nil,[]).
internals2(t(X,L,R),[X|S]) :- 
   append(SL,SR,S), internals2(L,SL), internals2(R,SR).

 % 4.11 (*) Collect the nodes of a binary tree at a given level in a list

:- ensure_loaded(p4_01).

% atlevel(T,D,S) :- S is the list of nodes of the binary tree T at level D
% (i,i,o)

atlevel(nil,_,[]).
atlevel(t(X,_,_),1,[X]).
atlevel(t(_,L,R),D,S) :- D > 1, D1 is D-1,
   atlevel(L,D1,SL), atlevel(R,D1,SR), append(SL,SR,S).


% The following is a quick-and-dirty solution for the
% level-order sequence

levelorder(T,S) :- levelorder(T,S,1).

levelorder(T,[],D) :- atlevel(T,D,[]), !.
levelorder(T,S,D) :- atlevel(T,D,SD),
   D1 is D+1, levelorder(T,S1,D1), append(SD,S1,S).

% 4.12 (**) Construct a complete binary tree
%
% A complete binary tree with height H is defined as follows: 
% The levels 1,2,3,...,H-1 contain the maximum number of nodes 
% (i.e 2**(i-1) at the level i, note that we start counting the 
% levels from 1 at the root). In level H, which may contain less 
% than the maximum number possible of nodes, all the nodes are 
% "left-adjusted". This means that in a levelorder tree traversal 
% all internal nodes come first, the leaves come second, and
% empty successors (the nils which are not really nodes!) 
% come last. Complete binary trees are used for heaps.

:- ensure_loaded(p4_04).

% complete_binary_tree(N,T) :- T is a complete binary tree with
% N nodes. (+,?)

complete_binary_tree(N,T) :- complete_binary_tree(N,T,1).

complete_binary_tree(N,nil,A) :- A > N, !.
complete_binary_tree(N,t(_,L,R),A) :- A =< N,
	AL is 2 * A, AR is AL + 1,
	complete_binary_tree(N,L,AL),
	complete_binary_tree(N,R,AR).


% ----------------------------------------------------------------------

% This was the solution of the exercise. What follows is an application
% of this result.

% We define a heap as a term heap(N,T) where N is the number of elements
% and T a complete binary tree (in the sense used above).

% The conservative usage of a heap is first to declare it with a predicate
% declare_heap/2 and then use it with a predicate element_at/3.

% declare_heap(H,N) :- 
%    declare H to be a heap with a fixed number N  of elements

declare_heap(heap(N,T),N) :- complete_binary_tree(N,T).

% element_at(H,K,X) :- X is the element at address K in the heap H. 
%  The first element has address 1.
%  (+,+,?)

element_at(heap(_,T),K,X) :- 
   binary_path(K,[],BP), element_at_path(T,BP,X).

binary_path(1,Bs,Bs) :- !.
binary_path(K,Acc,Bs) :- K > 1, 
   B is K /\ 1, K1 is K >> 1, binary_path(K1,[B|Acc],Bs).

element_at_path(t(X,_,_),[],X) :- !.
element_at_path(t(_,L,_),[0|Bs],X) :- !, element_at_path(L,Bs,X).
element_at_path(t(_,_,R),[1|Bs],X) :- element_at_path(R,Bs,X).


% We can transform lists into heaps and vice versa with the following
% useful predicate:

% list_heap(L,H) :- transform a list into a (limited) heap and vice versa.

list_heap(L,H) :- is_list(L), list_to_heap(L,H).
list_heap(L,heap(N,T)) :- integer(N), fill_list(heap(N,T),N,1,L).

list_to_heap(L,H) :- 
   length(L,N), declare_heap(H,N), fill_heap(H,L,1).

fill_heap(_,[],_).
fill_heap(H,[X|Xs],K) :- element_at(H,K,X), K1 is K+1, fill_heap(H,Xs,K1).

fill_list(_,N,K,[]) :- K > N.
fill_list(H,N,K,[X|Xs]) :- K =< N, 
   element_at(H,K,X), K1 is K+1, fill_list(H,N,K1,Xs).


% However, a more aggressive usage is *not* to define the heap in the
% beginning, but to use it as a partially instantiated data structure.
% Used in this way, the number of elements in the heap is unlimited.
% This is Power-Prolog!

% Try the following and find out exactly what happens.

% ?- element_at(H,5,alfa), element_at(H,2,beta), element(H,5,A).

% -------------------------------------------------------------------------

% Test section. Suppose you have N elements in a list which must be looked
% up M times in a random order.

test1(N,M) :-
   length(List,N), lookup_list(List,N,M).

lookup_list(_,_,0) :- !.
lookup_list(List,N,M) :- 
   K is random(N)+1,       % determine a random address
   nth1(K,List,_),         % look up and throw away
   M1 is M-1,
   lookup_list(List,N,M1).

% ?- time(test1(100,100000)).
% 1,384,597 inferences in 3.98 seconds (347889 Lips)
% ?- time(test1(500,100000)).
% 4,721,902 inferences in 13.82 seconds (341672 Lips)
% ?- time(test1(10000,100000)).
% 84,016,719 inferences in 277.51 seconds (302752 Lips)

test2(N,M) :-
   declare_heap(Heap,N), 
   lookup_heap(Heap,N,M).

lookup_heap(_,_,0) :- !.
lookup_heap(Heap,N,M) :- 
   K is random(N)+1,       % determine a random address
   element_at(Heap,K,_),   % look up and throw away
   M1 is M-1,
   lookup_heap(Heap,N,M1).

% ?- time(test2(100,100000)).
% 3,002,061 inferences in 7.81 seconds (384387 Lips)                          
% ?- time(test2(500,100000)).
% 4,097,961 inferences in 10.75 seconds (381206 Lips)
% ?- time(test2(10000,100000)).
% 6,366,206 inferences in 19.16 seconds (332265 Lips)

% Conclusion: In this scenario, for lists longer than 500 elements 
% it is more efficient to use a heap.
 
% 4.13 (**) Layout a binary tree (1)
%
% Given a binary tree as the usual Prolog term t(X,L,R) (or nil).
% As a preparation for drawing the tree, a layout algorithm is
% required to determine the position of each node in a rectangular
% grid. Several layout methods are conceivable, one of them is
% the following:
%
% The position of a node v is obtained by the following two rules:
%   x(v) is equal to the position of the node v in the inorder sequence
%   y(v) is equal to the depth of the node v in the tree
%
% In order to store the position of the nodes, we extend the Prolog 
% term representing a node (and its successors) as follows:
%    nil represents the empty tree (as usual)
%    t(W,X,Y,L,R) represents a (non-empty) binary tree with root
%        W positionned at (X,Y), and subtrees L and R
%
% Write a predicate layout_binary_tree/2:

% layout_binary_tree(T,PT) :- PT is the "positionned" binary
%    tree obtained from the binary tree T. (+,?) or (?,+)

:- ensure_loaded(p4_04). % for test

layout_binary_tree(T,PT) :- layout_binary_tree(T,PT,1,_,1).

% layout_binary_tree(T,PT,In,Out,D) :- T and PT as in layout_binary_tree/2;
%    In is the position in the inorder sequence where the tree T (or PT)
%    begins, Out is the position after the last node of T (or PT) in the 
%    inorder sequence. D is the depth of the root of T (or PT). 
%    (+,?,+,?,+) or (?,+,+,?,+)
 
layout_binary_tree(nil,nil,I,I,_).
layout_binary_tree(t(W,L,R),t(W,X,Y,PL,PR),Iin,Iout,Y) :- 
   Y1 is Y + 1,
   layout_binary_tree(L,PL,Iin,X,Y1), 
   X1 is X + 1,
   layout_binary_tree(R,PR,X1,Iout,Y1).

% Test (see example given in the problem description):
% ?-  construct([n,k,m,c,a,h,g,e,u,p,s,q],T),layout_binary_tree(T,PT).


% 4.14 (**) Layout a binary tree (2)
%
% See problem 4.13 for the conventions.
%
% The position of a node v is obtained by the following rules:
%   (1) y(v) is equal to the depth of the node v in the tree
%   (2) if D denotes the depth of the tree (i.e. the number of
%       populated levels) then the horizontal distance between
%       nodes at level i (counted from the root, beginning with 1)
%       is equal to 2**(D-i+1). The leftmost node of the tree
%       is at position 1.

% layout_binary_tree2(T,PT) :- PT is the "positionned" binary
%    tree obtained from the binary tree T. (+,?)

:- ensure_loaded(p4_04). % for test

layout_binary_tree2(nil,nil) :- !. 
layout_binary_tree2(T,PT) :- 
   hor_dist(T,D4), D is D4//4, x_pos(T,X,D), 
   layout_binary_tree2(T,PT,X,1,D).

% hor_dist(T,D4) :- D4 is four times the horizontal distance between the 
%    root node of T and its successor(s) (if any).
%    (+,-)

hor_dist(nil,1).
hor_dist(t(_,L,R),D4) :- 
   hor_dist(L,D4L), 
   hor_dist(R,D4R),
   D4 is 2 * max(D4L,D4R).

% x_pos(T,X,D) :- X is the horizontal position of the root node of T
%    with respect to the picture co-ordinate system. D is the horizontal
%    distance between the root node of T and its successor(s) (if any).
%    (+,-,+)

x_pos(t(_,nil,_),1,_) :- !.
x_pos(t(_,L,_),X,D) :- D2 is D//2, x_pos(L,XL,D2), X is XL+D.

% layout_binary_tree2(T,PT,X,Y,D) :- T and PT as in layout_binary_tree/2;
%    D is the the horizontal distance between the root node of T and 
%    its successor(s) (if any). X, Y are the co-ordinates of the root node.
%    (+,-,+,+,+)
 
layout_binary_tree2(nil,nil,_,_,_).
layout_binary_tree2(t(W,L,R),t(W,X,Y,PL,PR),X,Y,D) :- 
   Y1 is Y + 1,
   Xleft is X - D,
   D2 is D//2,
   layout_binary_tree2(L,PL,Xleft,Y1,D2), 
   Xright is X + D,
   layout_binary_tree2(R,PR,Xright,Y1,D2).

% Test (see example given in the problem description):
% ?- construct([n,k,m,c,a,e,d,g,u,p,q],T),layout_binary_tree2(T,PT).
 
 % 4.15 (***) Layout a binary tree (3)
%
% See problem 4.13 for the conventions.
%
% The position of a node v is obtained by the following rules:
%   (1) y(v) is equal to the depth of the node v in the tree
%   (2) in order to determine the horizontal positions of the nodes we
%       construct "contours" for each subtree and shift them together 
%       horizontally as close as possible. However, we maintain the
%       symmetry in each node; i.e. the horizontal distance between
%       a node and the root of its left subtree is the same as between
%       it and the root of its right subtree.
%
%       The "contour" of a tree is a list of terms c(Xleft,Xright) which
%       give the horizontal position of the outermost nodes of the tree
%       on each level, relative to the root position. In the example
%       given in the problem description, the "contour" of the tree with
%       root k would be [c(-1,1),c(-2,0),c(-1,1)]. Note that the first
%       element in the "contour" list is derived from the position of
%       the nodes c and m.

% layout_binary_tree3(T,PT) :- PT is the "positionned" binary
%    tree obtained from the binary tree T. (+,?)

:- ensure_loaded(p4_04). % for test

layout_binary_tree3(nil,nil) :- !. 
layout_binary_tree3(T,PT) :-
   contour_tree(T,CT),      % construct the "contour" tree CT
   CT = t(_,_,_,Contour),
   mincont(Contour,MC,0),   % find the position of the leftmost node
   Xroot is 1-MC,
   layout_binary_tree3(CT,PT,Xroot,1).

contour_tree(nil,nil).
contour_tree(t(X,L,R),t(X,CL,CR,Contour)) :- 
   contour_tree(L,CL),
   contour_tree(R,CR),
   combine(CL,CR,Contour).

combine(nil,nil,[]).
combine(t(_,_,_,CL),nil,[c(-1,-1)|Cs]) :- shift(CL,-1,Cs).
combine(nil,t(_,_,_,CR),[c(1,1)|Cs]) :- shift(CR,1,Cs).
combine(t(_,_,_,CL),t(_,_,_,CR),[c(DL,DR)|Cs]) :-
   maxdiff(CL,CR,MD,0), 
   DR is (MD+2)//2, DL is -DR,
   merge(CL,CR,DL,DR,Cs).

shift([],_,[]).
shift([c(L,R)|Cs],S,[c(LS,RS)|CsS]) :-
   LS is L+S, RS is R+S, shift(Cs,S,CsS).

maxdiff([],_,MD,MD) :- !.
maxdiff(_,[],MD,MD) :- !.
maxdiff([c(_,R1)|Cs1],[c(L2,_)|Cs2],MD,A) :- 
   A1 is max(A,R1-L2),
   maxdiff(Cs1,Cs2,MD,A1).

merge([],CR,_,DR,Cs) :- !, shift(CR,DR,Cs).
merge(CL,[],DL,_,Cs) :- !, shift(CL,DL,Cs).
merge([c(L1,_)|Cs1],[c(_,R2)|Cs2],DL,DR,[c(L,R)|Cs]) :-
   L is L1+DL, R is R2+DR,
   merge(Cs1,Cs2,DL,DR,Cs).

mincont([],MC,MC).
mincont([c(L,_)|Cs],MC,A) :- 
   A1 is min(A,L), mincont(Cs,MC,A1).

layout_binary_tree3(nil,nil,_,_).
layout_binary_tree3(t(W,nil,nil,_),t(W,X,Y,nil,nil),X,Y) :- !. 
layout_binary_tree3(t(W,L,R,[c(DL,DR)|_]),t(W,X,Y,PL,PR),X,Y) :- 
   Y1 is Y + 1,
   Xleft is X + DL,
   layout_binary_tree3(L,PL,Xleft,Y1), 
   Xright is X + DR,
   layout_binary_tree3(R,PR,Xright,Y1).

% Test (see example given in the problem description):
% ?- construct([n,k,m,c,a,e,d,g,u,p,q],T),layout_binary_tree3(T,PT).


% 4.16a (**)  A string representation of binary trees

% The string representation has the following syntax:
%
% <tree> ::=  | <letter><subtrees>
%
% <subtrees> ::=  | '(' <tree> ',' <tree> ')'
%
% According to this syntax, a leaf node (with letter x) could
% be represented by x(,) and not only by the single character x.
% However, we will avoid this when generating the string 
% representation.

tree_string(T,S) :- nonvar(T), !, tree_to_string(T,S). 
tree_string(T,S) :- nonvar(S), string_to_tree(S,T). 

tree_to_string(T,S) :- tree_to_list(T,L), atom_chars(S,L).

tree_to_list(nil,[]).
tree_to_list(t(X,nil,nil),[X]) :- !.
tree_to_list(t(X,L,R),[X,'('|List]) :- 
   tree_to_list(L,LsL),
   tree_to_list(R,LsR),
   append(LsL,[','],List1),
   append(List1,LsR,List2),
   append(List2,[')'],List).

string_to_tree(S,T) :- atom_chars(S,L), list_to_tree(L,T).

list_to_tree([],nil).
list_to_tree([X],t(X,nil,nil)) :- char_type(X,alpha).
list_to_tree([X,'('|List],t(X,Left,Right)) :- char_type(X,alpha),
   append(List1,[')'],List),
   append(LeftList,[','|RightList],List1),
   list_to_tree(LeftList,Left),
   list_to_tree(RightList,Right).

   
   % 4.16b (**) A string representation of binary trees

% Most elegant solution using difference lists.

tree_string(T,S) :- nonvar(T), tree_dlist(T,L-[]), !, atom_chars(S,L). 
tree_string(T,S) :- nonvar(S), atom_chars(S,L), tree_dlist(T,L-[]).

% tree_dlist/2 does the trick in both directions!

tree_dlist(nil,L-L).
tree_dlist(t(X,nil,nil),L1-L2) :- 
   letter(X,L1-L2).
tree_dlist(t(X,Left,Right),L1-L7) :- 
   letter(X,L1-L2), 
   symbol('(',L2-L3),
   tree_dlist(Left,L3-L4),
   symbol(',',L4-L5),
   tree_dlist(Right,L5-L6),
   symbol(')',L6-L7).

symbol(X,[X|Xs]-Xs).

letter(X,L1-L2) :- symbol(X,L1-L2), char_type(X,alpha).


% 4.17a (**) Preorder and inorder sequences of binary trees

% We consider binary trees with nodes that are identified by
% single lower-case letters.

% a) Given a binary tree, construct its preorder sequence

preorder(T,S) :- preorder_tl(T,L), atom_chars(S,L).

preorder_tl(nil,[]).
preorder_tl(t(X,Left,Right),[X|List]) :-
   preorder_tl(Left,ListLeft),
   preorder_tl(Right,ListRight),
   append(ListLeft,ListRight,List).

inorder(T,S) :- inorder_tl(T,L), atom_chars(S,L).

inorder_tl(nil,[]).
inorder_tl(t(X,Left,Right),List) :-
   inorder_tl(Left,ListLeft),
   inorder_tl(Right,ListRight),
   append(ListLeft,[X|ListRight],List).

   % 4.17b (**) Preorder and inorder sequences of binary trees

% b) Make preorder/2 and inorder/2 reversible.

% Similar to the solution p4_17a.pl. However, for the flow pattern (-,+) 
% we have to modify the order of the subgoals in the second clauses 
% of preorder_l/2 and inorder_l/2

% preorder(T,S) :- S is the preorder tre traversal sequence of the
%    nodes of the binary tree T. (tree,atom) (+,?) or (?,+)

preorder(T,S) :- nonvar(T), !, preorder_tl(T,L), atom_chars(S,L). 
preorder(T,S) :- atom(S), atom_chars(S,L), preorder_lt(T,L).

preorder_tl(nil,[]).
preorder_tl(t(X,Left,Right),[X|List]) :-
   preorder_tl(Left,ListLeft),
   preorder_tl(Right,ListRight),
   append(ListLeft,ListRight,List).

preorder_lt(nil,[]).
preorder_lt(t(X,Left,Right),[X|List]) :-
   append(ListLeft,ListRight,List),
   preorder_lt(Left,ListLeft),
   preorder_lt(Right,ListRight).

% inorder(T,S) :- S is the inorder tre traversal sequence of the
%    nodes of the binary tree T. (tree,atom) (+,?) or (?,+)

inorder(T,S) :- nonvar(T), !, inorder_tl(T,L), atom_chars(S,L). 
inorder(T,S) :- atom(S), atom_chars(S,L), inorder_lt(T,L).

inorder_tl(nil,[]).
inorder_tl(t(X,Left,Right),List) :-
   inorder_tl(Left,ListLeft),
   inorder_tl(Right,ListRight),
   append(ListLeft,[X|ListRight],List).

inorder_lt(nil,[]).
inorder_lt(t(X,Left,Right),List) :-
   append(ListLeft,[X|ListRight],List),
   inorder_lt(Left,ListLeft),
   inorder_lt(Right,ListRight).

   % 4.17c (**) Preorder and inorder sequences of binary trees

% If both the preorder sequence and the inorder sequence of
% the nodes of a binary tree are given, then the tree is determined
% unambiguously. 

:- ensure_loaded(p4_17b).

% pre_in_tree(P,I,T) :- T is the binary tree that has the preorder
%   sequence P and inorder sequence I.
%   (atom,atom,tree) (+,+,?)

pre_in_tree(P,I,T) :- preorder(T,P), inorder(T,I).

% This is a nice application of the generate-and-test method.


% We can push the tester inside the generator in order to get
% a (much) better performance.

pre_in_tree_push(P,I,T) :- 
   atom_chars(P,PL), atom_chars(I,IL), pre_in_tree_pu(PL,IL,T).

pre_in_tree_pu([],[],nil).
pre_in_tree_pu([X|PL],IL,t(X,Left,Right)) :- 
   append(ILeft,[X|IRight],IL),
   append(PLeft,PRight,PL),
   pre_in_tree_pu(PLeft,ILeft,Left),
   pre_in_tree_pu(PRight,IRight,Right).
   
% Nice. But there is a still better solution. See problem d)!

% 4.17d (**) Preorder and inorder sequences of binary trees

% Work with difference lists

% pre_in_tree_d(P,I,T) :- T is the binary tree that has the preorder
%   sequence P and inorder sequence I.
%   (atom,atom,tree) (+,+,?)

pre_in_tree_d(P,I,T) :-  
   atom_chars(P,PL), atom_chars(I,IL), pre_in_tree_dl(PL-[],IL-[],T).

pre_in_tree_dl(P-P,I-I,nil).
pre_in_tree_dl(P1-P4,I1-I4,t(X,Left,Right)) :-
   symbol(X,P1-P2), symbol(X,I2-I3),
   pre_in_tree_dl(P2-P3,I1-I2,Left),
   pre_in_tree_dl(P3-P4,I3-I4,Right).

symbol(X,[X|Xs]-Xs).


% Isn't it cool? But the best of it is the performance!

% With the generate-and-test solution (p4_17c):
% ?- time(pre_in_tree(abdecfg,dbeacgf,_)).
% 9,048 inferences in 0.01 seconds (904800 Lips)  

% With the "pushed" generate-and-test solution (p4_17c):
% ?- time(pre_in_tree_push(abdecfg,dbeacgf,_)).
% 67 inferences in 0.00 seconds (Infinite Lips)
  
% With the difference list solution (p4_17d):
% ?- time(pre_in_tree_d(abdecfg,dbeacgf,_)).
% 32 inferences in 0.00 seconds (Infinite Lips)                     

% Note that the predicate pre_in_tree_dl/3 runs in almost any
% flow pattern. Try it out!

%  4.18 (**) Dotstring representation of binary trees</B>

% The syntax of the dotstring representation is super simple:
%
% <tree> ::= . | <letter> <tree> <tree>

tree_dotstring(T,S) :- nonvar(T), !, tree_dots_dl(T,L-[]), atom_chars(S,L). 
tree_dotstring(T,S) :- atom(S), atom_chars(S,L), tree_dots_dl(T,L-[]).

tree_dots_dl(nil,L1-L2) :- symbol('.',L1-L2).
tree_dots_dl(t(X,Left,Right),L1-L4) :- 
   letter(X,L1-L2),
   tree_dots_dl(Left,L2-L3),
   tree_dots_dl(Right,L3-L4).

symbol(X,[X|Xs]-Xs).

letter(X,L1-L2) :- symbol(X,L1-L2), char_type(X,alpha).


