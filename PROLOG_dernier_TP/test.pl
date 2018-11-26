 solve(X,Y) :- X + Y #= 10 , Y #< 3 , fd_minimize(fd_labeling([X,Y]),X).
 
 %X #< 3 , X + Y #= 6 , fd_labeling([X,Y]).