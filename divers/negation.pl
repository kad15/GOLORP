animal(dog).
animal(cat).
animal(cobra).
snake(cobra).


likes(mary,X) :- snake(X), !, fail.
likes(mary,X) :- animal(X).