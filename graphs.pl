/*---------------------LIBRARY-----------------------*/
/*                                                   */
/* Graph traversing algorithms to find shortest path */
/* DFS, BFS, Djikstra, Bellman-Ford                  */
/*                                                   */
/*---------------------------------------------------*/

/*----------------------GRAPH------------------------*/

/*NON-WEIGHTED NON-DIRECTIONAL ACYCLIC*/

connects(1,2).
connects(2,1).

connects(1,4).
connects(4,1).

connects(1,5).
connects(5,1).

connects(2,3).
connects(3,2).

connects(2,6).
connects(6,2).

connects(2,7).
connects(7,2).

connects(4,8).
connects(8,4).

/*NON-WEIGHTED NON-DIRECTIONAL*/

/*connects(1,2).
connects(2,1).

connects(1,4).
connects(4,1).

connects(2,3).
connects(3,2).

connects(2,5).
connects(5,2).

connects(2,7).
connects(7,2).

connects(2,8).
connects(8,2).

connects(3,4).
connects(4,3).

connects(3,9).
connects(9,3).

connects(3,10).
connects(10,3).

connects(5,6).
connects(6,5).

connects(5,7).
connects(7,5).

connects(5,8).
connects(8,5).

connects(7,8).
connects(8,7).*/

/*----------------------COMMON FUNCTIONS-------------*/

next_node(CurrentNode,Visited,NextNode) :-
	connects(CurrentNode,NextNode),
	not(member(NextNode,Visited)).

/*---------------------------------------------------*/

adj([],_,[]).
adj([N|Ns],Visited,Res) :- 
	adj(N,Visited,PRes), 
	adj(Ns,Visited,RRes), 
	append(PRes,RRes,Res), !.
adj(N,Visited,Res) :- 
	findall(X,(connects(N,X),not(member(X,Visited))),Res).

create_branches(_,[],[]).
create_branches(Branch,[X|Xs],Branches) :- 
	append(Branch,[X],PBranch),
	create_branches(Branch,Xs,RBranches),
	append([PBranch],RBranches,Branches),!.

check([Branch|RBranches],Target,Path) :-
	(
		is_list(Branch),
		(	
			(member(Target,Branch),
			append([],[Branch],Path));
			check(RBranches,Target,Path)
		)
	);
	(	
		member(Target,[Branch|RBranches]),
		append([],[Branch|RBranches],Path)
	).

pop([_|Result],Result).	
	
/*----------------------DFS--------------------------*/
/* Given:                                            */
/*	starting node, target node                   */
/* Returns:                                          */
/* 	the first found path from the starting to    */
/*	the target node 			     */
/*---------------------------------------------------*/

dfs(Start,Target,Path) :- dfs(Start,Target,[Start],Path).

dfs(Target,Target,_,[Target]).

dfs(Start,Target,Visited,[Start|RestPath]) :-
	next_node(Start,Visited,Next),
	dfs(Next,Target,[Next|Visited],RestPath),!.

/*----------------------BFS--------------------------*/
/* Given:                                            */
/*	starting node, target node                   */
/* Returns:                                          */
/* 	the shortest path from the starting to       */
/*	the target node                              */
/*---------------------------------------------------*/


bfs(Start,Target,Path) :- bfs([Start],Target,Start,[Start],Path).


bfs(Start,Target,Visited,Queue,Path) :-
	check(Start,Target,Path),!;
	adj(Start,Visited,Adj),
	create_branches(Start,Adj,Branches),
	append(Queue,Branches,FullQueue),pop(FullQueue,NewQueue),NewQueue=[F|_],
	bfs(F,Target,[Visited|Adj],NewQueue,Path).
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
