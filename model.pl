:- dynamic board/1.
:- dynamic current_player/1.
:- dynamic node/8.

%Data structure used:
%node(Position, Color, StackSize, Visited, IsLeft, IsRight, IsBottom, Adjacents).

%Initialize the game state
initialize_game :-
    retractall(board(_)),
    assertz(board([
                node(1, blank, 0, 0, 1, 1, 0, [2, 3]),
                node(2, blank, 0, 0, 1, 0, 0, [1, 3, 4, 5]),
                node(3, blank, 0, 0, 0, 1, 0, [1, 2, 5, 6]),
                node(4, blank, 0, 0, 1, 0, 0, [2, 5, 8, 7]),
                node(5, blank, 0, 0, 0, 0, 0, [2, 3, 4, 6, 8, 9]),
                node(6, blank, 0, 0, 0, 1, 0, [3, 5, 9, 10]),
                node(7, blank, 0, 0, 1, 0, 0, [4, 8, 9, 11]),
                node(8, blank, 0, 0, 0, 0, 0, [4, 5, 7, 9, 12, 13]),
                node(9, blank, 0, 0, 0, 0, 0, [5, 6, 8, 10, 13, 14]),
                node(10, blank, 0, 0, 0, 1, 0, [6, 9, 14, 15]),
                node(11, blank, 0, 0, 1, 0, 0, [7, 12, 16, 17]),
                node(12, blank, 0, 0, 0, 0, 0, [7, 8, 11, 13, 17, 18]),
                node(13, blank, 0, 0, 0, 0, 0, [8, 9, 12, 14, 18, 19]),
                node(14, blank, 0, 0, 0, 0, 0, [9, 10, 13, 15, 19, 20]),
                node(15, blank, 0, 0, 0, 1, 0, [10, 14, 20, 21]),
                node(16, blank, 0, 0, 1, 0, 0, [11, 17, 22, 23]),
                node(17, blank, 0, 0, 0, 0, 0, [11, 12, 16, 18, 23, 24]),
                node(18, blank, 0, 0, 0, 0, 0, [12, 13, 17, 19, 24, 25]),
                node(19, blank, 0, 0, 0, 0, 0, [13, 14, 18, 20, 25, 26]),
                node(20, blank, 0, 0, 0, 0, 0, [14, 15, 19, 21, 26, 27]),
                node(21, blank, 0, 0, 0, 1, 0, [15, 20, 27, 28]),
                node(22, blank, 0, 0, 1, 0, 0, [16, 23, 29, 30]),
                node(23, blank, 0, 0, 0, 0, 0, [16, 17, 22, 24, 30, 31]),
                node(24, blank, 0, 0, 0, 0, 0, [17, 18, 23, 25, 31, 32]),
                node(25, blank, 0, 0, 0, 0, 0, [18, 19, 24, 26, 32, 33]),
                node(26, blank, 0, 0, 0, 0, 0, [19, 20, 25, 27, 33, 34]),
                node(27, blank, 0, 0, 0, 0, 0, [20, 21, 26, 28, 34, 35]),
                node(28, blank, 0, 0, 0, 1, 0, [21, 27, 35, 36]),
                node(29, blank, 0, 0, 1, 0, 1, [22, 30]),
                node(30, blank, 0, 0, 0, 0, 1, [22, 23, 29, 31]),
                node(31, blank, 0, 0, 0, 0, 1, [23, 24, 30, 32]),
                node(32, blank, 0, 0, 0, 0, 1, [24, 25, 31, 33]),
                node(33, blank, 0, 0, 0, 0, 1, [25, 26, 32, 34]),
                node(34, blank, 0, 0, 0, 0, 1, [26, 27, 33, 35]),
                node(35, blank, 0, 0, 0, 0, 1, [27, 28, 34, 36]),
                node(36, blank, 0, 0, 0, 1, 1, [28, 35])
            ])),
                                
    
    %Current player can be yellow(Y) or blue(B) or blank when empty
    assertz(current_player(yellow)).


