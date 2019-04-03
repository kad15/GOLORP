age(peter, 7).
age(ann, 5).
age(pat, 8).
age(tom, 5).

%liste des enfants de 5 ans 
enfants5ans(L) :- bagof(Child, age(Child,5), L).
