import 'package:flutter/material.dart';
import 'package:tic_tac_toe/shared/utils.dart';

class Player {
  static const none = '';
  static const X = 'X';
  static const O = 'O';
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static final countMatrix = 3;
  static final double size = 92;
  String lastMove = Player.none;
  late List<List<String>> matrix;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setEmptyFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic tac toe"),
      ),
      backgroundColor: getBackgroundColor(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Utils.modelBuilder(matrix, (index, model) => buildRow(index)),
      ),
    );
  }

  void setEmptyFields() => setState(() {
        matrix = List.generate(countMatrix,
            (index) => List.generate(countMatrix, (index) => Player.none));
      });

  Widget buildRow(int index) {
    final values = matrix[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(
          values, (indexy, value) => buildField(index, indexy)),
    );
  }

  Color getFieldColor(String value) {
    switch (value) {
      case Player.O:
        return Colors.blue;
      case Player.X:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  Color getBackgroundColor() {
    final thisMove = lastMove == Player.X ? Player.O : Player.X;
    return getFieldColor(thisMove).withAlpha(150);
  }

  Widget buildField(int index, int indexy) {
    final value = matrix[index][indexy];
    Color fieldColor = getFieldColor(value);
    return Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: fieldColor, minimumSize: Size(size, size)),
          onPressed: () => selectField(value, index, indexy),
          child: Text(
            value,
            style: TextStyle(color: Colors.black, fontSize: 32),
          )),
    );
  }

  selectField(String value, int index, int indexy) {
    if (value == Player.none) {
      final newValue = (lastMove == Player.X) ? Player.O : Player.X;

      setState(() {
        lastMove = newValue;
        matrix[index][indexy] = newValue;
      });
      if (isWinner(index, indexy)) {
        showEndDialog("Player $newValue Won!!!!");
      } else if (isEnd()) {
        showEndDialog("Draw!");
      }
    }
  }

  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != Player.none));
  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = matrix[x][y];
    final n = countMatrix;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  Future showEndDialog(String s) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(s),
            content: Text("Press to restart the game."),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setEmptyFields();
                    Navigator.pop(context);
                  },
                  child: Text("Restart"))
            ],
          ));
}
