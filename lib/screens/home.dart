import 'package:flutter/material.dart';

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
    );
  }

  void setEmptyFields() => setState(() {
        matrix = List.generate(countMatrix,
            (index) => List.generate(countMatrix, (index) => Player.none));
      });
}
