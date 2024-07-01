import 'package:flutter/material.dart';

class ColorSortingGame extends StatefulWidget {
  @override
  _ColorSortingGameState createState() => _ColorSortingGameState();
}

class _ColorSortingGameState extends State<ColorSortingGame> {
  final List<Color> _colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow];
  final List<List<Color?>> _cestas = List.generate(4, (_) => []);
  final List<Color> _bolas = List.generate(20, (index) => Colors.primaries[index % Colors.primaries.length]);

  @override
  void initState() {
    super.initState();
    _bolas.shuffle();
  }

  void _moveBall(Color color, int index) {
    setState(() {
      _cestas[index].add(color);
      _bolas.remove(color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego de Ordenar Bolas por Color'),
        backgroundColor: Colors.pink[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Arrastra las bolas al color correspondiente',
              style: TextStyle(fontSize: 24, color: Colors.pink[800], fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (int i = 0; i < _cestas.length; i++)
                  Draggable<Color>(
                    data: _colors[i],
                    feedback: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: _colors[i],
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26, offset: Offset(2, 2))],
                      ),
                    ),
                    childWhenDragging: Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[400],
                      child: Center(
                        child: Text(
                          '${_cestas[i].length}',
                          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: _colors[i],
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26, offset: Offset(2, 2))],
                      ),
                      child: Center(
                        child: Text(
                          '${_cestas[i].length}',
                          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: EdgeInsets.all(10),
                itemCount: _bolas.length,
                itemBuilder: (context, index) {
                  return DragTarget<Color>(
                    onAccept: (color) => _moveBall(color, _colors.indexOf(color)),
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        decoration: BoxDecoration(
                          color: _bolas[index],
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black26, offset: Offset(2, 2))],
                        ),
                        child: Center(
                          child: Text(
                            '',
                            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
