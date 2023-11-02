% View - user interface
display_board :-
    board(Board),
    display_s(Board).

display_s(Board) :-
    get_node(1, ShortColor1, StackSize1, Board),
    get_node(2, ShortColor2, StackSize2, Board),
    get_node(3, ShortColor3, StackSize3, Board),
    get_node(4, ShortColor4, StackSize4, Board),
    get_node(5, ShortColor5, StackSize5, Board),
    get_node(6, ShortColor6, StackSize6, Board),
    get_node(7, ShortColor7, StackSize7, Board),
    get_node(8, ShortColor8, StackSize8, Board),
    get_node(9, ShortColor9, StackSize9, Board),
    get_node(10, ShortColor10, StackSize10, Board),
    get_node(11, ShortColor11, StackSize11, Board),
    get_node(12, ShortColor12, StackSize12, Board),
    get_node(13, ShortColor13, StackSize13, Board),
    get_node(14, ShortColor14, StackSize14, Board),
    get_node(15, ShortColor15, StackSize15, Board),
    get_node(16, ShortColor16, StackSize16, Board),
    get_node(17, ShortColor17, StackSize17, Board),
    get_node(18, ShortColor18, StackSize18, Board),
    get_node(19, ShortColor19, StackSize19, Board),
    get_node(20, ShortColor20, StackSize20, Board),
    get_node(21, ShortColor21, StackSize21, Board),
    get_node(22, ShortColor22, StackSize22, Board),
    get_node(23, ShortColor23, StackSize23, Board),
    get_node(24, ShortColor24, StackSize24, Board),
    get_node(25, ShortColor25, StackSize25, Board),
    get_node(26, ShortColor26, StackSize26, Board),
    get_node(27, ShortColor27, StackSize27, Board),
    get_node(28, ShortColor28, StackSize28, Board),
    get_node(29, ShortColor29, StackSize29, Board),
    get_node(30, ShortColor30, StackSize30, Board),
    get_node(31, ShortColor31, StackSize31, Board),
    get_node(32, ShortColor32, StackSize32, Board),
    get_node(33, ShortColor33, StackSize33, Board),
    get_node(34, ShortColor34, StackSize34, Board),
    get_node(35, ShortColor35, StackSize35, Board),
    get_node(36, ShortColor36, StackSize36, Board).



   format('~n', []),
format('                 +----+                  ~n', []),
format('                 | ~w~w  |                  ~n', [ShortColor1, StackSize1]),
format('               +----+----+               ~n', []),
format('               | ~w~w  | ~w~w  |               ~n', [ShortColor2, StackSize2, ShortColor3, StackSize3]),
format('            +----+----+----+             ~n', []),
format('            | ~w~w  | ~w~w  | ~w~w  |             ~n', [ShortColor4, StackSize4, ShortColor5, StackSize5, ShortColor6, StackSize6]),
format('          +----+----+----+----+          ~n', []),
format('          | ~w~w  | ~w~w  | ~w~w  | ~w~w  |          ~n', [ShortColor7, StackSize7, ShortColor8, StackSize8, ShortColor9, StackSize9, ShortColor10, StackSize10]),
format('       +----+----+----+----+----+        ~n', []),
format('       | ~w~w  | ~w~w  | ~w~w  | ~w~w  | ~w~w  |        ~n', [ShortColor11, StackSize11, ShortColor12, StackSize12, ShortColor13, StackSize13, ShortColor14, StackSize14, ShortColor15, StackSize15]),
format('     +----+----+----+----+----+----+     ~n', []),
format('     | ~w~w  | ~w~w  | ~w~w  | ~w~w  | ~w~w  | ~w~w  |     ~n', [ShortColor16, StackSize16, ShortColor17, StackSize17, ShortColor18, StackSize18, ShortColor19, StackSize19, ShortColor20, StackSize20, ShortColor21, StackSize21]),
format('  +----+----+----+----+----+----+----+   ~n', []),
format('  | ~w~w  | ~w~w  | ~w~w  | ~w~w  | ~w~w  | ~w~w  | ~w~w  |   ~n', [ShortColor22, StackSize22, ShortColor23, StackSize23, ShortColor24, StackSize24, ShortColor25, StackSize25, ShortColor26, StackSize26, ShortColor27, StackSize27, ShortColor28, StackSize28]),
format('+----+----+----+----+----+----+----+----+~n', []),
format('| ~w~w  | ~w~w  | ~w~w  | ~w~w  | ~w~w  | ~w~w  | ~w~w  | ~w~w  |~n', [ShortColor29, StackSize29, ShortColor30, StackSize30, ShortColor31, StackSize31, ShortColor32, StackSize32, ShortColor33, StackSize33, ShortColor34, StackSize34, ShortColor35, StackSize35, ShortColor36, StackSize36]),
format('+----+----+----+----+----+----+----+----+~n', []),
format('~n', []).



get_node(Position,ShortColor,StackSize, Board) :-
    member(Element, Board), Element = node(Position, Color , StackSize,_,_,_,_,_),
    (Color = yellow -> ShortColor = 'Y');
    (Color = blue -> ShortColor = 'B');
    (Color = blank -> ShortColor = ' ' , StackSize = ' ')
    .