import 'package:flutter/material.dart';
import 'package:password_keeper/app/screens/auth/create.dart';

import 'package:password_keeper/app/screens/auth/login.dart';
import 'package:password_keeper/app/screens/data/dashboard.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 224, 58, 63),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 224, 58, 63),
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: Color.fromARGB(255, 224, 58, 63),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 224, 58, 63))),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 224, 58, 63), width: 3)),
        ),
        textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 224, 58, 63),
            ),
            bodyText2: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 224, 58, 63),
            )),
        primaryColor: Color.fromARGB(198, 224, 58, 64),
      ),
      home: Login(),
    );
  }
}
