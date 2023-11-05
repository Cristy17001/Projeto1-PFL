# Agere PFL 2023/2024

## Group Information

- **Topic/Game:** Agere
- **Group:** Agere_5
- **Members:** 
  - up202108813 - Cristiano Filipe Moreira Rocha
  - up202108836 - José Pedro Trocado Ferreira
- **Contribution:**
  - Cristiano Rocha: 60%
  - José Ferreira: 40%

## Installation and Execution

To execute the game, ensure you have SICStus Prolog 4.8 installed. Consult the file `main.pl` in your Prolog environment. Once the file is consulted, simply follow the provided instructions on how to play the game. No additional installation of external libraries is required, as all necessary libraries are included within SICStus Prolog 4.8.

## Description of the Game

Agere is a two-player game where the objective is to create a continuous trail of the same color, originating from a player's starting position, that touches all three sides of the triangular board. Additionally, the corners of the board are counted as touching the two sides that converge at that corner (e.g., the left corner touches the bottom and left sides).

In this game, there are two types of possible movements:

1. Placing a piece of the corresponding color in an empty space.
2. Moving one piece from a stack of pieces with the same size to another stack with that size, provided it is adjacent and of a different color (e.g., if a stack of size 2 has a yellow piece on top, it can be moved to an adjacent stack of size 2 with a blue piece on top. This action leaves behind a stack of 1 blue piece and places the yellow piece on top of a stack of 3 with yellow pieces on top).

