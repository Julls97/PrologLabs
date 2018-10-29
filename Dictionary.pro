/*****************************************************************************

		Copyright (c) My Company

 Project:  DICTIONARY
 FileName: DICTIONARY.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
 ��������� ���������, ����������� �������. � ������� ���������� ��������� ����������: 
 ����� � ��� ������� (������� � ���������� �����). 
 ����������� ����� ����� �������, ������� � �������� �� ����������, � ����������� �� �������.
******************************************************************************/

include "dictionary.inc"

domains
	ru, eng = symbol

predicates
	dictionary(ru, eng)
	dictionary_all()

clauses
	dictionary(����, mother).
	dictionary(����, father).
	dictionary(����, brother).
	dictionary(������, sister).
	dictionary(�����, cat).
	dictionary(������, dog).
	
	dictionary_all():- dictionary(X, Y), write(X, " = ", Y), nl, fail.

goal
	dictionary(�����, X), write("����� ��-��������� '", X, "'."), nl,
	dictionary(Y, cat), write("Cat ��-������ '", Y, "'."), nl,
	dictionary_all(), nl.