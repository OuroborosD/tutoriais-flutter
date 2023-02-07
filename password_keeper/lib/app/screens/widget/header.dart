
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;// pega o tamanho da tela
     //height: WidgetsBinding.instance.window.physicalSize.height,
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.3,// a altura é 1/3 da tela
      child: Image.asset('assets/images/password.png', fit: BoxFit.cover,),
    );
  }
}