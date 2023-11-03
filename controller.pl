:- consult('model.pl').
:- consult('view.pl').
:- use_module(library(lists)).

% Controller - game logic and user interaction
play :-
    initialize_game,
    game_loop.

game_loop :-
    repeat,
        display_board,
        read_player_input(Type, FromPosition, ToPosition),
        (
            (Type = move -> move_piece(FromPosition, ToPosition), switch_player, fail);
            (Type = place -> place_piece(ToPosition), switch_player, fail);
            (Type = stop -> !)
        ),  
        write('Invalid movement or placement!'), nl, fail.

read_player_input(Type, FromPosition, ToPosition) :-
    current_player(Player),
    format('It is ~w\'s turn. Enter move or place (e.g. move. OR place.): ', [Player]),
    read(Type),
    (
        (Type = move -> write('From position: '), read(FromPosition), write('To position: '), read(ToPosition));
        (Type = place -> write('In position: '), read(ToPosition));
        write('Invalid type of movement!'), nl
    ).

% Iterate over each piece of the current player, that has either IsLeft, IsRight, IsBottom true
% Execute a dfs that return true if all of those flags were found
check_winning :-
    current_player(Player),
    get_pieces_same_color_on_sides(Player, SameColorList),
    % For each piece that has not been visited and is from one of the sides
    (SameColorList = [] -> false; true),
    foreach(
        member(Piece, SameColorList),
        (
            (check_winning_helper(Piece) -> !)
        )
    ).

check_winning_helper(Piece) :- 
    dfs_start(Piece, Right, Left, Bottom, FinalVisited), !,
    Right = 1, !,
    Left = 1, !,
    Bottom = 1, !.
    

dfs_start(Start, Right, Left, Bottom, FinalVisited) :-
    dfs([Start], [], Right, Left, Bottom, FinalVisited).

%% dfs(ToVisit, Visited)
%% Done, all visited
dfs([],_,_,_,_,_).

%% Skip elements that are already visited
dfs([H|T], Visited, Right, Left, Bottom, FinalVisited) :-
    member(H,Visited),
    dfs(T, Visited, Right, Left, Bottom, FinalVisited).

%% Add all neigbors of the head to the toVisit
dfs([H|T], Visited, Right, Left, Bottom, FinalVisited) :-
    % Verify not visited
    not(member(H, Visited)),
    board(Board),
    member(node(H, _, _, _, IsLeft, IsRight, IsBottom, _), Board),
    get_adjacents_same_color(H, AdjacentsSameColor),
    append(AdjacentsSameColor, T, ToVisit),
    dfs(ToVisit,[H|Visited], Right, Left, Bottom, FinalVisited),
    (append([H], Visited, FinalVisited); true),
    (IsRight = 1 -> Right = 1 ; Right = 0; true),
    (IsBottom = 1 -> Bottom = 1 ; Bottom = 0; true),
    (IsLeft = 1 -> Left = 1 ; Left = 0; true).


get_adjacents_same_color(Position, AdjacentsSameColor) :-
    board(Board),
    current_player(Player),
    % Get the adjacents to that piece
    member(node(Position, _, _, _, _, _, _, Adjacents), Board),
    % Filter the adjacents to only get those of the same color
    get_adjacents_same_color_helper(Adjacents, Player, AdjacentsSameColor)
    .


get_adjacents_same_color_helper(Adjacents, WantedColor,AdjacentsSameColor):-
    board(Board),
    findall(
        Position,
        (
            member(Position,Adjacents),
            member(node(Position, Color, _, _, _, _, _,_),Board),
            Color = WantedColor

        ),
        AdjacentsSameColor
    ).

get_pieces_same_color_on_sides(WantedColor, SameColorList) :-
    board(Board),
    findall(
        Position,
        (
            (
                (member(node(Position, Color, _, _, _, _, 1, _), Board));
                (member(node(Position, Color, _, _, _, 1, _, _), Board));
                (member(node(Position, Color, _, _, 1, _, _, _), Board))
            ),
            Color = WantedColor
        ),
        Auxiliary
    ),
    list_to_set(Auxiliary, SameColorList).