import 'package:flutter/material.dart';


import 'package:password_keeper/app/screens/auth/login.dart';
import 'package:password_keeper/app/screens/data/home.dart';


void main () => {runApp(App())};




class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child: Login()),
    );
  }
}