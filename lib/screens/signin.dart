import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/services/authenticate.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Text(
                "Tic Tac Toe",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              // Image(image: AssetImage('assets/images/logo.png')),
              Spacer(),
              // Text("Hi"),
              // Spacer(),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                      primary: Colors.white,
                      onPrimary: Colors.black),
                  onPressed: () {
                    final provider =
                        Provider.of<Authenticate>(context, listen: false);
                    provider.googleLogin();
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                  label: Text("Sign in using google account")),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _a() {}
}
