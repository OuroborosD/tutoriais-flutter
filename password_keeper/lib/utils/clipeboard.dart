import 'package:flutter/services.dart';



//BOOK colocar no livro como criar o clipboard
class ClipBoardUltils{
  ClipBoardUltils();
  
  static Future<void> copy(String value) async{
    // função do packeg serviçes, já no flutter
    await Clipboard.setData(ClipboardData(// recebe a data que vai copiar
      text: value
    ));
  }
  static Future<String> paste() async{
    final paste_data =  await Clipboard.getData(Clipboard.kTextPlain);
    return  paste_data!.text ?? '';// caso não tenha nada retorna vazio
    
  }
  static Future<bool> hasData(String value) async{
    return Clipboard.hasStrings();
  }

}


