:- dynamic current_player/1.

current_player(player1).

switch_player :-
    current_player(Current),
    retract(current_player(Current)),
    (Current = player1 -> Next = player2 ; Next = player1),
    assertz(current_player(Next)).

