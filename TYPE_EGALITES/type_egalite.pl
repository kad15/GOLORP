1 - X = Y   PREDICAT qui réussit quand X et Y s'identifient.

2 - X is E  : permet d'évaluer l'expression arithmétique
à droite  et l'unifie à X. X situé à gauche n'est pas évalué !!!
Ainsi 2+1 is 2+1 est faux !!!
 car seul le 2+1 de droite est évalué à 3.
les expressions peuvent contenir des variables mais elle doivent
être unifiées à une valeur numérique anterieurement à une 


3 - The following infix binary predicates expect arithmetic expressions
on both sides: <, >, =<, >=, =:=, =\=.
They evaluate the two expressions, and compare the results.
(X=:=Y is true if the value of X is equal to the value of Y,
and X=\=Y is true if the value of X is different from that of Y).
2 +1 =:= 2+1 est ici vrai car les deux côtés sont évalués.
ici aussi toutes les variables doivent être unifiées au préalable.

4 - EGALITE LITTERALE ENTRE DEUX TERMES 
T1 == T2 vrai si identiques i.e. ont exactememt la même structure
le contraire est T1 \== T2


  