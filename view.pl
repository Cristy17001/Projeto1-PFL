:- consult('model.pl').

% View - user interface
display_board :-
    draw_board_positions,
    get_node(1, ShortColor1, StackSize1),
    get_node(2, ShortColor2, StackSize2),
    get_node(3, ShortColor3, StackSize3),
    get_node(4, ShortColor4, StackSize4),
    get_node(5, ShortColor5, StackSize5),
    get_node(6, ShortColor6, StackSize6),
    get_node(7, ShortColor7, StackSize7),
    get_node(8, ShortColor8, StackSize8),
    get_node(9, ShortColor9, StackSize9),
    get_node(10, ShortColor10, StackSize10),
    get_node(11, ShortColor11, StackSize11),
    get_node(12, ShortColor12, StackSize12),
    get_node(13, ShortColor13, StackSize13),
    get_node(14, ShortColor14, StackSize14),
    get_node(15, ShortColor15, StackSize15),
    get_node(16, ShortColor16, StackSize16),
    get_node(17, ShortColor17, StackSize17),
    get_node(18, ShortColor18, StackSize18),
    get_node(19, ShortColor19, StackSize19),
    get_node(20, ShortColor20, StackSize20),
    get_node(21, ShortColor21, StackSize21),
    get_node(22, ShortColor22, StackSize22),
    get_node(23, ShortColor23, StackSize23),
    get_node(24, ShortColor24, StackSize24),
    get_node(25, ShortColor25, StackSize25),
    get_node(26, ShortColor26, StackSize26),
    get_node(27, ShortColor27, StackSize27),
    get_node(28, ShortColor28, StackSize28),
    get_node(29, ShortColor29, StackSize29),
    get_node(30, ShortColor30, StackSize30),
    get_node(31, ShortColor31, StackSize31),
    get_node(32, ShortColor32, StackSize32),
    get_node(33, ShortColor33, StackSize33),
    get_node(34, ShortColor34, StackSize34),
    get_node(35, ShortColor35, StackSize35),
    get_node(36, ShortColor36, StackSize36),
    format('~n', []),
    format('                 +----+                  ~n', []),
    format('                 | ~w~w |                  ~n', [ShortColor1, StackSize1]),
    format('               +----+----+               ~n', []),
    format('               | ~w~w | ~w~w |               ~n', [ShortColor2, StackSize2, ShortColor3, StackSize3]),
    format('            +----+----+----+             ~n', []),
    format('            | ~w~w | ~w~w | ~w~w |             ~n', [ShortColor4, StackSize4, ShortColor5, StackSize5, ShortColor6, StackSize6]),
    format('          +----+----+----+----+          ~n', []),
    format('          | ~w~w | ~w~w | ~w~w | ~w~w |          ~n', [ShortColor7, StackSize7, ShortColor8, StackSize8, ShortColor9, StackSize9, ShortColor10, StackSize10]),
    format('       +----+----+----+----+----+        ~n', []),
    format('       | ~w~w | ~w~w | ~w~w | ~w~w | ~w~w |        ~n', [ShortColor11, StackSize11, ShortColor12, StackSize12, ShortColor13, StackSize13, ShortColor14, StackSize14, ShortColor15, StackSize15]),
    format('     +----+----+----+----+----+----+     ~n', []),
    format('     | ~w~w | ~w~w | ~w~w | ~w~w | ~w~w | ~w~w |     ~n', [ShortColor16, StackSize16, ShortColor17, StackSize17, ShortColor18, StackSize18, ShortColor19, StackSize19, ShortColor20, StackSize20, ShortColor21, StackSize21]),
    format('  +----+----+----+----+----+----+----+   ~n', []),
    format('  | ~w~w | ~w~w | ~w~w | ~w~w | ~w~w | ~w~w | ~w~w |   ~n', [ShortColor22, StackSize22, ShortColor23, StackSize23, ShortColor24, StackSize24, ShortColor25, StackSize25, ShortColor26, StackSize26, ShortColor27, StackSize27, ShortColor28, StackSize28]),
    format('+----+----+----+----+----+----+----+----+~n', []),
    format('| ~w~w | ~w~w | ~w~w | ~w~w | ~w~w | ~w~w | ~w~w | ~w~w |~n', [ShortColor29, StackSize29, ShortColor30, StackSize30, ShortColor31, StackSize31, ShortColor32, StackSize32, ShortColor33, StackSize33, ShortColor34, StackSize34, ShortColor35, StackSize35, ShortColor36, StackSize36]),
    format('+----+----+----+----+----+----+----+----+~n', []),
    format('~n', [])
    .

draw_board_positions :-
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




get_node(Position, ShortColor, StackSize) :-
    board(Board),
    member(node(Position, Color, S, _, _, _, _, _), Board),
    (
    (Color = yellow -> ShortColor = 'Y', StackSize = S);
    (Color = blue -> ShortColor = 'B', StackSize = S);
    (Color = blank -> ShortColor = ' ', StackSize = ' ')
    )
    .
