/*---------------------LIBRARY-----------------------*/
/*                                                   */
/* Graph traversing algorithms to find shortest path */
/* DFS, BFS, Djikstra, Bellman-Ford                  */
/*                                                   */
/*---------------------------------------------------*/

/*----------------------GRAPH------------------------*/

/*NON-WEIGHTED NON-DIRECTIONAL ACYCLIC*/

connects(1,4). 
connects(4,1).
connects(1,5). 
connects(5,1).
connects(1,2). 
connects(2,1).
connects(2,7). 
connects(7,2).
connects(2,6). 
connects(6,2).
connects(2,3). 
connects(3,2).

next_node(CurrentNode,Visited,NextNode) :-
	connects(CurrentNode,NextNode),
	not(member(NextNode,Visited)).

adj(N,Res) :- findall(X,connects(N,X),Res).
adj([N|Ns],Res) :- adj(N,PRes), adj(Ns,RRes), append([PRes],RRes,Res).

/*----------------------DFS--------------------------*/
/* Given:                                            */
/*	starting node, target node                   */
/* Returns:                                          */
/* 	all paths from the starting to the target    */
/* 	node                                         */
/*---------------------------------------------------*/

dfs(Start,Target,Path) :- dfs(Start,Target,[Start],Path).

dfs(Target,Target,_,[Target]).
dfs(Start,Target,Visited,[Start|RestPath]) :-
	next_node(Start,Visited,Next),
	dfs(Next,Target,[Next|Visited],RestPath).

/*----------------------BFS--------------------------*/

bfs(Start,Target,Path) :- bfs(Start,Target,[Start],Path).

bfs(Target,Target,_,[Target]). 
bfs(Start,Target,Visited,[Start|RestPath]) :-
	adj(Start,[F|Res]),
	not(member(F,Visited)),
	bfs(F,Target,[F|Visited],RestPath).
























































