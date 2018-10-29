/*****************************************************************************

		Copyright (c) My Company

 Project:  RECURSION
 FileName: RECURSION.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
 Дано натуральное число n. Дописать к нему цифру k в конец и в начало. 
******************************************************************************/

include "recursion.inc"

domains
	int = integer

predicates
	calc(int, int, int, int, int)
	main(int, int, int)

clauses
	calc(N,K,P,NN,R) :- N < 10, R = NN*10 + K + (K*P*10), !.
	calc(N,K,P,NN,R) :- N1 = N/10, P1 = P*10, calc(N1,K,P1,NN,R).
	main(N, K, R) :- calc(N,K,10,N,R).
	
goal
	write("N = "), readInt(N), nl,
	write("K = "), readInt(K), nl,
	main(N, K, R), write(R), nl.
