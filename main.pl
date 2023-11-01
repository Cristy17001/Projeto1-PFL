:- dynamic node/6.

play :- 
        write(''), nl,
        write('               OOO                  OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO   OOOOOOOOOOOOOOOOOOOOOO'), nl,
        write('              O:::O              OOO::::::::::::OO::::::::::::::::::::OO::::::::::::::::O  O::::::::::::::::::::O'), nl,
        write('             O:::::O           OO:::::::::::::::OO::::::::::::::::::::OO::::::OOOOOO:::::O O::::::::::::::::::::O'), nl,
        write('            O:::::::O         O:::::OOOOOOOO::::OOO::::::OOOOOOOOO::::OOO:::::O     O:::::OOO::::::OOOOOOOOO::::O'), nl,
        write('           O:::::::::O       O:::::O       OOOOOO  O:::::O       OOOOOO  O::::O     O:::::O  O:::::O       OOOOOO'), nl,
        write('          O:::::O:::::O     O:::::O                O:::::O               O::::O     O:::::O  O:::::O             '), nl,
        write('         O:::::O O:::::O    O:::::O                O::::::OOOOOOOOOO     O::::OOOOOO:::::O   O::::::OOOOOOOOOO   '), nl,
        write('        O:::::O   O:::::O   O:::::O    OOOOOOOOOO  O:::::::::::::::O     O:::::::::::::OO    O:::::::::::::::O   '), nl,
        write('       O:::::O     O:::::O  O:::::O    O::::::::O  O:::::::::::::::O     O::::OOOOOO:::::O   O:::::::::::::::O   '), nl,
        write('      O:::::OOOOOOOOO:::::O O:::::O    OOOOO::::O  O::::::OOOOOOOOOO     O::::O     O:::::O  O::::::OOOOOOOOOO   '), nl,
        write('     O:::::::::::::::::::::OO:::::O        O::::O  O:::::O               O::::O     O:::::O  O:::::O             '), nl,
        write('    O:::::OOOOOOOOOOOOO:::::OO:::::O       O::::O  O:::::O       OOOOOO  O::::O     O:::::O  O:::::O       OOOOOO'), nl,
        write('   O:::::O             O:::::OO:::::OOOOOOOO::::OOO::::::OOOOOOOO:::::OOO:::::O     O:::::OOO::::::OOOOOOOO:::::O'), nl,
        write('  O:::::O               O:::::OOO:::::::::::::::OO::::::::::::::::::::OO::::::O     O:::::OO::::::::::::::::::::O'), nl,
        write(' O:::::O                 O:::::O OOO::::::OOO:::OO::::::::::::::::::::OO::::::O     O:::::OO::::::::::::::::::::O'), nl,
        write('OOOOOOO                   OOOOOOO   OOOOOO   OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO     OOOOOOOOOOOOOOOOOOOOOOOOOOOOO'), nl,
        write(''), nl,
        draw_board,
        first_menu
        .


first_menu :- 
                repeat,
                    write(''), nl,
                    write('++++++++++++++++++++++++'), nl,
                    write('  __  __ ___ _  _ _   _ '), nl,
                    write(' |  \\/  | __| \\| | | | |'), nl,
                    write(' | |\\/| | _|| .` | |_| |'), nl,
                    write(' |_|  |_|___|_|\\-|\\___/ '), nl,
                    write('++++++++++++++++++++++++'), nl,
                    write(''), nl,
                    write('1. Play PERSON VS PERSON'), nl,
                    write('2. Play PERSON VS COMPUTER'), nl,
                    write('3. COMPUTER VS COMPUTER'), nl,
                    write('4. SHOW GAME RULES'), nl, nl,
                    write('Select one option: '), 
                    read(Input),
                    (
                        (Input == 1 -> write('Escolheu 1'), nl, !);
                        (Input == 2 -> write('Escolheu 2'), nl, !);
                        (Input == 3 -> write('Escolheu 3'), nl, !);
                        (Input == 4 -> write('Escolheu 4'), draw_game_rules, !);
                        write("INVALID CHOICE!"), nl
                    ).


draw_game_rules :- 
                    write(''), nl,
                    write('++++++++++++++++++++++++'), nl,
                    write('  ___ _   _ _    ___ ___ '), nl,
                    write(' | _ \\ | | | |  | __/ __|'), nl,
                    write(' |   / |_| | |__| _|\\__ \\'), nl,
                    write(' |_|_\\___/|____|___|___/'), nl, nl,
                    write('++++++++++++++++++++++++'), nl, nl,
                    write(''), nl,
                    write('Materials:'), nl,
                    write('- 70 discs in 2 colors;'), nl,
                    write('- Triangular game board.'), nl,
                    write(''), nl,
                    write('Setup:'), nl,
                    write('- One player places a Yellow disc on any space. (In this case letter Y)'), nl,
                    write('- Blue (In this case letter B) goes first.'), nl,
                    write(''), nl,
                    write('Goal:'), nl,
                    write('- You win if, at the start of your turn, a single group of your stacks connects the 3 sides of the board.'), nl,
                    write('- Corner spaces connect to both adjacent sides.'), nl,
                    write('- A stack is yours if your disc is on top. A single disc is a stack.'), nl,
                    write(''), nl,
                    write('Playing the Game:'), nl,
                    write('On your turn, you may choose one of the following actions:'), nl,
                    write('1. Place a Disc:'), nl,
                    write('   - Put a disc of your color on an empty space.'), nl,
                    write('2. Move a Disc:'), nl,
                    write('   - Move a disc of your color from the top of a stack onto a neighboring opponent\'s stack of exactly the same height.'), nl
                .


