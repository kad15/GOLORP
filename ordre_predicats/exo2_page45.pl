p(a,b).
s1(b).
s1(X) :- p(X,Y),s1(Y).
s2(b).
s2(X) :- s2(Y), p(X,Y).