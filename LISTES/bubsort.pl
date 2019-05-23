

swap(list,list).
swap([X,Y|List],[Y,X|List]) :- X > Y.
swap([Z|List],[Z|List1]) :- swap(List,List1).
    
% Clauses
    bubsort(list,list).
    bubsort(InputList,SortList) :-
        swap(InputList,List) , ! ,
        % printlist(List),
        bubsort(List,SortList).
    bubsort(SortList,SortList).
    
   
	
    % printlist(list).
    % printlist([]) :- nl.
    % printlist([Head|List]) :-
        % write(Head, " "),
        % printlist(List).



% test : bubsort([4,9,1,10,2], S).