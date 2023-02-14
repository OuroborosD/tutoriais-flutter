import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_keeper/app/controller/auth.dart';
import 'package:password_keeper/app/model/password.dart';
import 'package:password_keeper/utils/clipeboard.dart';

class ClipBoardInput extends StatefulWidget {
  ClipBoardInput(
      {super.key,
      this.controller,
      this.type,
      required this.label_text,
      this.is_password = false,
      required this.validator});
  TextEditingController? controller;
  TextInputType? type;
  String? Function(String?) validator;
  String? label_text;
  bool? is_password;
  bool? has_copy_paste;

  @override
  State<ClipBoardInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<ClipBoardInput> {
  bool obscure_text = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //padding: EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: TextFormField(
              controller: widget.controller,
              style: const TextStyle(
                color: Color.fromARGB(255, 224, 58, 63),
              ),
              keyboardType: widget.type,
              obscureText: widget.is_password! ? obscure_text : false,
              decoration: InputDecoration(
                suffix: widget.is_password!
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                obscure_text = !obscure_text;
                              });
                            },
                            icon: Icon(!obscure_text
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: Color.fromARGB(255, 224, 58, 63),
                          )
                        : null,
                label: Text(widget.label_text!,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 224, 58, 63),
                    )),
                enabledBorder: const UnderlineInputBorder(
                    // underline border
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 224, 58, 63))),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 224, 58, 63), width: 3)),
              ),
              validator: widget.validator,

              // onTap: (){
              //   widget.controller!.text = '';
              // },
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      print('colar');
                      widget.controller!.text = await ClipBoardUltils.paste();
                    },
                    icon: Icon(
                      Icons.paste,
                    )),
                IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      print('copiar');
                      ClipBoardUltils.copy('teste');
                    },
                    icon: Icon(Icons.copy)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
