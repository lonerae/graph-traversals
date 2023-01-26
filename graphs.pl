/*---------------------LIBRARY-----------------------*/
/*                                                   */
/* Graph traversing algorithms to find shortest path */
/* DFS, BFS, Djikstra, Bellman-Ford                  */
/*                                                   */
/*---------------------------------------------------*/

/*----------------------GRAPH------------------------*/

/*NON-WEIGHTED NON-DIRECTIONAL ACYCLIC*/

connects(1,2).
connects(1,4).
connects(1,5).
connects(2,7).
connects(2,6).
connects(2,3).

edge(X,Y) :- connects(X,Y) ; connects(Y,X).
 
/*----------------------BFS--------------------------*/
/* Given:                                            */
/*	starting node, target node, list with the    */
/* 	starting node as its only element            */
/* Returns:                                          */
/* 	a path from the starting to the target       */
/* 	node                                         */
/*---------------------------------------------------*/

dfs(FinishNode,FinishNode,_,[FinishNode]).
dfs(StartNode,FinishNode,Visited,[StartNode|RestPath]) :-
	edge(StartNode,X),
	not(member(X,Visited)),
	dfs(X,FinishNode,[X|Visited],RestPath).	

/*---------------------------------------------------*/
