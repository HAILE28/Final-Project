import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ijob_clone_app/LoginPage/login_screen.dart';
import 'package:ijob_clone_app/usere_state.dart';
import '';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase
      .initializeApp(); //this will initialize the app in firebase and it is going to be writing inside "initialaization"

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                  child: Text(
                'ijob is being initalized',
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Signatra'),
              )),
            ),
          );
        } else if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                  child: Text(
                'an errorr has been occured',
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              )),
            ),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'JOJO',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: UserState(),
        );
      },
    );
  }
}