%Predicate to switch player
switch_player :-
    retract(current_player(Current)),
    (Current = yellow -> Next = blue ; Next = yellow),
    assertz(current_player(Next)).

%Predicate to check adjacency
check_adjacency(FromPosition, ToPosition) :-
    board(Board),
    member(Element, Board), Element = node(FromPosition,_,_,_,_,_,_,Adjacents),
    member(Adjacent, Adjacents), Adjacent = ToPosition.

%Predicate to check stackSize and color
check_stack(FromPosition, ToPosition) :-
    board(Board),
    member(node(FromPosition, FromColor, FromStackSize, _, _, _, _, _), Board),
    member(node(ToPosition, ToColor, ToStackSize, _, _, _, _, _), Board),
    FromStackSize = ToStackSize, 
    FromColor \= ToColor.

%Predicate to check if a place is valid
valid_place(Position) :-
    board(Board),
    member(Element, Board), Element = node(Position, blank, 0,_,_,_,_,_).


%Predicate to check if a move is valid
%For a move to be valid the stacks must have the same size, must be adjacent and the top color of the stack must be off a different color
valid_move(FromPosition, ToPosition) :-
    check_adjacency(FromPosition, ToPosition),
    check_stack(FromPosition, ToPosition)
    .

% Predicate to make a move
move_piece(FromPosition, ToPosition) :-
    (valid_move(FromPosition, ToPosition),
     decrease_stack_size(FromPosition),
     increase_stack_size(ToPosition)
    );
    write("Invalid piece movement/capture! Stacks must be adjacent, have different colors and same size!"), nl, fail
    .


% Predicate to make a placement of a piece in a blankspace
place_piece(Position) :-
    (valid_place(Position),
    current_player(Player),
    modify_node_color(Position, Player));
    write("Invalid piece placement! To place a piece the space must be empty!"), nl, fail
    .


% Utility predicate to the color
modify_node_color(Position, NewColor) :-
    board(Board),
    member(node(Position, _, StackSize, _, _, _, _, _), Board),
    NewStackSize is StackSize + 1,
    select(node(Position, _, StackSize, Visited, IsLeft, IsRight, IsBottom, Adjacents), Board, node(Position, NewColor, NewStackSize, Visited, IsLeft, IsRight, IsBottom, Adjacents), NewBoard),  % Select the node with the specified position and update its color
    retract(board(_)),  % Remove the current board from the database
    assertz(board(NewBoard)) % Assert the updated board back into the database
    .

% Utility predicate to decrease stack by one
decrease_stack_size(Position) :-
    board(Board),
    member(node(Position, Color, StackSize, _, _, _, _, _), Board),
    StackSize > 0,
    NewStackSize is StackSize - 1,
    %current_player(Current),
    (Color = yellow -> NewColor = blue; NewColor = yellow),
    (newStackSize = 0 -> Color = blank),
    select(node(Position, _, StackSize, Visited, IsLeft, IsRight, IsBottom, Adjacents), Board, node(Position, NewColor, NewStackSize, Visited, IsLeft, IsRight, IsBottom, Adjacents), NewBoard),  % Select the node with the specified position and update its color
    retract(board(_)),  % Remove the current board from the database
    assertz(board(NewBoard)) % Assert the updated board back into the database
    .

% Utility predicate to increase stack by one
increase_stack_size(Position) :-
    board(Board),
    member(node(Position, Color, StackSize, _, _, _, _, _), Board),
    StackSize > 0,
    NewStackSize is StackSize + 1,
    (Color = yellow -> NewColor = blue; NewColor = yellow),
    select(node(Position, _, StackSize, Visited, IsLeft, IsRight, IsBottom, Adjacents), Board, node(Position, NewColor, NewStackSize, Visited, IsLeft, IsRight, IsBottom, Adjacents), NewBoard),  % Select the node with the specified position and update its color
    retract(board(_)),  % Remove the current board from the database
    assertz(board(NewBoard)) % Assert the updated board back into the database
    .