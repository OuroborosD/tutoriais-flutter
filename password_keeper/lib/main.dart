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
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 224, 58, 63),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 224, 58, 63),
        ),
        inputDecorationTheme: const  InputDecorationTheme(
          iconColor: Color.fromARGB(255, 224, 58, 63),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 224, 58, 63))),
          focusedBorder:  UnderlineInputBorder(
              borderSide:  BorderSide(
                  color: Color.fromARGB(255, 224, 58, 63), width: 3)),
        ),
        textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 224, 58, 63),
            ),
            bodyText2: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 224, 58, 63),
            )),
        primaryColor:const Color.fromARGB(198, 224, 58, 64),
      ),
      home: const Login(),
    );
  }
}
