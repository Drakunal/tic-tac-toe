import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/screens/home.dart';
import 'package:tic_tac_toe/screens/wrapper.dart';
import 'package:tic_tac_toe/services/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final user = FirebaseAuth.instance.currentUser!;

  await Firebase.initializeApp();
  runApp(App());
  // StreamProvider<User>.value(value: null, initialData: user, child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => Authenticate(),
        child: MaterialApp(
          home: Wrapper(),
        ),
      );
}
