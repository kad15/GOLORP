%flatten a list c'est applatir la tête, puis la queue puis concaténer
flatten2([X|T],R):- flatten(X,FX), flatten(T,FT), append(FX,FT,R).
flatten2(X,[X]).
flatten2([],[]).
% flatten2([a,b,[c,d],[],[[[e]]],f], L).
