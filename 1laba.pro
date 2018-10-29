/*****************************************************************************

		Copyright (c) My Company

 Project:  1LABA
 FileName: 1LABA.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
 
1.	(X+6)^2+Y/lg(3.56)
2.	(25+Y+X^2)/(6Y^X*sin(330o))

******************************************************************************/

include "1laba.inc"

predicates
	solution(integer,integer,real)
	solution1(integer,integer,real)
	pow(real, integer, real)
clauses
	solution(X, Y, Z):- log(3.56)<>0, Buff2 = X + 6, pow(Buff2, 2, VP), Z = VP + Y/log(3.56).
	
	solution1(X, Y, Z):- Buff1 = 6*Y, pow(Buff1, X, VP), Buff = VP*sin(330), Buff<>0, pow(X, 2, VPP), Z = (25 + Y + VPP)/Buff.
	
	pow(Value, 0, 1):-!.
	pow(Value, Power, ValuePower):- Power > 0, !, TailPower = Power - 1, 
					pow(Value, TailPower, TailValuePower), 
					ValuePower = TailValuePower*Value.
	pow(Value, Power, ValuePower):- TailPower = Power + 1, 
					pow(Value, TailPower, TailValuePower), 
					ValuePower = TailValuePower/Value.
goal
	write("x = "), readInt(X), nl,
	write("y = "), readInt(Y), nl, 
	solution(X, Y, Z), 
	write("z ="), write(Z), nl.
