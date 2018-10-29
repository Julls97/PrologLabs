/*****************************************************************************

		Copyright (c) My Company

 Project:  LAB1
 FileName: LAB1.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments: readInt readreal
 
Задание 1.	X*2+56-Y/X+cos(X*?)
Задание 2.	(ln(27))X*Y+9(X-Y)

******************************************************************************/

include "lab1.inc"

predicates
	solution(real,real,real)
	solution1(real,real,real)
	pow(real, integer, real)
clauses
	solution(X, Y, Z):- X<>0, Z = X*2 + 56 - Y/X + cos(X*Y).
	solution1(X, Y, Z):- LN = log(27), XY = X*Y, pow(LN, XY, VP), Z = VP + 9 * (X-Y).
	
	pow(Value, 0, 1):-!.
	pow(Value, Power, ValuePower):- Power > 0, !, TailPower = Power - 1, 
					pow(Value, TailPower, TailValuePower), 
					ValuePower = TailValuePower*Value.
	pow(Value, Power, ValuePower):- TailPower = Power + 1, 
					pow(Value, TailPower, TailValuePower), 
					ValuePower = TailValuePower/Value.
goal
	write("x = "), readInt(X),
	write("y = "), readInt(Y), 
	solution1(X, Y, Z), 
	write("z ="), write(Z), nl.
