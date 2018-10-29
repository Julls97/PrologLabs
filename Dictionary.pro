/*****************************************************************************

		Copyright (c) My Company

 Project:  DICTIONARY
 FileName: DICTIONARY.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
 Составить программу, реализующую словарь. В словаре содержится следующая информация: 
 слово и его перевод (русские и английские слова). 
 Реализовать вывод всего словаря, перевод с русского на английский, с английского на русский.
******************************************************************************/

include "dictionary.inc"

domains
	ru, eng = symbol

predicates
	dictionary(ru, eng)
	dictionary_all()

clauses
	dictionary(мама, mother).
	dictionary(папа, father).
	dictionary(брат, brother).
	dictionary(сестра, sister).
	dictionary(кошка, cat).
	dictionary(собака, dog).
	
	dictionary_all():- dictionary(X, Y), write(X, " = ", Y), nl, fail.

goal
	dictionary(кошка, X), write("Кошка по-английски '", X, "'."), nl,
	dictionary(Y, cat), write("Cat по-русски '", Y, "'."), nl,
	dictionary_all(), nl.