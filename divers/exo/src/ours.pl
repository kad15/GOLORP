gros(ours).
gros(elephant).
petit(chat).

brun(ours).
noir(chat).
gris(elephant).

sombre(Z):- noir(Z).

sombre(Z):-brun(Z).

X=f(X).