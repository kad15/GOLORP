%P:-Q,R.


% P Q R sont des termes, P est la tête, Q,R les buts constituent la queue de la clause


%déclarativement on lit cette clause : 
% P est vrai si Q et R sont vrais
%ou
%  Q et R impliquent P

% de manière PROCEDURAL, il faut d'abord résoudre le problème Q,
% puis le problème R.
%ou
%pour effacer P, il faut d'abord effacer Q, puis R



% faire du prolog c'est définir des relations dans une "base"
%et interroger prolog sur cette base.

% un programme est constitué de clauses
%de 3 types : faits, règles et questions

%les clauses sont constituées d'une tête P et d'une queue e.g. P,Q
% P et Q sont des buts reliée par un ET(conjonction) representé par une virgule
% les faits ne sont pas conditionnés à des buts. e.g. P. est un fait P:-P,Q est une règle
%

%une procédure est un ensemble de clauses concernant une meme relation
 
