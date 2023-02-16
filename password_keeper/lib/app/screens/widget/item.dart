import 'package:flutter/material.dart';

import '../../model/password.dart';

double valor = 100;

class ItemPassword extends StatelessWidget {
  ItemPassword({super.key, this.p1});
  Password? p1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: ListTile(
       
        textColor: Colors.white,
        iconColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        tileColor: Color.fromARGB(255, 224, 58, 63),
        leading: Icon(
          Icons.lock,
          size: 50,
          color: Colors.white,
        ),
        title: Text(
          p1!.place!.toUpperCase(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'PTSerif'),
        ),
        subtitle: Text(p1!.url!,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
                fontSize: 12,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.italic,
                //BOOK colocar no livro como adcionar font, em estatico
                fontFamily: 'PTSerif')),
      ),
    );
  }
}
