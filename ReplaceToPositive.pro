/*****************************************************************************

		Copyright (c) My Company

 Project:  REPLACETOPOSITIVE
 FileName: REPLACETOPOSITIVE.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
 �������� ��� ��������� ������������� �������� �� �������� ������� �������� � ������ �����.
******************************************************************************/

include "replacetopositive.inc"

domains
	int = integer
	list = int*

predicates
	replacetofirst(list, int, list)
	main(list, list)

clauses
	main([H|T], [H|R]) :- replacetofirst(T, H, R).
	replacetofirst([], _, []).
	replacetofirst([H|T], HH, [HH|NewT]):- H > 0, replacetofirst(T, HH, NewT).
	replacetofirst([H|T], HH, [H|NewT]):- H <= 0, replacetofirst(T, HH, NewT).
	
goal
	write("[123, 2, 3, -2, -5, 3, -7, 8]"), nl, 
	main([123, 2, 3, -2, -5, 3, -7, 8], R), write(R), nl.
