import 'package:flutter/material.dart';
//import 'dart:math';

class PuzzleGame extends StatefulWidget {
  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  final int _gridSize = 3;
  late List<int?> _puzzle;
  late List<int?> _solution;

  @override
  void initState() {
    super.initState();
    _initializePuzzle();
  }

  void _initializePuzzle() {
    _solution = List.generate(_gridSize * _gridSize, (index) => index);
    _puzzle = List.from(_solution);
    _puzzle.shuffle();
  }

  void _handleTap(int index) {
    int emptyIndex = _puzzle.indexOf(null);
    if (_canMove(index, emptyIndex)) {
      setState(() {
        _puzzle[emptyIndex] = _puzzle[index];
        _puzzle[index] = null;
        if (_puzzle.toString() == _solution.toString()) {
          _showCongratulationsDialog();
        }
      });
    }
  }

  bool _canMove(int index, int emptyIndex) {
    int row = index ~/ _gridSize;
    int col = index % _gridSize;
    int emptyRow = emptyIndex ~/ _gridSize;
    int emptyCol = emptyIndex % _gridSize;

    return (row == emptyRow && (col - emptyCol).abs() == 1) ||
           (col == emptyCol && (row - emptyRow).abs() == 1);
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Felicidades!'),
          content: Text('¡Has completado el rompecabezas!'),
          actions: <Widget>[
            TextButton(
              child: Text('Jugar de nuevo'),
              onPressed: () {
                Navigator.of(context).pop();
                _initializePuzzle();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego de Puzzle'),
        backgroundColor: Colors.orange[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _gridSize,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            padding: EdgeInsets.all(10),
            itemCount: _puzzle.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: Container(
                  color: _puzzle[index] == null ? Colors.grey[300] : Colors.orange[200],
                  child: Center(
                    child: Text(
                      _puzzle[index] == null ? '' : '${_puzzle[index]}',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
