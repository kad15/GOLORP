% sous liste S d'une liste L avec les élements 
% dans L qui se suivent 



% 2nd solution
% S sous liste de L si 
% si L se decompose en deux liste L1 et L2 
% et L2 en S et L3
%                L=L1+S+L3=L1+L2
% |*********L1******| |****S****|  |****L3****|
%                                L2=S+L3
% sl2(S,L):- append(L1,L2, L),append(S,L3,L2).

sl2(S,L):- append(_,L2, L),append(S,_,L2).

% sl2([1,2], [1,a,2]).


% solution directe ; ne fonctionne pas
% sl([],_).
% sl([X|T],[X|R]) :- sl(T,R).
% sl(S,[_|R]) :- sl(S,R).

%test  sl([1,2], [1,a,2]).