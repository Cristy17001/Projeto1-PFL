:- dynamic node/6.
:- dynamic state/1.
:- consult('controller.pl').

play :-
    initialize_game,
    place_piece(1), place_piece(3), place_piece(6), place_piece(10), place_piece(15), place_piece(21), place_piece(28),
    game_loop.

game_loop :-
    repeat,
        game_state(State),
        (State = exit -> !, fail; true),
        process_game_state(State), fail.