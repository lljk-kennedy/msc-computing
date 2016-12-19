% Course:			Programming Paradigms - DT228B1
% 					Assignment 2 - Blocks
% Due Date: 		1st December 2016
%
% Student: 			Iain Breen
% Student Number:	D07112248

% **************************   CA Question 1    *****************************
%
% Problem: 			Print the status of the blocks. You are required to 
%					define a PROLOG predicate print_status to print the status 
%					of the blocks. print_status(B) where B is a list of three 
%					lists describing the three piles of blocks.
%
% Example:			print_status([[b,c,f],[a,d,g],[h,e]]).
%					|b|c|f|
%					|a|d|g|
%					|h|e|
% 
% Solution:			Print the status by printing out each stack. Pull the Head
%					stack, print it's details, then call print_status on the
%					tail again.

print_status([]).
print_status([Head|Tail]) :- print_stack(Head), print_status(Tail).

print_stack([]) :- writeln('|').
print_stack(([Head|Tail])) :- write('|'), write(Head), print_stack(Tail). 

% ***************************************************************************

% **************************   CA Question 2    *****************************
%
% Problem: 			Predicate high(B,X,H). You are required to produce a 
%					predicate high(X,H) where B describes the three piles of 
%					blocks, X is a block and H is the height of the block from 
%					the ground. A block directly on the ground has height 
%					equal to zero. The predicate can also be used to find 
%					all the blocks at a certain high.
%
% Example:			?- high([[b,c,f],[a,d,g],[h,e]],c,H) 
%					H=1
%					?- high([[b,c,f],[a,d,g],[h,e]],g,H) 
%					H=2
%
%					?- high([[b,c,f],[a,d,g],[h,e]],X,2) 
%					X=f;
%					X=g.
% 
% Solution:			create a predicate to search through a list of lists, 
%					checking the head for the nth0 element and returning
%					both the index and the element at that index.

%getIndexAndElem(RetrievedIndex, IndexToFind, RetrievedElem, ElemToFind, List)
% get the index and element from the head 
getIndexAndElem(RetrievedIndex, RetrievedIndex, ElemToFind, ElemToFind, [Head|_]) :-
	nth0(RetrievedIndex, Head, ElemToFind).

% if there is a list of lists, get the index and element from each list contained.
getIndexAndElem(RetrievedIndex, RetrievedIndex, ElemToFind, ElemToFind, [_|Tail]) :-
	getIndexAndElem(RetrievedIndex, RetrievedIndex, ElemToFind, ElemToFind, Tail).

% if the list is empty, return -1.
high([], _, -1).

% step through each stack of blocks
high(Stacks, Block, Height) :- 
	getIndexAndElem(Height, Height, Block, Block, Stacks).

% ***************************************************************************

% **************************   CA Question 3    *****************************
%
% Problem: 			Block at a specific height. Write a PROLOG predicate that 
%					returns a list of all the blocks at a specific heights 
%					(from all the 3 stacks). The predicate is called 
%					all_same_height(B,H,L) where B again is the list of piles, 
%					H is the height (integer positive number) and L is the 
%					list of blocks that are at an height of H.
%
% Example:			?- all_same_height([[b,c,f],[a,d,g],[h,e]],0,L). 
%					L = [b,a,h]
%					?- all_same_height([[b,c,f],[a,d,g],[h,e]],2,L). 
%					L = [f,g]
% 
% Solution:			Looks like findall...

% run findall over High
all_same_height(Stacks, Height, ListOfBlocks) :-
	findall(Block, high(Stacks, Block, Height), ListOfBlocks).


% ***************************************************************************

% **************************   CA Question 4    *****************************
%
% Problem: 			Predicate same height. Write a PROLOG predicate 
%					same_height(B,X,Y) that is true if block X and block Y 
%					have the same height (B is the usual description of 
%					the threepiles).
%
% Example:			?- same_height([[b,c,f],[a,d,g],[h,e]], a, h).
%					true
% 					?- same_height([[b,c,f],[a,d,g],[h,e]], a, e).
%					false
% 
% Solution:			Get the Height of Block A, then BlockB, and return true
%					if they equal

% Check if the result of High is equal for both blocks.
same_height(Stacks, BlockA, BlockB) :-
	high(Stacks, BlockA, HeightA),
	high(Stacks, BlockB, HeightB),
	HeightA = HeightB.

% ***************************************************************************

% **************************   CA Question 5    *****************************
%
% Problem: 			Move blocks. Write a PROLOG predicate moveblock(B,X,S1,S2) 
%					to move a block from the stack S1 to the stack S2. S1 and 
%					S2 are integer numbers identifying one of the three stacks 
%					(1,2 or 3). A block can be moved only if it is at the top 
%					of a stack (otherwise it cannot be moved) and it can be 
%					only placed on top of another stack (or on the ground if 
%					the stack is empty). The predicate has to print the status 
%					of the blocks before and after the move (only if the 
%					block can be moved!).
%
% Example:			?- moveblock([[b,c,f],[a,d,g],[h,e]],g,2,1)
%					Before:
%					|b|c|f|
% 					|a|d|g|
% 					|h|e|
% 					After:
% 					|b|c|f|g|
% 					|a|d|
% 					|h|e|
% 
% Solution:			First, check if the Block is at the top of the OriginStack.

