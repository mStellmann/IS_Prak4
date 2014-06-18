:- use_module(library(clpfd)).
:- consult(spielfelder).

% loesen eines Sudokus
% Spielfeld_Zeilen : Liste<Liste<Zahl>>
sudoku(Spielfeld_Zeilen) :-
	% Pruefung ob es sich um ein gueltiges Spielfeld handelt
	% Groeße des Spielfelds: 9x9
	length(Spielfeld_Zeilen, 9),
	% Pruefung das jede Reihe die gleiche Groeße besitzt
	maplist(length_(9), Spielfeld_Zeilen),
	
	% Zuweisung der Zahlen zu den einzelnen Feldern des Spielfelds
	append(Spielfeld_Zeilen, Werte), Werte ins 1..9,
	
	% Regel 1 - Alle Werte einer Reihe muessen eindeutig sein
	maplist(all_distinct, Spielfeld_Zeilen)
	
	% Erstellen der Spalten
	% Spielfeld_Spalten : Liste<Liste<Zahl>>
	transpose(Spielfeld_Zeilen, Spielfeld_Spalten),
	
	% Regel 2 - Alle Werte einer Spalte muessen eindeutig sein
	maplist(all_distinct, Spielfeld_Spalten),
	
	% Erstellen und Pruefung der 3x3-Felder
	Spielfeld_Zeilen = [Z1, Z2, Z3, Z4, Z5, Z6, Z7, Z8, Z9],
	% oberen 3 Felder
	teste3x3Felder(Z1, Z2, Z3),
	% mittleren 3 Felder
	teste3x3Felder(Z4, Z5, Z6),
	% unteren 3 Felder
	teste3x3Felder(Z7, Z8, Z9)
.

% --- Hilfsfunktionen ---
% Funktion damit man die Laenge mit Hilfe von maplist/2 ueberpruefen kann
length_(Wert, Liste) :- length(Liste, Wert)

% Erstellt 3x3-Felder und ueberprueft diese auf die Eindeutigkeit der enthaltenen Werte
% Es werden 3 Zeilen eines Spielfeldes als Parameter erwartet
% Rekursive Abbruchbedingung - Alle 3 Felder wurden ueberprueft
teste3x3Felder([], [], []).
teste3x3Felder([F1, F2, F3 | Tail1], [F4, F5, F6 | Tail2], [F7, F8, F9 | Tail3]) :-
	% Eindeutigkeitspruefung des Feldes
	% Regel 3 - Alle Felder eines 3x3-Feldes muessen eindeutig sein
	all_distinct([F1, F2, F3, F4, F5, F6, F7, F8, F9]),
	% Rekursion um das naechste Feld zu ueberpruefen.
	teste3x3Felder(Tail1, Tail2, Tail3)
.
