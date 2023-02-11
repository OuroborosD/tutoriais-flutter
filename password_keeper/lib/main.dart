import 'package:flutter/material.dart';
import 'package:password_keeper/app/screens/auth/create.dart';


import 'package:password_keeper/app/screens/auth/login.dart';
import 'package:password_keeper/app/screens/data/dashboard.dart';


void main () => runApp(App());




class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 224, 58, 63),
          
        ),
       textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 224, 58, 63),
        )
       ),
       primaryColor: Color.fromARGB(198, 224, 58, 64),

        ),
      
      home: Login(),
    );
  }
}