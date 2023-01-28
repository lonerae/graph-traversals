/*---------------------LIBRARY-----------------------*/
/*                                                   */
/* Graph traversing algorithms to find shortest path */
/* DFS, BFS, Djikstra, Bellman-Ford                  */
/*                                                   */
/*---------------------------------------------------*/

/*----------------------GRAPH------------------------*/

/*NON-WEIGHTED NON-DIRECTIONAL ACYCLIC*/


connects(4,1).
connects(1,5). 
connects(1,4). 
connects(5,1).
connects(1,2). 
connects(2,7). 
connects(7,2).
connects(2,6). 
connects(6,2).
connects(2,3). 
connects(3,2).
connects(2,1).
connects(4,8).
connects(8,4).
connects(8,9).
connects(9,8).

/*----------------------COMMON FUNCTIONS-------------*/

next_node(CurrentNode,Visited,NextNode) :-
	connects(CurrentNode,NextNode),
	not(member(NextNode,Visited)).

adj([N|Ns],Visited,Res) :- 
	adj(N,Visited,PRes), 
	adj(Ns,Visited,RRes), 
	append(PRes,RRes,Res), !.

adj(N,Visited,Res) :- 
	findall(X,(connects(N,X),not(member(X,Visited))),Res).
/*adj([N|Ns],Visited,Res) :- 
	findall(X,(connects(N,X),not(member(X,Visited))),Res).*/


create_branches(_,[],[]).

create_branches(Branch,[X|Xs],Branches) :- 
	append([X],Branch,PBranch),
	create_branches(Branch,Xs,RBranches),
	append([PBranch],RBranches,Branches),!.

/*check([],_,_) :- false.*/
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

replace(AllBranches,Branches,NewAllBranches) :-
	append(AllBranches,Branches,NewAllBranches).
	
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

bfs(Start,Target,Path) :- bfs([[Start]],Target,[Start],[Start],Path).

bfs([Branch|RestBranches],Target,Visited,AllBranches,Path) :-
	check(Branch,Target,Path);
	branch_eval([Branch|RestBranches],Target,Visited,[Branch|RestBranches],Path).
		
branch_eval([Branch|RestBranches],Target,Visited,AllBranches,Path) :-
	adj(Branch,Visited,Res),
	create_branches(Branch,Res,Branches),
	(
		check(Branches,Target,Path);
		append(Res,Visited,NewVisited),
		append(AllBranches,Branches,NewAllBranches),
		(
			(
				RestBranches \= [],
				branch_eval(RestBranches,Target,NewVisited,NewAllBranches,Path)
			);
			bfs(NewAllBranches,Target,NewVisited,NewAllBranches,Path)
		)
	).
		



















































