import 'package:flutter/material.dart';
import 'package:password_keeper/app/model/password.dart';
import 'package:password_keeper/app/model/user.dart';
import 'package:password_keeper/app/screens/widget/custom_input.dart';
import 'package:password_keeper/app/screens/widget/header.dart';
import 'package:password_keeper/utils/DB.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key, this.acount});
  Password? acount;

  TextEditingController place = TextEditingController();
  TextEditingController url = TextEditingController();
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DbHelper db = DbHelper();
  
  @override
  Widget build(BuildContext context) {
    place.text = acount!.place!;
    login.text = acount!.login!;
    password.text = acount!.password!;
    url.text = acount!.url!;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 58, 63),
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: Container(
              
              // esse bloco é para datar a borda curvada da imagem
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    //color: Color.fromARGB(255, 224, 58, 63),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        CustomInput(
                            label_text: 'Local',
                            controller: place,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'local não pode estar vazia!';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomInput(
                            label_text: 'Url',
                            controller: url,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'a url não pode estar vazia!';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 16,
                        ),
                        CustomInput(
                            label_text: 'login',
                            controller: login,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'login não pode estar vazia!';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 16,
                        ),
                        CustomInput(
                            label_text: 'Senha',
                            controller: password,
                            is_password: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'senha não pode estar vazia!';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 26,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                             
                              Password p1 = Password(
                                  id: acount!.id,
                                  place: place.text,
                                  url: url.text,
                                  login: login.text,
                                  password: password.text,
                                  fk_user: acount!.fk_user);
                              print('	linha 110-------arquivo: password_page------- valor:$p1	');
                              db.update(p1);
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 224, 58, 63),
                              )),
                          child: SizedBox(
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 224, 58, 63),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
