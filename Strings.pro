/*****************************************************************************

		Copyright (c) My Company

 Project:  STRINGS
 FileName: STRINGS.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
 
 Создайте предикат, дополняющий все строки, хранящиеся в файле, символом "*" до самой длинной строки.
 
 main(FileName) :- file_str(FileName,S), write(S), nl, file_str("D:/output.txt", S).
 
 str_len("Санкт-Петербург", Length)
******************************************************************************/

include "strings.inc"

global domains
  file = input; output
domains
  list_str = string*
predicates
  file_str_to_list(file, list_str, list_str)
  
/*  
  print_longer_string(string)
  longest_string()
  add_stars()*/
clauses
/*  
  longest_string():- eof(input), !.
  longest_string():- readln(String),  print_longer_string(String), longest_string().
  print_longer_string(String):- Res = str_len(String, Length), Length < 2, !, write(String), nl; !.
  add_stars():- .*/

  file_str_to_list(File, Buffer, Buffer):- eof(File), !.
  file_str_to_list(File, Buffer, List):- readln(Number), write(Number), nl, !, file_str_to_list(File, [Number|Buffer], List).
  file_str_to_list(_File, _Buffer, _List):- write("bad file"), nl, fail.

  
goal 
  InputFileName = "D:/input.txt",
  OutputFileName = "D:/output.txt",

  openread(input, InputFileName), 
  write("input file opened"), nl,
  openwrite(output, OutputFileName), !,
  write("output file opened"), nl,
  
  readdevice(input),
  writedevice(output),
  
  file_str_to_list(input, [], List),
    
 /* Z = longest_string(), write(Z),
  longest_string(),
  */
  closefile(input),
  closefile(output).
