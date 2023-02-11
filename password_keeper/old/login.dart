import 'package:flutter/material.dart';
import 'package:password_keeper/app/controller/auth.dart';

import 'package:password_keeper/app/screens/auth/create.dart';
import 'package:password_keeper/app/screens/data/dashboard.dart';
import 'package:password_keeper/app/screens/widget/header.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController login = TextEditingController();
    TextEditingController password = TextEditingController();
    login.text = 'az';
    password.text = '1234';

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => Create(),
      //         ));
      //   },
      //   child: Icon(
      //     Icons.account_circle_outlined,
      //     size: 40,
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      backgroundColor: Color.fromARGB(255, 224, 58, 63),
      body: Column(
        children: [
          //EXPLANATION escrever como fazera tela de login
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
                          style: const TextStyle(
                            color: Color.fromARGB(255, 224, 58, 63),
                          ),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 224, 58, 63),
                              ),
                              label: Text(
                                'Usuario',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 224, 58, 63),
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 224, 58, 63))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 224, 58, 63),
                                      width: 3))),
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
                          controller: password,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 224, 58, 63),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            label: Text(
                              'Senha',
                              style: TextStyle(
                                color: Color.fromARGB(255, 224, 58, 63),
                              ),
                            ),

                            //border: OutlineInputBorder(),
                            // enabledBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //       color: Color.fromARGB(255, 224, 58, 63),
                            //       width: 2),
                            // ),
                            // focusedBorder: OutlineInputBorder(
                            //     borderSide: BorderSide(
                            //         color: Color.fromARGB(255, 224, 58, 63),
                            //         width: 4)),
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
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Esqueceu a senha?',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromARGB(198, 224, 58, 64),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 26,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              LoginController l1 = LoginController(
                                  int.parse(password.text), login.text);
                              l1.login().then((value) {
                                if (value['login']) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               DashBoard()));
                                } else {
                                  popUpInfoLogin(context, value);
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 224, 58, 63),
                              )),
                          child: const SizedBox(
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
                            Text('Não tem uma conta ?  '),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Create()));
                                },
                                child: const Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'Criar Conta',
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

void popUpInfoLogin(BuildContext context, Map response) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.error_outline,
              size: 40,
              color: Colors.red,
            ),
            content: Text(response['response']),
            actions: [
              TextButton(
                  // botão
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ));
}
