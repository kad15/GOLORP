% append L1 L2
reachable(X,L):-findall(Y,path(X,Y),L).


%ou findall(Y,(edge(X,Y);edge(X,Z);path(Z,Y)),L).