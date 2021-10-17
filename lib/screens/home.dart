import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/services/database.dart';
import 'package:tic_tac_toe/shared/utils.dart';

class Player {
  static const none = '   ';
  static const X = 'X';
  static const O = 'O';
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  static int countMatrix = 3;
  static double size = 96;
  String _modeSelected = '3';
  List<String> modes = ['3', '4', '5', '6'];
  String lastMove = Player.none;
  late List<List<String>> matrix;
  String gameId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setEmptyFields();
  }

  @override
  _showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            child: changeSquares(),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic tac toe"),
        actions: [
          TextButton(
            onPressed: () {
              _showModal();
            },
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                Text("Setting", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              DatabaseService(gameId: gameId).addPlayers(1, gameId, 3);
              setEmptyFields();
              setState(() {
                gameId = user.email.toString();
              });
            },
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text("Create game", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              joinGame();
            },
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text("Join game", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: getBackgroundColor(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Utils.modelBuilder(matrix, (index, model) => buildRow(index)),
      ),
    );
  }

  void setEmptyFields() {
    setState(() {
      matrix = List.generate(countMatrix,
          (index) => List.generate(countMatrix, (index) => Player.none));
    });
    DatabaseService(gameId: gameId).addPlayers(1, gameId, 3);
  }

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
            style: TextStyle(color: Colors.black, fontSize: size / 3),
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
      int count = -1;
      int flag = 0;
      for (int i = 0; i <= 2; i++) {
        for (int j = 0; j <= 2; j++) {
          count++;
          if (i == index && j == indexy) {
            flag = 1;
            break;
          }
        }
        if (flag == 1) {
          break;
        }
      }
      String m = "m$count";
      DatabaseService(gameId: gameId).updateField(m, newValue);
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
      barrierDismissible: false,
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

  changeSquares() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(20),
            // hintStyle: TextStyle(color: Colors.black45),
            errorStyle: TextStyle(color: Colors.redAccent),
            border: OutlineInputBorder(),
            suffixIcon: Icon(
              Icons.crop_square_sharp,
            ),
            labelText: 'Change number of squares',
          ),
          value: _modeSelected,
          items: modes.map((mode) {
            return DropdownMenuItem(
              value: mode,
              child: Text("$mode"),
            );
          }).toList(),
          //  validator: (value) =>
          //     value!.isEmpty ? 'Enter the amount' : null,
          onChanged: (value) {
            setState(() {
              _modeSelected = value.toString();
              countMatrix = int.parse(_modeSelected);
              size = (288 / countMatrix);
              // DatabaseService(uid: user.uid).filter(_modeSelected);
            });
            setEmptyFields();
          },
        ),
      ),
    );
  }

  void joinGame() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: TextFormField(
              // userData!.name

              validator: (value) => value!.isEmpty ? 'Enter an id' : null,
              onChanged: (value) {
                setState(() {
                  gameId = value;
                });
              },
            ),
          );
        });
    DatabaseService(gameId: gameId).joinPlayers();
  }
}
