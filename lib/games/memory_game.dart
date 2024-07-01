import 'package:flutter/material.dart';
//import 'dart:math';

class MemoryGame extends StatefulWidget {
  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  late List<String> _cards;
  late List<String> _shuffledCards;
  late List<bool> _cardFlips;
  int _flippedCardIndex1 = -1;
  int _flippedCardIndex2 = -1;
  int _score = 0;
  int _pairsFound = 0;
  int _totalPairs = 6;

  @override
  void initState() {
    super.initState();
    _cards = List.generate(_totalPairs * 2, (index) => (index ~/ 2).toString());
    _cards.shuffle();
    _shuffledCards = List.from(_cards);
    _cardFlips = List.generate(_totalPairs * 2, (_) => false);
  }

  void _flipCard(int index) {
    if (_flippedCardIndex1 == -1) {
      setState(() {
        _cardFlips[index] = true;
        _flippedCardIndex1 = index;
      });
    } else if (_flippedCardIndex2 == -1 && index != _flippedCardIndex1) {
      setState(() {
        _cardFlips[index] = true;
        _flippedCardIndex2 = index;
      });

      if (_shuffledCards[_flippedCardIndex1] == _shuffledCards[_flippedCardIndex2]) {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _cardFlips[_flippedCardIndex1] = true;
            _cardFlips[_flippedCardIndex2] = true;
            _flippedCardIndex1 = -1;
            _flippedCardIndex2 = -1;
            _score += 10;
            _pairsFound++;
            if (_pairsFound == _totalPairs) {
              _showCongratulationsDialog();
            }
          });
        });
      } else {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _cardFlips[_flippedCardIndex1] = false;
            _cardFlips[_flippedCardIndex2] = false;
            _flippedCardIndex1 = -1;
            _flippedCardIndex2 = -1;
          });
        });
      }
    }
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Felicidades!'),
          content: Text('¡Ganaste! Tu puntuación es $_score puntos.'),
          actions: <Widget>[
            TextButton(
              child: Text('Jugar de nuevo'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      _cards.shuffle();
      _shuffledCards = List.from(_cards);
      _cardFlips = List.generate(_totalPairs * 2, (_) => false);
      _flippedCardIndex1 = -1;
      _flippedCardIndex2 = -1;
      _score = 0;
      _pairsFound = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego de Memoria'),
        backgroundColor: Colors.teal[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Puntos: $_score',
            style: TextStyle(fontSize: 24, color: Colors.teal[700], fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            padding: EdgeInsets.all(10),
            itemCount: _cards.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _flipCard(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: _cardFlips[index] ? Colors.teal[300] : Colors.teal[100],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _cardFlips[index] ? _shuffledCards[index] : '',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
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
