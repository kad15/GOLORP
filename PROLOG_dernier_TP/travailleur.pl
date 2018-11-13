% avec variables booléennes : Xij = si travailleur i rélaise produit j
sol(L) :- L=([X11, X12, ..., X44],fd_domain_bool(L).

%chaque travailleur n'a qu'un produits
X11+X12+X13+X14 #=1, etc pour somme Xij sur j j = 1 à 4

%chaque produit est réalisé par un seul travailleur1
X11+X21 +X31+X41 #=1      x4 pour i = 1 à 4


%objectif 
Profit #= 7 * X11 + 1 * X12 + ...

%résolution

fd_maximize(fd_labelling(L), Profit)

% travailleur 1 affecté à 1, 2 à 2, etc 
% 4 1 2 3  w1 fait le prod 4, 1 fait 2,
% profit max = 19