% Check if a Block is at the top of the stack by getting the block index, the length of the
% list, and checking for equivalency.
isTopOfStack(Stack, Block) :-
	nth1(BlockHeight, Stack, Block),
	length(Stack, StackLength),
	BlockHeight = StackLength.

% add an element to the end of a list
addToEndOfList(List, Elem, NewList) :-
	append(List, [Elem], NewList).

% replace an element at N index. If 0, replace the head
replace([_|Tail], 0, Elem, [Elem|Tail]).

% If n!=0, remove the head and check replace again passing in the tail until we find a match,
% then return the list with the element replaced.
replace([Head|Tail], I, Elem, [Head|Rest]):- 
	I > 0, 
	I1 is I-1, 
	replace(Tail, I1, Elem, Rest).

% predicate to move blocks between the stacks. First, delete the block from the original stack,
% and append it to the end of the destination stack. Next, replace the DestStack and OriginStack
% in the original list at their original index, creating a new list of stacks called MovedStacks to return.
moveBetweenStacks(OriginalStacks, MovedStacks, Block, OriginStack, DestStack, OriginStackIndex, DestStackIndex) :-
	delete(OriginStack, Block, NewOriginStack),
	addToEndOfList(DestStack, Block, NewDestStack),
	OriginStackIndexDec is OriginStackIndex - 1,
	DestStackIndexDec is DestStackIndex -1, 
	replace(OriginalStacks, OriginStackIndexDec, NewOriginStack, NewOriginStackA),
	replace(NewOriginStackA, DestStackIndexDec, NewDestStack, MovedStacks).
	
% output the original status, get the original stack from the list and execute the check to see if
% the block is at the top; if so, get the dest stack from the list and move the block between. 
% Output the result at the end.
moveblock(Stacks, Block, OriginStackIndex, DestStackIndex, NewStacks) :-
	write("Before:"), nl(),
	print_status(Stacks),
	nth1(OriginStackIndex, Stacks, OriginStack),
	isTopOfStack(OriginStack, Block), 
	nth1(DestStackIndex, Stacks, DestStack),
	moveBetweenStacks(Stacks, NewStacks, Block, OriginStack, DestStack, OriginStackIndex, DestStackIndex),
	write("After:"), nl(),
	print_status(NewStacks).

% ***************************************************************************

% **************************   CA Question 6    *****************************
%
% Problem: 			Write a predicate order_blocks(S,S_order) that takes as an 
%					input the three stacks of blocks (variable S) and put them 
%					in order (A on the ground, B over A and so on...) in any 
%					of the three stacks (output variable S_order). There are 
%					only three stacks available (blocks can only be moved in 
%					one of the three stacks). Each time the block is moved 
%					the program print the status of the blocks.
%
% Example:			order_blocks([[b,c,f],[a,d,g],[h,e]], SortedStacks).
% 
% Solution:			Similar to the Tower of Hanoi problem??? Ran out of time :(

moveTopBlock(Stacks, Block, OriginStackIndex, DestStackIndex, NewStacks) :-
	write("Before:"), nl(),
	print_status(Stacks),
	nth1(OriginStackIndex, Stacks, OriginStack),
	isTopOfStack(OriginStack, Block), 
	nth1(DestStackIndex, Stacks, DestStack),
	moveBetweenStacks(Stacks, NewStacks, Block, OriginStack, DestStack, OriginStackIndex, DestStackIndex),
	write("After:"), nl(),
	print_status(NewStacks).

getTopBlock(Stack, TopBlock) :-
	length(Stack, StackLength),
	nth1(StackLength, Stack, TopBlock).
	%% write("Top Block: "), write(TopBlock), nl().



moveStack([HeadStack|RestOfStack], MovedStacks, SourceStackIndex, DestStackIndex) :-
	getTopBlock(HeadStack, TopBlock),
	moveTopBlock(OriginStacks, TopBlock, SourceStackIndex, DestStackIndex, MovedStacks), 
	moveStack(RestOfStacks, MovedStacks, SourceStackIndex, DestStackIndex).

	
moveBlocksToRightStack([FirstStack|RestOfStacks], MovedStacks, CurrentStackIndex,DestStackIndex) :-
	moveStack([FirstStack|RestOfStacks], MovedStacks, CurrentStack, DestStackIndex),
	print_status(Stacks),
	moveBlocksToRightStack([RestOfStacks], MovedStacks, CurrentStack).


order_blocks(Stacks, SortedStacks) :-
	write("Original Order:"), nl(),
	print_status(Stacks),
	% recursively move all blocks to the right stack
	moveBlocksToRightStack(Stacks, MovedToRightStacks, 1, 3).








% ***************************************************************************