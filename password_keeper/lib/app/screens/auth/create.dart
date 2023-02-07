import 'package:flutter/material.dart';

import 'package:password_keeper/app/screens/auth/login.dart';
import 'package:password_keeper/app/screens/widget/header.dart';

class Create extends StatelessWidget {
  const Create({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController login = TextEditingController();
    TextEditingController password1 = TextEditingController();
    TextEditingController password2 = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 58, 63),
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
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    //color: Color.fromARGB(255, 224, 58, 63),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: login,
                          style: TextStyle(
                            color: Color.fromARGB(255, 224, 58, 63),
                          ),
                          decoration: const InputDecoration(
                            label: Text(
                              'Usuario',
                              style: TextStyle(
                                color: Color.fromARGB(255, 224, 58, 63),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                // underline border
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 224, 58, 63))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 224, 58, 63),
                                    width: 3)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'insira o usuario!';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: password1,
                          style: TextStyle(
                            color: Color.fromARGB(255, 224, 58, 63),
                          ),
                          decoration: const InputDecoration(
                            label: Text(
                              'Senha',
                              style: TextStyle(
                                color: Color.fromARGB(255, 224, 58, 63),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                // underline border
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 224, 58, 63))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 224, 58, 63),
                                    width: 3)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'senha não pode estar vazia!';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: password2,
                          style: TextStyle(
                            color: Color.fromARGB(255, 224, 58, 63),
                          ),
                          decoration: const InputDecoration(
                            label: Text(
                              'Confirme  a Senha',
                              style: TextStyle(color: Color.fromARGB(255, 224, 58, 63),)
                            ),
                            enabledBorder: UnderlineInputBorder(
                                // underline border
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 224, 58, 63))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 224, 58, 63),
                                    width: 3)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              print('${password1.text} == ${password2.text}');
                              return 'senha não pode estar vazia!';
                            }
                            if (password1.text != value) {
                              print(
                                  'entrou aqui ${password1.text}  ${password2.text}');
                              return 'senhas precisam ser iguais';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print('hello word');
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
                        const SizedBox(
                          height: 26,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Já tem Conta?  '),
                            GestureDetector(
                                onTap: () {
                                  print('ir para o login');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: const Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color.fromARGB(198, 224, 58, 64),
                                    ),
                                  ),
                                )),
                          ],
                        )
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
