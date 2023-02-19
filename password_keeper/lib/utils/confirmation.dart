import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:password_keeper/app/model/password.dart';
import 'package:password_keeper/app/model/user.dart';

void Confirmation(
    {BuildContext? context, User? user, VoidCallback? fun, String? text}) {
  showDialog(
      context: context!,
      builder: (context) => AlertDialog(
            alignment: Alignment.center,
            icon: Icon(Icons.stop),
            content: Text(text!),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    //BOOK precisa ter o parenteses
                    fun!();
                    Navigator.pop(context);
                  },
                  child: Text('Confirmar!')),
            ],
          ));
}
