import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.red, // X color
      ),
      home: TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> board = List.filled(9, '');
  bool isPlayerOneTurn = true;

  String? checkWinner() {
    for (var pattern in winningPatterns) {
      if (board[pattern[0]] != '' &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        return board[pattern[0]];
      }
    }
    if (!board.contains('')) {
      return 'draw';
    }
    return null; // No winner yet
  }

  List<List<int>> winningPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      isPlayerOneTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? winner = checkWinner();
    String turnText = isPlayerOneTurn ? 'Player X\'s Turn' : 'Player O\'s Turn';
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              turnText,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 300,
              height: 300,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: TextButton(
                      onPressed: () {
                        if (board[index].isEmpty) {
                          setState(() {
                            board[index] = isPlayerOneTurn ? 'X' : 'O';
                            isPlayerOneTurn = !isPlayerOneTurn;
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.grey[400]!; // On press color
                            }
                            return Colors.grey[800]!; // Default color
                          },
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.grey[800]!, // Border color
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        board[index],
                        style: TextStyle(fontSize: 40, color: board[index] == 'X' ? Colors.red : Colors.green),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            winner != null
                ? winner == 'draw'
                ? Text('It\'s a draw!')
                : Text('Winner: $winner')
                : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetGame,
              child: Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}
