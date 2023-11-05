:- consult('model.pl').
:- consult('view.pl').
:- use_module(library(lists)).
:- use_module(library(aggregate)).
:- use_module(library(random)).
:- dynamic won/1.
:- dynamic game_state/1.


% Controller - game logic and user interaction

% Process when the game is at the Menu State
process_game_state(menu) :-
    draw_menu, 
    read(Input),
    (
        (Input == 1 -> change_game_state(pVp));
        (Input == 2 -> change_game_state(pVc));
        (Input == 3 -> change_game_state(cVc));
        (Input == 4 -> change_game_state(rules));
        write('INVALID CHOICE!'), nl
    ).

% Possible Game States are menu, rules, pVp, pVc, cVc

% Process when the game is at the rules State
process_game_state(rules) :-
    draw_game_rules,
    change_game_state(menu)
    .

% Process when the game is at the Player vs Player State
process_game_state(pVp) :-
    writeln('++++++++++++++++++++++++'),
    writeln('  _____   _____ '),
    writeln(' | _ \\ \\ / / _ \\'),
    writeln(' |  _/\\ V /|  _/'),
    writeln(' |_|   \\_/ |_|  '),
    writeln('++++++++++++++++++++++++'),

    repeat,
        (check_winning -> 
            current_player(Player),
            format('~w Player Won this math.', [Player]),
            initialize_game, !, fail
        ; 
            true
        ),
        read_player_input(Type, FromPosition, ToPosition),
        (
            (Type = move -> move_piece(FromPosition, ToPosition), switch_player, fail);
            (Type = place -> place_piece(ToPosition), switch_player, fail)
        ).


% Process when the game is at the Player vs Computer State
process_game_state(pVc) :-
    writeln('  _____   _____ '),
    writeln(' | _ \\ \\ / / __|'),
    writeln(' |  _/\\ V / (__ '),
    writeln(' |_|   \\_/ \\___|')
    .





% Process when the game is at the Computer vs Computer State
process_game_state(cVc) :-
    writeln('  _____   _____ '),
    writeln(' / __\\ \\ / / __|'),
    writeln('| (__ \\ V / (__ '),
    writeln(' \\___| \\_/ \\___|'),
    
    repeat,
        (check_winning -> 
            current_player(Player),
            format('~w Player Won this math.', [Player]),
            initialize_game, !, fail
        ; 
            true
        ),
        computer_play, 
        switch_player,
        fail
    .



change_game_state(State) :-
    retractall(game_state(_)),
    assertz(game_state(State))
    .


computer_play :-
    current_player(Player),
    format('It is ~w\'s turn.', [Player]), nl,
    get_maneuver(_, _),
    display_board,
    write('Waiting for any key to continue: '),
    read(Key).


read_player_input(Type, FromPosition, ToPosition) :-
    current_player(Player),
    display_board,
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
            (check_winning_helper(Piece) -> retractall(won(_)), assertz(won(Player)); true)
        )
    ),
    won(Player_that_won),
    Player_that_won = Player,
    retractall(won(_)), assertz(won(blank))
    .

% If one of the conditions fail then its false
check_winning_helper(Piece) :- 
    dfs_start(Piece, Right, Left, Bottom), !,
    Right = 1, !,
    Left = 1, !,
    Bottom = 1, !.
    

dfs_start(Start, Right, Left, Bottom) :-
    dfs([Start], [], Right, Left, Bottom).

%% dfs(ToVisit, Visited)
%% Done, all visited
dfs([],_,0,0,0).

%% Skip elements that are already visited
dfs([H|T], Visited, Right, Left, Bottom) :-
    member(H,Visited),
    dfs(T, Visited, Right, Left, Bottom).

%% Add all neigbors of the head to the toVisit
dfs([H|T], Visited, RightIn, LeftIn, BottomIn) :-
    not(member(H, Visited)),
    board(Board),
    current_player(Player),
    member(node(H, _, _, _, IsLeft, IsRight, IsBottom, _), Board),
    get_adjacents_of_color(H, Player, AdjacentsSameColor),
    append(AdjacentsSameColor, T, ToVisit),
    dfs(ToVisit, [H|Visited], R1, L1, B1),
    verify_position(IsRight, R1, RightIn),
    verify_position(IsLeft, L1, LeftIn),
    verify_position(IsBottom, B1, BottomIn).

% verify_position(IsPosition, DfsPosition Right) 
verify_position(1, 0, 1).
verify_position(0, 1, 1).
verify_position(1, 1, 1).
verify_position(0, 0, 0).


get_adjacents_of_color(Position, Color, AdjacentsOfColor) :-
    board(Board),
    % Get the adjacents to that piece
    member(node(Position, _, _, _, _, _, _, Adjacents), Board),
    % Filter the adjacents to only get those of the same color
    get_adjacents_of_color_helper(Adjacents, Color, AdjacentsOfColor)
    .


get_adjacents_of_color_helper(Adjacents, WantedColor,AdjacentsOfColor):-
    board(Board),
    findall(
        Position,
        (
            member(Position,Adjacents),
            member(node(Position, Color, _, _, _, _, _,_),Board),
            Color = WantedColor

        ),
        AdjacentsOfColor
    ).

get_pieces_same_color_on_sides(WantedColor, SameColorList) :-
    board(Board),
    findall(
        Position,
        (
            (
                (member(node(Position, Color, _, _, 1, 0, 1, _), Board));
                (member(node(Position, Color, _, _, 0, 1, 1, _), Board));
                (member(node(Position, Color, _, _, 1, 1, 0, _), Board));
                (member(node(Position, Color, _, _, 0, 1, 0, _), Board));
                (member(node(Position, Color, _, _, 0, 0, 1, _), Board));
                (member(node(Position, Color, _, _, 1, _, _, _), Board))
            ),
            Color = WantedColor
        ),
        SameColorList
    ).

writeln(Content) :-
    write(Content),
    nl.

not(Content) :-
    \+Content.