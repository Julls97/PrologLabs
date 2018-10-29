/*****************************************************************************

		Copyright (c) My Company

 Project:  DB_CARS
 FileName: DB_CARS.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "db_cars.inc"

domains
  d_continent = string
  d_state = string
  d_square = real
  d_population = real
  d_capital = string
  
  d_continents = d_continent*
  d_populations = d_population*
  d_states = d_state*
  
  list = string*

database -states_db
  nondeterm state(d_continent, d_state, d_square, d_population, d_capital)
  
predicates
  menu(integer)
  
  print_state_information(d_continent, d_state, d_square, d_population, d_capital)
  print_states_by_continent_information(d_continent)
  print_sorted_by_populations(d_states, d_populations)
  
  list_to_set(d_continents, d_continents, d_continents)
  nondeterm member(d_continent, d_continents)
  nondeterm member(d_state, d_states)
  
  qsort(d_populations, d_populations)
  divide(d_populations, d_population, d_populations, d_populations)
  append(d_populations, d_populations, d_populations)
  
  print_states(d_states)
  filter_states_by_population(d_states, d_population, d_population, d_states)
  
  delete_single_element(d_states, string, d_states)
  select(string, d_states, d_states)
  
  print_continents
  
clauses
  state ("Europe", "United Kingdom", 244.0, 57077.0, "London").
  state ("Europe", "Italy", 301.0, 57441.0, "Rome").
  state ("Asia", "Indonesia", 1905.0, 179140.0, "Jakarta").
  state ("Asia", "Iraq", 435.0, 17655.0, "Baghdad").
  state ("Asia", "Iran", 1648.0, 52522.0, "Tehran").
  state ("Asia", "Kuwait", 18.0, 2050.0, "Kuwait").
  state ("Asia", "Oman", 212.0, 1377.0, "Muscat").
  state ("Asia", "Saudi Arabia", 2150.0, 14430.0, "Al-Riyadh").
  state ("Africa", "Libya", 1760.0, 4232.0, "Tripoli").
  state ("North America", "USA", 9373.0, 248251.0, "Washington").
  state ("South America", "Argentina", 2767.0, 31930.0, "Buenos Aires").

  print_continents:-
    findall(Continent, state(Continent, _State, _Square, _Population, _Capital), Continents),
    list_to_set(Continents, [], UniqueContinents),
    write(UniqueContinents), nl.

  print_state_information(Continent, State, Square, Population, Capital):-
    write("Continent: "), write(Continent), nl,
    write("State: "), write(State), nl,
    write("Square: "), write(Square), nl,
    write("Population: "), write(Population), nl,
    write("Capital: "), write(Capital), nl.
    
  print_states([]):-!.
  print_states([HeadState|TailStates]):-
    state(Continent, HeadState, Square, Population, Capital), !,
    print_state_information(Continent, HeadState, Square, Population, Capital), nl,
    print_states(TailStates).

  print_states_by_continent_information(Continent):-
    state(Continent, State, Square, Population, Capital),
    print_state_information(Continent, State, Square, Population, Capital), nl,
    fail; !.

  filter_states_by_population([], _Lower, _Higher, []):-!.
  filter_states_by_population([HeadState|TailStates], Lower, Higher, [HeadState|FilteredTail]):-
    state(_Continent, HeadState, _Square, Population, _Capital),
    Population >= Lower, Population <= Higher, !,
    filter_states_by_population(TailStates, Lower, Higher, FilteredTail).
  filter_states_by_population([_HeadState|TailStates], Lower, Higher, FilteredTail):-
    filter_states_by_population(TailStates, Lower, Higher, FilteredTail).
    
  print_sorted_by_populations([], []):-!.
  print_sorted_by_populations(States, [HeadPopulation|TailPopulations]):-
    state(Continent, State, Square, HeadPopulation, Capital),
    member(State, States), !, 
    delete_single_element(States, State, StatesWithoutState),
    print_state_information(Continent, State, Square, HeadPopulation, Capital), nl,
    print_sorted_by_populations(StatesWithoutState, TailPopulations).

  delete_single_element(List, Element, ListWithoutElement):- select(Element, List, ListWithoutElement), !.
    
  select(Elem, [Elem|Tail], Tail).
  select(Elem, [Head|Tail], [Head|ResultTail]):- select(Elem, Tail, ResultTail).   
    
  divide([], _Pivot, [], []):-!.
  divide([Head|Tail], Pivot, [Head|GreaterList], SmallerList):- Head >= Pivot, !, divide(Tail, Pivot, GreaterList, SmallerList).
  divide([Head|Tail], Pivot, GreaterList, [Head|SmallerList]):- divide(Tail, Pivot, GreaterList, SmallerList). 

  append([], List2, List2).
  append([Head|Tail], List2, [Head|TailResult]):- append(Tail, List2, TailResult).

  member(Elem, [Elem|_Tail]).
  member(Elem, [_Head|Tail]):- member(Elem, Tail).

  qsort([], []).
  qsort([Elem], [Elem]).
  qsort([Pivot|Tail], SortedList):-
    divide(Tail, Pivot, GreaterList, SmallerList),
    qsort(GreaterList, SortedGreaterList),
    qsort(SmallerList, SortedSmallerList),!,
    append(SortedSmallerList, [Pivot|SortedGreaterList], SortedList).

  /*list_to_set(List, Set):-list_to_set(List, [], ReverseSet), reverse(ReverseSet, Set).*/
    
  list_to_set([], Buffer, Buffer):-!.
  list_to_set([Head|Tail], Buffer, Set):- member(Head, Buffer), !, list_to_set(Tail, Buffer, Set); list_to_set(Tail, [Head|Buffer], Set).
    
  menu(0):-
    write("1 - dump all database"), nl,
    write("2 - select countries by continent"), nl,
    write("3 - select countries sorted by populations"), nl, 
    write("4 - select countries with population within the limits"), nl,
    write("5 - insert country in database"), nl,
    write("6 - remove entry from database"), nl,
    write("7 - exit"), nl,
    write(": "), readint(MenuPoint), 
    menu(MenuPoint), !.
  menu(1):-
    state(Continent, State, Square, Population, Capital),
    print_state_information(Continent, State, Square, Population, Capital), nl, fail;
    !, menu(0).
  menu(2):-
    print_continents,
    write("Select continent: "),  readln(SelectedContinent),
    state(SelectedContinent, _State, _Square, _Population, _Capital), 
    print_states_by_continent_information(SelectedContinent),
    menu(0), !; write("such continent do not exist"), nl, menu(0), !.
  menu(3):-
    findall(Population, state(_Continent, _State, _Square, Population, _Capital), Populations),
    findall(State, state(_Continent, State, _Square, _Population, _Capital), States),
    qsort(Populations, SortedPopulations),
    print_sorted_by_populations(States, SortedPopulations), 
    menu(0), !.
  menu(4):-
    write("lower population limit: "), readReal(Lower),
    write("higher population limit: "), readReal(Higher),
    findall(State, state(_Continent, State, _Square, _Population, _Capital), States),
    filter_states_by_population(States, Lower, Higher, FilteredStates),
    print_states(FilteredStates), menu(0), !.
  menu(5):-
    print_continents,
    write("Continent: "), readln(Continent), state(Continent, _State, _Square, _Population, _Capital),
    write("State: "), readln(State), 
    write("Square: "), readReal(Square),
    write("Population: "), readReal(Population),
    write("Capital: "), readln(Capital), 
    assert(state(Continent, State, Square, Population, Capital)), !, menu(0);
    write("Error: wrong data"), nl, !, menu(0).
  menu(6):-
    write("State: "), readln(State),
    retract(state(_Continent, State, _Square, _Population, _Capital)), !, menu(0);
    write("Error: wrong state"), nl, !, menu(0).
  menu(7):-!.
  menu(_):-
    write("Error: bad menu point"), nl, !, menu(0).
       

goal
  menu(0).
