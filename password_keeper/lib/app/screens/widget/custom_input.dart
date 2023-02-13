import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  CustomInput(
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
        suffix: widget.is_password!
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscure_text = !obscure_text;
                  });
                },
                icon: Icon(!obscure_text ? Icons.visibility : Icons.visibility_off),
                color: Color.fromARGB(255, 224, 58, 63),
              )
            : null,
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
