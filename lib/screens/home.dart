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
      backgroundColor: Colors.blue,
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

  Widget buildField(int index, int indexy) {
    final value = matrix[index][indexy];
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white, minimumSize: Size(size, size)),
        onPressed: () {},
        child: Text(
          value,
          style: TextStyle(fontSize: 32),
        ));
  }
}