For a more comprehensive understanding of the game, we recommend referring to the well-documented site that provides detailed explanations and insights: [Agere Game Rules](https://adere.drew-edwards.com/).

## Game Logic

### Internal Game State Representation

For managing the game state, we implemented a dynamic `game_state/1` predicate. The possible states are:

- `menu`
- `rules`
- `exit`
- `pVp` (player Vs player)
- `pVc` (player Vs computer)
- `cVc` (computer Vs computer)

To switch the current state, we created a predicate called `change_game_state(State)`. For processing based on the current state, we developed `process_game_state(State)`, which is responsible for calling all the necessary predicates for the corresponding state.

#### Board Representation

We represent the board as an undirected graph using a `board/1` predicate, which is a list of nodes with the following attributes:

- `Position`
- `Color` (color of the piece, default is blank)
- `StackSize` (size of the current stack in that position, default is 0)
- `Visited`
- `IsLeft`
- `IsRight`
- `IsBottom`
- `Adjacents`

#### Player Representation

To keep track of the current player, we utilize a dynamic `current_player/1` predicate, which can be either 'yellow' or 'blue'. Yellow always starts as the first player.

#### Game Actions

- Pieces are placed using the `place_piece/1` predicate.
- Pieces are moved using the `move_piece/2` predicate.

#### Game End

When a game ends with one player winning, `initialize_game` is called to reset the board, `current_player`, `won`, and `game_state`.

### Game State Visualization

In our game display approach, we opted for having distinct predicates for display, which are called inside the `process_state/1` predicate. This way, the display functions execute based on the current state without the need to pass the game state explicitly.

## Piece Representation

We represent the pieces on the board using a combination of letters and numbers:

- Letters indicate the color of the piece, where 'Y' stands for yellow and 'B' for blue.
- Numbers represent the size of the stack. For example, 'Y2' signifies a stack with two pieces, with the bottom one being blue and the top one yellow.

#### Board positions and Possible game: 

                     +----+                                        +----+                   
                     | 01 |                                        | Y1 |                   
                   +----+----+                                   +----+----+                
                   | 02 | 03 |                                   |    |  Y1 |                
                +----+----+----+                              +----+----+----+              
                | 04 | 05 | 06 |                              |    | B2 |  Y1 |              
              +----+----+----+----+                         +----+----+----+----+           
              | 07 | 08 | 09 | 10 |                         |    |    | B1 |    |           
           +----+----+----+----+----+                    +----+----+----+----+----+         
           | 11 | 12 | 13 | 14 | 15 |                    |    |    |    |    |    |         
         +----+----+----+----+----+----+               +----+----+----+----+----+----+      
         | 16 | 17 | 18 | 19 | 20 | 21 |               |    |    |    |    |    |    |      
      +----+----+----+----+----+----+----+          +----+----+----+----+----+----+----+    
      | 22 | 23 | 24 | 25 | 26 | 27 | 28 |          |    |    |    |    |    |    |    |    
    +----+----+----+----+----+----+----+----+     +----+----+----+----+----+----+----+----+ 
    | 29 | 30 | 31 | 32 | 33 | 34 | 35 | 36 |     |    |    |    |    |    |    |    |    | 
    +----+----+----+----+----+----+----+----+     +----+----+----+----+----+----+----+----+ 

### Move Validation and Execution

To validate a move, we've implemented several predicates:

- `valid_move/2`: This predicate calls `check_player_color/1`, `check_adjacency/2`, and `check_stack/2` to ensure the move is valid.
- `valid_place/1`: This predicate verifies if a specific place is blank, making it a valid location to place a piece.
- `place_piece(Position)`: Responsible for placing a piece on the board at a specified position.
- `move_piece(FromPosition, ToPosition)`: Handles the actual movement of a piece from one position to another.

### List of Valid Moves

To obtain a list of valid moves, crucial for generating a random move for the computer, we use:

- `get_valid_moves(ReturnList, Player)`: This predicate returns a list of valid moves for a given player.
- `get_valid_places(ReturnList)`: This predicate provides a list of valid places for piece placement.

### End of Game

For a game to end, a player must, at the start of their turn, have a trail of pieces of their color connecting all three sides of the triangle. We utilize a personalized Depth-First Search (DFS) algorithm that keeps track of which sides have been touched. This allows us to determine if the player has actually won or not. The predicate to check if a player has won is `check_winning/0`. If true, it means the current player has won; otherwise, the game continues. When a game ends, the `initialize_game/0` predicate is called to reset the game and change the current state to the menu.

### Game State Evaluation

To evaluate the current board and the values of its nodes, `board(Board)` can be used. To get the current game state, `game_state(State)` can be used. To get the current player, `current_player(Player)` can be used.

### Input Validation

In our game, we implement input validation to ensure that the positions provided by the user are within the valid range of 1 to 36. Additionally, we verify if the user has correctly specified the type of movement they wish to perform. The valid movement types include:

- `move`: Used to move a piece.
- `place`: Used to place a piece.
- `stop`: Used to return to the main menu.

These validation checks help maintain the integrity of the game and prevent unintended actions. For example, attempting to perform an action with an invalid position or specifying an unrecognized movement type will prompt the user to provide valid input.

### Computer Plays

During the development of our project, we encountered challenges in implementing the second level of difficulty for the computer opponent. At present, the computer makes random moves using the `get_maneuver(ListOfMoves, ListOfPlaces)` function. In this function, `ListOfMoves` represents the available moves, and `ListOfPlaces` signifies the available places on the board.

The computer's strategy involves randomly selecting an element from both of these lists and executing the chosen maneuver.

## Conclusions

In the development of our Agere game, we successfully implemented key features such as game state representation, move validation, and game state visualization. Our implementation allows for engaging gameplay between two players or with computer opponents.

However, we acknowledge certain limitations in our current version. The second level of difficulty for the computer opponent presented challenges in achieving a more strategic decision-making process. While the current approach provides a basic level of gameplay, further refinement is needed to create a more formidable adversary.

## Bibliography

- [Agere Game Rules and Introduction](https://adere.drew-edwards.com/): This website provides comprehensive game rules and serves as an initial introduction to Agere, offering valuable insights for players looking to understand the game mechanics and strategies.

- [SWI-Prolog Documentation](https://www.swi-prolog.org/): We extensively utilized the SWI-Prolog documentation for reference, particularly for verifying the names and parameters of the predicates within the imported modules. This resource proved invaluable in ensuring the accuracy and functionality of our Prolog codebase.
