/* Predicats pour utiliser la base de donnees de vols */
/* Version 15 sept 2010 enac - gnu prolog */

:-op(500,xfx,h).

avant([H1,M1],[H2,M2])
/* Vrai si l'horaire représenté par [H1,M1] est
   avant l'horaire représenté par [H2,M2]: */
:- H1 < H2
 ; H1 =:= H2 , M1 =< M2.

ajouter([H1,M1],[H2,M2],[H3,M3])
/* Vrai si [H3,M3] est l'horaire obtenu en ajoutant
   le délai [H2,M2] à l'horaire [H1,M1]: */
:- M is M1+M2 , 
   ( ( M < 60, H3 is H1+H2, M3=M )
   ; ( M >= 60, H3 is H1+H2+1, M3 is M-60) ).

voyageA(AD,HDMin,AA,HAMax,Prix,Vols)
/* vrai s'il est possible de se rendre de l'aéroport AD à l'aéroport AA, en partant après l'heure HD, et en arrivant
avant l'heure HA. En cas d'escale, on laisse au moins 30 minutes pour changer d'avion dans un même aéroport, et 2 heures s'il faut changer d'aéroport.
*/
:- vol(C,N,AD,AI,HD,HA) , avant(HDMin,HD)
,  aeroport(VD,AD) ,  aeroport(VI,AI) 
,  ( AI = AA , avant(HA,HAMax) , VolsSuiv=[] , taxe(VI,PP)
   ; ajouter(HA,[0,30],HA30) , voyageA(AI,HA30,AA,HAMax,PP,VolsSuiv)
   ; ajouter(HA,[2,00],HA2)
     , aeroport(VI,AII) , AII \= AI
     , voyageA(AII,HA2,AA,HAMax,PP,VolsSuiv)
   )
,   Vols=[vol(C,N,AD,AI,HD,HA)|VolsSuiv]
,  taxe(VD,TaxeDep)
,  tarif(C,VD,VI,PrixVol),
   Prix is PP+PrixVol+TaxeDep.

write_list(L)
/* Vrai si L est une liste; afficher
   sur la sortie courante tous les éléments
   de la liste. */
:- L=[] ; L=[X|LL] , write(X) , write_list(LL).

afficher_vol(vol(C,N,AD,AA,TD,TA))
/* Afficher un vol sur la sortie courante. */
:- aeroport(VD,AD), aeroport(VA,AA),
   write_list(['vol ',C,' ',N,' : ',VD/AD,' ',TD]),
   write_list([' --> ',VA/AA,' ',TA]),
   nl.

afficher_voyage(L,P)
:- L=[] , write('Prix total : '), write(P) , nl
;  L=[vol(C,N,AD,AA,TDV,TAV)|LL]
,  write_list([AD,' @ ',TDV,' --> ',AA, ' @ ', TAV, ' : ',C,N]) , nl
,  afficher_voyage(LL,P).

meilleurPrix(VD,HDMin,VA,HAMax,LM)
:- findall([L,P]
          ,(aeroport(VD,AD) , aeroport(VA,AA)
           , voyageA(AD,HDMin,AA,HAMax,P,L))
          ,VV)
, meilleurPrix(VV,[LM,PM]) , afficher_voyage(LM,PM).

meilleurPrix([[L,P]|VV],[LM,PM]) :- meilleurPrix(VV,[L,P],[LM,PM]).
meilleurPrix([],[L,P],[L,P]).
meilleurPrix([[L1,P1]|VV],[L2,P2],[LM,PM])
:- ( P1 < P2 , [L,P]=[L1,P1] ; P1 >= P2 , [L,P]=[L2,P2] )
, meilleurPrix(VV,[L,P],[LM,PM]).


ajouter_vol
/* Permet d'insérer un nouveau vol dans la base
   de donnée, après un bref dialogue avec
   l'utilisateur. 
   (Suppose que le prédicat vol ait été déclaré
   comme étant dynamique.) */
:- write('aeroport de depart ? '), read(AD),
   aeroport(VD,AD),
   write('aeroport d\'arrivee ? '), read(AA),
   aeroport(VA,AA),
   write('Heure de depart ? (x,x) '), read(HD),
   write('Heure d\'arrivee ? (x,x) '), read(HA),
   write('Code compagnie ? '), read(C),
   write('Numero de vol ? '), read(N),
   write('prix ?'), read(P),
   write('inserer '),  write(vol(C,N,AD,AA,HD,HA)),
   write(' et '), write(tarif(C,VD,VA,P)),
   write(' ? (oui/non) '), read(Reponse),
   ( ( Reponse = oui, asserta(vol(C,N,AD,AA,HD,HA)),
       asserta(tarif(C,VD,VA,P)) )
   ; ( Reponse \== oui, write('abandon'), nl ) ).


choix_aleatoire(L,X)
/* Vrai si L est une liste non vide, et si
   X est un élément de L, choisi au hasard. */
:- length(L,N), R is random(N), nth0(R,L,X).


explorer(VD/AD,HMin,NbIt)
/* Vrai si VD est un aéroport de la ville VD,
   si HMin est un horaire, et si NbIt est
   un entier. Affiche une succession de vols,
   correspondant à une exploration aléatoire
   de la base de vols. */
:- ( (NbIt=0,true)
   ; (NbIt>0,
      findall(V,vol_possible(VD/AD,HMin,V),LVols),
      ( ( LVols=[_|_], choix_aleatoire(LVols,V),
          afficher_vol(V), V = vol(_,_,AD,AA,_,TA),
          findall(ADD,(aeroport(VA,AA),aeroport(VA,ADD)),LAerop),
          choix_aleatoire(LAerop,ADD), 
          ( ( ADD = AA, ajouter(TA,[0,30],TDD) )
          ; ( ADD \== AA, ajouter(TA,[2, 0],TDD) ) ) )
      ; ( LVols=[],
          findall(VA,aeroport(VA,_),LV),
          choix_aleatoire(LV,VA), TDD = [0,0],
          write('teletransport...'), write(VA), nl ) ),
      NbItNouv is NbIt -1, explorer(VA/ADD,TDD,NbItNouv) ) ).