%play_person_vs_person :- .
%play_person_vs_computer :- .
%play_computer_vs_computer :- .




draw_board :-
            write(''), nl,
            write('                 +----+                  '), nl,
            write('                 | 01 |                  '), nl,
            write('               +----+----+               '), nl,
            write('               | 02 | 03 |               '), nl,
            write('            +----+----+----+             '), nl,
            write('            | 04 | 05 | 06 |             '), nl,
            write('          +----+----+----+----+          '), nl,
            write('          | 07 | 08 | 09 | 10 |          '), nl,
            write('       +----+----+----+----+----+        '), nl,
            write('       | 11 | 12 | 13 | 14 | 15 |        '), nl,
            write('     +----+----+----+----+----+----+     '), nl,
            write('     | 16 | 17 | 18 | 19 | 20 | 21 |     '), nl,
            write('  +----+----+----+----+----+----+----+   '), nl,
            write('  | 22 | 23 | 24 | 25 | 26 | 27 | 28 |   '), nl,
            write('+----+----+----+----+----+----+----+----+'), nl,
            write('| 29 | 30 | 31 | 32 | 33 | 34 | 35 | 36 |'), nl,
            write('+----+----+----+----+----+----+----+----+'), nl,
            write(''), nl
            .


%Nodes are used to represent the places to place pieces
%node(Position, Color, Visited, IsLeft, IsRight, IsBottom).
node(1, blank, 0, 1, 1, 0).
node(2, blank, 0, 1, 0, 0).
node(3, blank, 0, 0, 1, 0).
node(4, blank, 0, 1, 0, 0).
node(5, blank, 0, 0, 0, 0).
node(6, blank, 0, 0, 1, 0).
node(7, blank, 0, 1, 0, 0).
node(8, blank, 0, 0, 0, 0).
node(9, blank, 0, 0, 0, 0).
node(10, blank, 0, 0, 1, 0).
node(11, blank, 0, 1, 0, 0).
node(12, blank, 0, 0, 0, 0).
node(13, blank, 0, 0, 0, 0).
node(14, blank, 0, 0, 0, 0).
node(15, blank, 0, 0, 1, 0).
node(16, blank, 0, 1, 0, 0).
node(17, blank, 0, 0, 0, 0).
node(18, blank, 0, 0, 0, 0).
node(19, blank, 0, 0, 0, 0).
node(20, blank, 0, 0, 0, 0).
node(21, blank, 0, 0, 1, 0).
node(22, blank, 0, 1, 0, 0).
node(23, blank, 0, 0, 0, 0).
node(24, blank, 0, 0, 0, 0).
node(25, blank, 0, 0, 0, 0).
node(26, blank, 0, 0, 0, 0).
node(27, blank, 0, 0, 0, 0).
node(28, blank, 0, 0, 1, 0).
node(29, blank, 0, 1, 0, 1).
node(30, blank, 0, 0, 0, 1).
node(31, blank, 0, 0, 0, 1).
node(32, blank, 0, 0, 0, 1).
node(33, blank, 0, 0, 0, 1).
node(34, blank, 0, 0, 0, 1).
node(35, blank, 0, 0, 0, 1).
node(36, blank, 0, 0, 1, 1).


%edge(Source, Dest).
edge(1, [2,3]).
edge(2, [1,3,4,5]).
edge(3, [1,2,5,6]).
edge(5, [1,3,4,5]).
edge(6, [1,3,4,5]).
edge(7, [1,3,4,5]).
edge(8, [1,3,4,5]).
edge(9, [1,3,4,5]).
edge(10, [1,3,4,5]).
edge(11, [1,3,4,5]).
edge(12, [1,3,4,5]).
edge(13, [1,3,4,5]).
edge(14, [1,3,4,5]).
edge(15, [1,3,4,5]).
edge(16, [1,3,4,5]).
edge(17, [1,3,4,5]).
edge(18, [1,3,4,5]).
edge(19, [1,3,4,5]).
edge(20, [1,3,4,5]).
edge(21, [1,3,4,5]).
edge(22, [1,3,4,5]).
edge(23, [1,3,4,5]).
edge(24, [1,3,4,5]).
edge(25, [1,3,4,5]).
edge(26, [1,3,4,5]).
edge(27, [1,3,4,5]).
edge(28, [1,3,4,5]).
edge(29, [1,3,4,5]).
edge(30, [1,3,4,5]).
edge(31, [1,3,4,5]).
edge(32, [1,3,4,5]).
edge(34, [1,3,4,5]).
edge(35, [1,3,4,5]).
edge(36, [1,3,4,5]).


dfs(Source) :- 
                edge(Source, Adjacent),
                


