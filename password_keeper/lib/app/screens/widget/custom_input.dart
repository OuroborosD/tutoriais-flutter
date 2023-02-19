import 'package:flutter/material.dart';
import 'package:password_keeper/utils/clipeboard.dart';

class CustomInput extends StatefulWidget {
  CustomInput(
      {super.key,
      this.controller,
      this.type,
      required this.label_text,
      this.is_password = false,
      this.has_copy_paste = false,
      required this.validator});
  TextEditingController? controller;
  TextInputType? type;
  String? Function(String?) validator;
  String? label_text;
  bool? is_password;
  bool has_copy_paste;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool obscure_text = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(
        color: Color.fromARGB(255, 224, 58, 63),
      ),
      keyboardType: widget.type,
      obscureText: widget.is_password! ? obscure_text : false,
      decoration: InputDecoration(
        suffixIcon: widget.has_copy_paste
            ? widget.is_password!
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            obscure_text = !obscure_text;
                          });
                        },
                        icon: Icon(!obscure_text
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Color.fromARGB(255, 224, 58, 63),
                      ),
                      IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () async {
                            print('copiar');
                            ClipBoardUltils.copy('teste');
                          },
                          icon: Icon(Icons.copy)),
                      IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () async {
                            print('colar');
                            widget.controller!.text =
                                await ClipBoardUltils.paste();
                          },
                          icon: Icon(
                            Icons.paste,
                          )),
                    ],
                  )
                //BOOK como adcionar 2 icones no sufix, para que eles ficam na lateral
                : Row(
                    // coloque o tamanho minimo, assim, cada item só vai ocuupar o menor espaço possivel
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () async {
                            ClipBoardUltils.copy(widget.controller!.text);
                            print(' ${widget.controller!.text} foi colado!');
                          },
                          icon: Icon(Icons.copy)),
                      IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () async {
                            widget.controller!.text =
                                await ClipBoardUltils.paste();
                            print(
                                'foi colado o valor:${widget.controller!.text}');
                          },
                          icon: Icon(
                            Icons.paste,
                          )),
                    ],
                  )
            :widget.is_password!
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            obscure_text = !obscure_text;
                          });
                        },
                        icon: Icon(!obscure_text
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Color.fromARGB(255, 224, 58, 63),
                      ),]):null
            ,
        label: Text(widget.label_text!,
            style: const TextStyle(
              color: Color.fromARGB(255, 224, 58, 63),
            )),
        enabledBorder: const UnderlineInputBorder(
            // underline border
            borderSide: BorderSide(color: Color.fromARGB(255, 224, 58, 63))),
        focusedBorder: const UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 224, 58, 63), width: 3)),
      ),
      validator: widget.validator,

      // onTap: (){
      //   widget.controller!.text = '';
      // },
    );
  }
}
