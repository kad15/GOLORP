%Load the file, and submit queries to get: all flight numbers from Blagnac to Orly, flight numbers from
%Marseille to Paris, all London airports.

%Q6.1
q611(C,N):-vol(C,N,blagnac,orly,_,_).



q612(C,N) :- aeroport(marseille,AD),
			aeroport(paris,AD),
			vol(C,N,AD,AA,_,_).

q613(A) :- aeroport(londres,A).	

	
%Q6.2
/*Define a relation directConnection/4 such that connection(AD; HD; AA; HA) is true if there is a direct
flight from airport AD to airport AA leaving after time HD and arriving before HA.*/

avant([H1,M1],[H2,M2]):- H1<H2;(H1 =:= H2),(M1<M2).
directConnection(AD; HD; AA; HA):- vol(_,_,AA ,AD,H1,H2),avant(HD,H1),avant(H2,HA).




%6.3
/*Define now a relation route/4 such that route(AD; HD; AA; HA) is true if there is a sequence of flights
to go from airport AD to airport AA leaving after time HD and arriving before HA. In case of stopovers, there
must be at least 30 minutes if flights arrive and start from the same airport, and 2 hours if one must change airport
in the same city.
*/
add([H1,M1],[H2,M2],[HR,MR ]):- M is M1+M2,((M<60 ,MR=M,HR is H1+H2);(M=>60,MR is M-60;HR is H1+H2+1)).
same_town(A1,A2) :-aeroport(T,A1),aeroport(T,A2),A1\=A2.
delai(A1,A2,D):- same_town(A1,A2), D is 30 ( 
  
route(AD; HD; AA; HA):-directConnection(AD; HD; AA; HA); (vol route(AD; HD; AA; HA), ) 

6 et 7.


/* Base de donnees de vols */
/* Version 10 septembre 2010 */

:- dynamic(vol/6).
:- dynamic(tarif/4).
:- dynamic(taxe/2).
:- dynamic(aeroport/2).

vol(it,386,blagnac,cdg,[10,0],[10,55]).
vol(af,55,cdg,heathrow,[11,0],[11,45]).
vol(af,56,blagnac,gatwick,[14,30],[16,00]).
vol(it,387,blagnac,orly,[9,00],[9,45]).
vol(tat,32,blagnac,marignane,[11,00],[11,45]).
vol(tat,32,blagnac,marignane,[7,00],[7,45]).
vol(it,856,marignane,cdg,[8,30],[9,30]).
vol(it,857,marignane,orly,[8,45],[9,40]).
vol(af,65,marignane,heathrow,[13,00],[14,30]).
vol(af,66,marignane,gatwick,[9,00],[10,45]).
vol(ba,43,gatwick,jfk,[15,10],[17,30]).

taxe(londres,100).
taxe(paris,200).
taxe(toulouse,150).
taxe(marseille,160).
taxe(newyork,90).

tarif(it, toulouse, paris, 500).
tarif(af,paris,londres,600).
tarif(af,toulouse,londres,2500).
tarif(tat,toulouse,marseille,1500).
tarif(it,marseille,paris,700).
tarif(af,marseille,londres,2500).
tarif(ba,londres,newyork,3000).

aeroport(toulouse,blagnac).
aeroport(paris,cdg).
aeroport(paris,orly).
aeroport(marseille,marignane).
aeroport(londres,heathrow).
aeroport(londres,gatwick).
aeroport(newyork,jfk).





