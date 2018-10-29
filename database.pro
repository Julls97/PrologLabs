/*****************************************************************************

		Copyright (c) My Company

 Project:  DATABASE
 FileName: DATABASE.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
 Создать базу данных с расписанием движения поездов: 
 номер поезда, пункт назначения, время отправления, время в пути, стоимость билета. 
 Найти номер и время отправления самого скорого поезда до Москвы.
******************************************************************************/

include "database.inc"

database -trains_db nondeterm train(d_train_number, d_destination, d_departure_time, d_time, d_cost)

goal
	menu(0).

domains
	d_train_number = integer
	d_destination = string
	d_departure_time = string
	d_time = real
	d_cost = integer
	
predicates
	menu(integer)
	print_train_information(d_train_number, d_destination, d_departure_time, d_time, d_cost)
	print_all_trains
	list_to_set([], [])

clauses
	menu(0):- 
	  	write("1 - dump all database"), nl,
	  	write("2 - insert train in database"), nl, 
	  	write("3 - remove train from database"), nl, 
	  	write("4 - exit"), nl, 
	  	write(": "), readint(MenuPoint), 
	  	menu(MenuPoint), !.
    
	menu(1):- 
		Destination(Train_number, Destination, Departure_time, Time, Cost), 
		print_train_information(Train_number, Destination, Departure_time, Time, Cost), nl, fail; !, 
		menu(0).
 
	menu(2):- 
		print_all_trains,
		write("Train_number: "), readint(Train_number), 
		Destination(Train_number, _Destination, _Departure_time, _Time, _Cost),
		write("Destination: "), readln(Destination), 
		write("Departure_time: "), readln(Departure_time),
		write("Time: "), readReal(Time), 
		write("Cost: "), readint(Cost), 
		assert(Destination(Train_number, Destination, Departure_time, Time, Cost)), !, menu(0);
		write("Error: wrong data"), nl, !, menu(0).
	
	menu(3):- 
		write("Train_number: "), readln(Train_number), 
		retract(Train_number(Train_number, _Destination, _Departure_time, _Time, _Cost)), !, 
		menu(0);
		write("Error: wrong Train_number"), nl, !, 
		menu(0).
		
	menu(4):-!.
	menu(_):- 
		write("Error: bad menu point"), nl, !, menu(0).
	
	
	train (7845, "Msk", "12.00", 4.52, 1450).
	train (9152, "Spb", "10.00", 4.16, 2490).
	train (2345, "Msk", "16.30", 5.02, 1300).		
	train (3321, "Chlb", "02.00", 14.52, 5930).
	train (6520, "Kz", "9.45", 1.48, 3195).
	train (9874, "Msk", "06.20", 5.22, 1460).
	
	list_to_set([], []):-!.
	list_to_set([Head|Tail], [Head|TailSet]):- NOT(member(Head, Tail)), !, list_to_set(Tail, TailSet).
	list_to_set([_Head|Tail], TailSet):- list_to_set(Tail, TailSet).
	
	print_all_trains:- 
		findall(Train_number, train(Train_number, _Destination, _Departure_time, _Time, _Cost), Train_numbers),
		list_to_set(Train_number, [], UniqueTrain_numbers), 
		write(UniqueTrain_numbers), nl.
	
	
	print_train_information(Train_number, Destination, Departure_time, Time, Cost):-
		write("Train_number: "), write(Train_number), nl,
		write("Destination: "), write(Destination), nl,
		write("Departure_time: "), write(Departure_time), nl,
		write("Time: "), write(Time), nl,
		write("Cost: "), write(Cost), nl.
    
	print_Destinations([]):-!.
	print_Destinations([HeadDestination|TailDestinations]):-  
		Destination(Continent, HeadDestination, Departure_time, Time, Cost), !,
		print_train_information(Continent, HeadDestination, Departure_time, Time, Cost), nl, 
		print_Destinations(TailDestinations).

