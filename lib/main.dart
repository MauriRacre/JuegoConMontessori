import 'package:flutter/material.dart';
import 'games/memory_game.dart';
import 'games/puzzle_game.dart' as puzzle_game; // Usa un alias para evitar conflictos
//import 'games/quiz_game.dart' as quiz_game;     // Usa un alias para evitar conflictos
import 'games/color_sorting_game.dart';
import 'games/tic_tac_toe_game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juegos Educativos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          //headline6: TextStyle(color: Colors.teal[900], fontSize: 24, fontWeight: FontWeight.bold),
          //button: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juegos Educativos'),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryGame()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700], // Color del botón
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: Text('Juego de Memoria', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => puzzle_game.PuzzleGame()), // Usa el alias para PuzzleGame
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[700], // Color del botón
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: Text('Juego de Puzzle', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ColorSortingGame()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[700], // Color del botón
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: Text('Ordenar Bolas por Color', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TicTacToeGame()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[600], // Color del botón
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              child: Text('Tres en Raya', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[100], // Color de fondo de la pantalla
    );
  }
}
