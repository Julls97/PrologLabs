/*****************************************************************************

		Copyright (c) My Company

 Project:  DFS
 FileName: DFS.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "dfs.inc"

domains
	edge= e(symbol, symbol)
	list = edge*

predicates
%	edge(symbol, symbol)
	dfs(symbol, symbol, list, list)
	member(list, list)

clauses
	edge(a, b).
	edge(a, c).
	edge(a, g).
	edge(b, a).
	edge(b, c).
	edge(c, e).
	edge(c, d).
	edge(d, f).
	edge(e, g).
	edge(e, f).
	edge(e, h).
	edge(f, k).
	edge(g, c).
	edge(g, e).
	edge(m, d).
	edge(p, b).
	edge(p, d).
	
	dfs(From, To, _, [e(From, To)]):- edge(From, To).
	dfs(From, To, VisitedNodes, [edge(From, X)|TailPath]):- edge(From, X), not(member(X, VisitedNodes)), dfs(X, To, [From|VisitedNodes], TailPath).
	
	member(A,[A|_]):-!.
	member(A,[_|T]):-member(A,T).
goal
	dfs(e, d, [], Path).
