% inclus(S,L) vrai si tous les élements de S sont dans L ie S inclus dans L
% les élément ne se suivent pas forcément

inclus([],_). % cas de base la liste vide est incluse dans toute liste
inclus([H|T],[H|R]):-inclus(T,R). % 1er elements des deux listes egaux
inclus(S,[_|R]):-inclus(S,R).  % 


inclus2([],_).  % condition d'arrêt
inclus2([V|R],D) :- member(V,D), inclus2(R,D).