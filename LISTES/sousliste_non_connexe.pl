% sl/2 prédicat vrai si Liste1 contient les élements dans liste 2
% l'ordre est conservé mais les elt de liste1 ne sont pas forcément
% consécutifs ds liste2.
% sl(Sousliste, Surliste).

sl([],_). % cas de base : la liste vide est sous liste de toute surliste

% en parcourant la surliste = liste 2,
%arrivé à X, soit cet X fait partie de la sous liste
sl([H|T], [H|L]) :- sl(T,L).
% soit il n'en fait pas partie
sl(S,[_|L]) :- sl(S,L).



% test : sl([a,c,d,e], [a,b,c,d,e,f]). doit donner vrai