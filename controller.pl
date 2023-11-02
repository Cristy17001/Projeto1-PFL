:- consult('model.pl').
:- consult('view.pl').

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

check_winner :-
    current_player(Player),
    board(Board).
    % Iterate over each piece of the current player, that has either IsLeft, IsRight, IsBottom true
    % Execute a dfs that return true if all of those flags were found
    % Reset the loop by reseting the isVisited




dfs(Current, VisitedList, IsRight, IsLeft, IsBottom) :-
    board(Board),
    % Add the current to the visited list(RESULT LIST)
    append_element(VisitedList, [Current], ResultList),

    % Get all the Current adjacents of the same color
    get_adjacents_same_color(Current, Adjacents),

    (Right = true -> IsRight = true ; true),
    (Bottom = true -> IsBottom = true ; true),
    (Left = true -> IsLeft = true ; true)
    .


% append_element(+Element, +List, -ResultList)
append_element(Element, List, ResultList) :-
    append(List, [Element], ResultList).


get_adjacents_same_color(Position, AdjacentsSameColor) :-
    board(Board),
    current_player(Player),
    % Get the adjacents to that piece
    member(node(Position, _, _, _, _, _, _, Adjacents), Board),
    % Filter the adjacents to only get those of the same color
    get_adjacents_same_color_helper(Adjacents, Player, AdjacentsSameColor).

get_adjacents_same_color_helper([],_, []).
get_adjacents_same_color_helper([node(PositionAdjacent, Color, _, _, _, _, _, _) | Rest], WantedColor, [Position | RestAdjacents]) :-
    get_adjacents_same_color_helper(Rest, WantedColor, RestAdjacents),
    Color = WantedColor -> Position = PositionAdjacent; true
    .


% Example usage:
% dfs(1, [], ResultList).


%announce_winner(Player) :-
%    format('Player ~w wins!', [Player]).
