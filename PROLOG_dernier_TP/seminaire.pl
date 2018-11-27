% A à F entier de 1 à 4 qui sont les num de salles
% HA heure d'une présentation du séminaire A
% fd_all_different(L)

% findall(X, (sem(X,D,F),D=<10, 10=<F), L).


maxlist([X],X).
maxlist([X,Y|L],MAX):- X > Y, maxlist([X|L], MAX).
maxlist([X,Y|L],MAX):- X =< Y, maxlist([Y|L], MAX).

sem(a,A,10,12).
sem(b,B,10,11).
sem(c,C, 9,11).
sem(d,D,12,14).
sem(e,E,12,13).
sem(f,F,13,15).

solution(L) :- 
	L = [A,B,C,D,E,F],
	fd_domain(L,1,NbSalles),
	fd_domain(HA,10,12),
	fd_domain(HB,10,11),
	fd_domain(HC,9,11),
	fd_domain(HD,12,14),
	fd_domain(HE,12,13),
	fd_domain(HF,13,15),
	HA#=HB #==> A #\= B.
						
						
/*						
						
						NbSalles #= (),
			fd_minimize(fd_labeling(L), NbSalles).
			
			
client(N,A,D).
*/