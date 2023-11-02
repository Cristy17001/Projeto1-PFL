% Controller - game logic and user interaction
play :-
    initialize_game,
    game_loop.

game_loop :-
    repeat,
        %display_board,
        current_player(Player),
        format('It is ~w\'s turn. Enter move or place (e.g. move. OR place.): ', [Player]),
        read_player_input(Type, FromPosition, ToPosition),
        (
            Type = move -> move_piece(FromPosition, ToPosition), switch_player, !;
            Type = place -> place_piece(ToPosition), switch_player, !;
            Type = stop -> !, fail; % Stop the loop
            write('Invalid movement or placement!')
        ).

read_player_input(Type, FromPosition, ToPosition) :-
    read(Type),
    (
        (Type = move -> write('From position: '), read(FromPosition), write('To position: '), read(ToPosition));
        (Type = place -> write('In position: '), read(ToPosition));
        write('Invalid type of movement!')
    ).

    

%check_winner(Player) :-
%    board(Board),

%announce_winner(Player) :-
%    format('Player ~w wins!', [Player]).
