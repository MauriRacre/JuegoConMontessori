import 'package:flutter/material.dart';

class PuzzleGame extends StatefulWidget {
  const PuzzleGame({Key? key}) : super(key: key); // Agrega el parámetro key
  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  List<int> tiles = List<int>.generate(16, (index) => index);
  int moves = 0;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      tiles.shuffle();
      moves = 0;
    });
  }

  bool isSolved() {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) {
        return false;
      }
    }
    return true;
  }

  void onTileTap(int index) {
    int emptyIndex = tiles.indexOf(0);
    if ((index - 1 == emptyIndex && index % 4 != 0) ||
        (index + 1 == emptyIndex && (index + 1) % 4 != 0) ||
        index - 4 == emptyIndex ||
        index + 4 == emptyIndex) {
      setState(() {
        tiles[emptyIndex] = tiles[index];
        tiles[index] = 0;
        moves++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasWon = isSolved();
    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzle Game'),
      ),
      body: Column(
        children: [
          Text('Moves: $moves', style: TextStyle(fontSize: 24)),
          if (hasWon) ...[
            Text('Congratulations! You solved the puzzle!', style: TextStyle(fontSize: 24, color: Colors.green)),
            ElevatedButton(
              onPressed: resetGame,
              child: Text('Play Again'),
            ),
          ] else
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemCount: tiles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onTileTap(index),
                    child: Container(
                      margin: EdgeInsets.all(4.0),
                      color: tiles[index] == 0 ? Colors.grey : Colors.blue,
                      child: Center(
                        child: Text(tiles[index] != 0 ? '${tiles[index]}' : '',
                            style: TextStyle(fontSize: 32, color: Colors.white)),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
