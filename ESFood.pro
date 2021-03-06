/*****************************************************************************

		Copyright (c) My Company

 Project:  ESFOOD
 FileName: ESFOOD.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "esfood.inc"

global database

  xpositive(symbol,symbol)

  xnegative(symbol,symbol)

predicates

  do_expert_job

  do_consulting

  ask(symbol,symbol)

  dog_is(symbol)

  it_is(symbol)

  positive(symbol,symbol)

  negative(symbol,symbol)

  remember(symbol,symbol,symbol)

  clear_facts

goal

  do_expert_job .

clauses

/* �������� ����������������� ���������� */

  do_expert_job:- makewindow(1, 7, 7, "������� ��  ������� �����", 1, 16, 22, 58),

         nl,write(" * * * * * * * * * * * * * * * * * * * * *  "),

         nl,write("          ����� ����������!          "),nl,nl,

         nl,write(" ���������� ������������� ������ "),nl,nl,

         nl,write(" ���������, ����������, '��' ��� '���' "),

         nl,write(" � ������� � ������, ������ ������� "),

         nl,write(" �� ������ ���������� "),

         nl,write(" * * * * * * * * * * * * * * * * * * * * * * "),

         nl,nl,do_consulting,write("������� ����� �������"),

         nl, readchar(_), removewindow.

  do_consulting:- dog_is(X), !, nl, write("�������� ���� ������ � ",X,"."),

                              nl,clear_facts.

  do_consulting:- nl, write("��������, � �� ����� ������ ���!"),

                              clear_facts.

  ask(X,Y):- write(" ?:� ",X, "  ",Y, " ?  "), readln(Reply),

                     remember(X,Y,Reply).

/* �������� ������ */

  positive(X,Y):- xpositive(X,Y),!.

  positive(X,Y):- not(negative(X,Y)),!,ask(X,Y).

  negative(X,Y):- xnegative(X,Y),!.

  remember(X,Y,yes):- asserta(xpositive(X,Y)).

  remember(X,Y,no):- asserta(xnegative(X,Y)),fail.

 

  clear_facts:- retract(xpositive(_,_)), fail.

  clear_facts:- retract(xnegative(_,_)), fail. 

/*  ������������� ������� */

  dog_is("���������� �������"):- it_is("��������������� ������"),

                              positive("��","������ � ����� �� �����  57 ��"),

                              positive("� ���","����� ���������� �����"),

                              positive("� ���","����������� ��������"),!.

  dog_is("������"):- it_is("��������������� ������"),

                              positive("��","������ � ����� �� �����  57 ��"),

                              positive("� ���","������� ���"),

                              positive("� ���","����������� ��������"),!.

  dog_is("�������� ���"):- it_is("��������������� ������"),

                              positive("� ���","����� ���������� �����"),

                              positive("� ���","����������� ��������"),

                              positive("��","��� ����� 45 ��"),!.

  dog_is("������������ ���������"):- it_is("��������������� ������"),

                              positive("��","������ � ����� �� �����  77 ��"),

                              positive("� ���","������� ���"),

                              positive("� ���","����������� ��������"),!.

  dog_is("����� ��������"):- it_is("�������������� ������"),

                              positive("��","������ � ����� �� �����  57 ��"),

                              positive("� ���","����� ���������� �����"),

                              positive("� ���","������� ���"),

                              positive("� ���","����������� ��������"),!.

  dog_is("����������  ������"):- it_is("�������������� ������"),

                              positive("��","������ � ����� �� �����  77 ��"),

                              positive("� ���","������� ���"),!.

  dog_is("�����"):- it_is("�������������� ������"),

                              positive("��","������ � ����� �� �����  77 ��"),

                              positive("� ���","����� ���������� �����"),

                              positive("� ���","����������� ��������"),!.

  dog_is("���������"):- it_is("�������������� ������"),

                              positive("� ���","����� ���������� �����"),

                              positive("� ���","����������� ��������"),

                              positive("��","��� ����� 45 ��"),!. 

  it_is("��������������� ������ "):- positive("���","��������������� ������ "),!.

  it_is("�������������� ������ "):- positive("���","�������������� ������ "),!.