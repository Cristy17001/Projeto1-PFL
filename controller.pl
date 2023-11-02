:- consult('model.pl').

% Controller - game logic and user interaction
play :-
    initialize_game,
    game_loop.

game_loop :-
    repeat,
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

%check_winner(Player) :-
%    board(Board),

%announce_winner(Player) :-
%    format('Player ~w wins!', [Player]).
