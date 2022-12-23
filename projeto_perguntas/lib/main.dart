import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp( PerguntaApp());


class _PerguntaAppState extends State<PerguntaApp> {

  
    int valor = 0;

    int resposta(){
      setState(() {
        valor++; 
        
      });
      print(valor);
      return valor;
    }

  Widget build(BuildContext context){

    final  perguntas = [
      "sadasldasldasldas1231asdasd23",
      "2132321dasmkdoqwewq2",
      "sadl,vcoewr6",
      "sadasldasldasldas1231asdasd23",
      "2132321dasmkdoqwewq2",
      "sadl,vcoewr6"
    ];

    

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  Text("perguntas"),
        ),
        body: Column(
          children: <Widget> [
            Text(perguntas[valor]),
            Text(perguntas[1]),
            Text(perguntas.elementAt(2)),
            ElevatedButton(
              onPressed: resposta, 
              child: Text('Botão'))
        ]),
      ),
    );
  }
}


class PerguntaApp extends StatefulWidget{
  @override
  State<PerguntaApp> createState() => _PerguntaAppState();
}
