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
