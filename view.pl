% View - user interface
display_board :-
    board(Board),
    display_rows(Board).

display_rows(Board) :-
    format('~n', []),
    format('                 +----+                  ~n', []),
    format('                 | ~w  |                  ~n', [nth0(0, Board, Element)]),
    format('               +----+----+               ~n', []),
    format('               | ~w  | ~w  |               ~n', [Row2, Row3]),
    format('            +----+----+----+             ~n', []),
    format('            | ~w  | ~w  | ~w  |             ~n', [Row4, Row5, Row6]),
    format('          +----+----+----+----+          ~n', []),
    format('          | ~w  | ~w  | ~w  | ~w  |          ~n', [Row7, Row8, Row9, Row10]),
    format('       +----+----+----+----+----+        ~n', []),
    format('       | ~w  | ~w  | ~w  | ~w  | ~w  |        ~n', [Row11, Row12, Row13, Row14, Row15]),
    format('     +----+----+----+----+----+----+     ~n', []),
    format('     | ~w  | ~w  | ~w  | ~w  | ~w  | ~w  |     ~n', [Row16, Row17, Row18, Row19, Row20, Row21]),
    format('  +----+----+----+----+----+----+----+   ~n', []),
    format('  | ~w  | ~w  | ~w  | ~w  | ~w  | ~w  | ~w  |   ~n', [Row22, Row23, Row24, Row25, Row26, Row27, Row28]),
    format('+----+----+----+----+----+----+----+----+~n', []),
    format('| ~w  | ~w  | ~w  | ~w  | ~w  | ~w  | ~w  | ~w  |~n', [Row29, Row30, Row31, Row32, Row33, Row34, Row35, Row36]),
    format('+----+----+----+----+----+----+----+----+~n', []),
    format('~n', []).

