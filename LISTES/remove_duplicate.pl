remove_duplicates([], []).

remove_duplicates([Head | Tail], Result) :-
		member(Head, Tail),!,
		remove_duplicates(Tail, Result).
		
remove_duplicates([Head | Tail], [Head | Result]) :-
		remove_duplicates(Tail, Result).
		
		
% le goal member réussit si la tete de liste est aussi dans la queue.
% ensuite le sous goal suivant à savoir le cut "!" réussira également,
% sans ce cut il aurait été possible de backtracker. mais passer le cut, il n'est 
% plus possible de backtracker. on aura qu'une solution.

	
