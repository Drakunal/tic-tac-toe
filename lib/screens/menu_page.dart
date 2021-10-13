import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/home.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text("Choose game mode"),
        ElevatedButton(onPressed: createGame(), child: Text("Create Game")),
        ElevatedButton(onPressed: joinGame(), child: Text("Join Game"))
      ],
    ));
  }

  createGame() {
    Container(
      child: Home(),
    );
  }

  joinGame() {
    Container(
      child: Home(),
    );
  }
}
