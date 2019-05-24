% Examen mai 2019 BELDJILALI ENAC

% Exo 1
% 1.1

%geq1([H|T],Y) :- H<Y,geq1(T,Y).

% test : geq1(A,3). 






%Exo 2
edge(a,c,1).
edge(c,e,2).
edge(d,f,4).
edge(a,d,2).
edge(e,f,2).
edge(d,b,6).

%Q2.1

last2([X],X). % cas de base
last2([_|T],X):-last2(T,X). % cas 

% test last2([a,b,c,d], X). 
% Q2.2
ajout_der(X,L, D) :- append(L,[X],D).  
extend([L,Cost],[D,Cost2]) :- last2(L,X), edge(X,Y,C), ajout_der(Y,L,D), Cost2 is Cost+C. 

% test : extend([[a,d],2], P).
% reponse : 
% ?- extend([[a,d],2], P).
% P = [[a,d,f],6] ? a
% P = [[a,d,b],8]

% Q2.3
all_extensions(M,L) :- findall( P, extend(M,P),L). 
% reachable(X,L) :- setof(Y, Cost ^ path(X,Y,[], Cost), L).

% test : all_extensions([[a,d],2],L).
 % ?- all_extensions([[a,d],2],L).
% L = [[[a,d,f],6],[[a,d,b],8]]



%Q2.4 insert_sorted/3 
insert_sorted(X,[Y|T], R) :- X = [_,Costx], Y=[_,Costy], Costx < Costy, R=[X,Y|T].
insert_sorted(X,[Y|T], [Y|P]) :- X = [_,Costx], Y=[_,Costy], Costx >= Costy, insert_sorted(X,T,P). % R=[X,Y|T].

% test : insert_sorted([[a,c,e],3],[[[a,c],1],[[a,d,f],6]], R).
% insert_sorted([[a,c,e],3],[[[a,c],1],[[a,d,f],6]], R).
% R = [[[a,c],1],[[a,c,e],3],[[a,d,f],6]] ? 


% Q2.5 




% Exo 3 
% Ti instant début tache i
% Pi tache qui précede la tache i
% Ci cout genere par i, 0 si tache i fini à temps sinon penalité i
% C cout global somme des couts des taches

%Q3.1
% fd_domain(T, 0,5).
%  les T= [T1, ...] sont compris entre 0 et 5

Q3.2 

% 1 
TPi + dPi #=< Ti % debut tache precedente + durée inferieure à debut tache i
% cstr précédence

% 2
Pi = 0 #=> Ti #= di.

% 3 Ti Ci
Ti <= fi #=> Ci #=0.
Ti > fi #=> Ci #=pi.

% 4 C Ci
C #= C1+C2+C3+C4+C5. 


sol(P) :- L=[A,B,C,D,E], T= [T1,T2,T3,T4,T5],P= [P1,P2,P3,P4,P5],
	fd_domain(T,0,5),
	 
	append(T,P,Vars),
	Goal = fd_labeling(Vars),
	
    C #= C1+C2+C3+C4+C5.
	fd_minimize(Goal,C), nl, write('reponse: '), write(C).
