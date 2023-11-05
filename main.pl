:- dynamic node/6.
:- dynamic state/1.
:- consult('controller.pl').

play :-
    initialize_game,
    game_loop.

game_loop :-
    repeat,
        game_state(State),
        (State = exit -> !, fail; true),
        process_game_state(State), fail.