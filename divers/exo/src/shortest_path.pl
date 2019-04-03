edge(a,b,6).
edge(a,c,1).
edge(b,d,5).
edge(c,e,4).
edge(c,f,1).
edge(d,h,3).
edge(e,h,7).
edge(f,g,2).
edge(g,h,1).

path(X,Y,M,[Y]) :- edge(X,Y,M).
path(X,Y,P,[Z|T]) :- edge(X,Z,M),path(Z,Y,N,T),
            P is M+N.
            
            
            
/*
pravilo(X,Y,Z) :-  assert(min(100)),assert(minpath([])),!,
                path(X,Y,K,PATH1),
                (min(Z),K<Z,
                retract(min(Z));assert(min(K))),
                minpath(Q),retract(minpath(Q)),
                assert(minpath([X|PATH1])),
                fail.

?- pravilo(a,h,X);
    write("Minimal Path:"),
    minpath(PATH),
    write(PATH),
    nl,
    write("Path weight:"),
    min(Z),
    write(Z).
*/