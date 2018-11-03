st([Farmer, Fox, Goose, Beans]).
%Let’s tell Prolog what our initial and final states are:
%where Farmer Fox Goose and Beans are variables that can take values of “left” or “right” 
%whether that element is on the left or right side of the river.
    initial(st([left, left, left, left])).

    final(st([right, right, right, right])).
	

/*
	 The transition rule is nothing but a function that given a certain state 
	 will return a possible “next” state, say for example our initial state is 
	 st([left, left, left, left]), a valid next state 
	 could be st([right, left, right, left]) which means 
	 the farmer took the goose and crossed the river.
	 
	 The rules are pretty self-explanatory, crossing st([left,X,Y,Z]),st([right,X,Y,Z] means 
	 “farmer_crosses_river”, as you can see, the farmer variable changed 
	 from left to right and the rest was left intact.
	 %We define the transition rules as follows:
	*/


    crossing(st([left,X,Y,Z]),st([right,X,Y,Z]), farmer_crosses_river).
    crossing(st([right,X,Y,Z]),st([left,X,Y,Z]), farmer_comes_back).

    crossing(st([left,X,left,Z]),st([right,X,right,Z]), bring_goose_over).
    crossing(st([right,X,right,Z]),st([left,X,left,Z]), bring_goose_back).

    crossing(st([left, left, X, Y]),st([right, right, X, Y]), bring_fox_over).
    crossing(st([right, right, X, Y]),st([left, left, X, Y]), bring_fox_back).

    crossing(st([left, X, Y, left]),st([right, X, Y, right]), bring_beans_over).
    crossing(st([right, X, Y, right]),st([left, X, Y, left]), bring_beans_back).
	
	
	
not_allowed(st([X, Y, Y, _])) :- X \== Y.
not_allowed(st([X, _, Y, Y])) :- X \== Y.
	
    river_aux(A,A,_,[]). % To go from A to A the crossing is empty meaning that 
	%we do not cross at all, this will be true when we reach our destination.
	
	
	/*
	river_aux(A,B,V,P) is a rule that will be true when you can go 
	to A from B by the crossings defined by P. V is the list of 
	previously visited nodes on the graph, if we didn’t have 
	V we would loop through the graph infinitely.
	To summarize, river_aux looks for a node in a graph, 
	leaving from A, and after P transitions ends in B.
	
	*/

    river_aux(A,B,V,P) :-
    crossing(A,C,Action),
    not(not_allowed(C)),
    not(member(C,V)),
    river_aux(C,B,[C|V],Plan),
    P = [Action | Plan].
	
	
?- river(P).
P = [bring_goose_over, farmer_comes_back, bring_fox_over, bring_goose_back, bring_beans_over, farmer_comes_back, bring_goose_over] ;
P = [bring_goose_over, farmer_comes_back, bring_beans_over, bring_goose_back, bring_fox_over, farmer_comes_back, bring_goose_over] ;
false.