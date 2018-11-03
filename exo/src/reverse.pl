length(L,n):-
% vrai si N est la longueur de la liste L        [a,b,c],res
   L=[_|R],length(R,M),
   N is M+1;
   L=[],N=0.
   
length(L,N):-
  N>0, M is N-1,
  length(LL,M);
  N=0,L=[]
  
  
  %predicat length dit si les prédicats sont instanciés