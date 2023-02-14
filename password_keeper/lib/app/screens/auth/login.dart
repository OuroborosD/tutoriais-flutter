import 'package:flutter/material.dart';
import 'package:password_keeper/app/controller/auth.dart';

import 'package:password_keeper/app/screens/auth/create.dart';
import 'package:password_keeper/app/screens/data/dashboard.dart';
import 'package:password_keeper/app/screens/widget/header.dart';

import '../widget/custom_input.dart';

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
      backgroundColor: const  Color.fromARGB(255, 224, 58, 63),
      body: Column(
        children: [
          //FINISHED escrever como fazera tela de login
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
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    //color: Color.fromARGB(255, 224, 58, 63),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                         CustomInput(
                          controller: login,
                          label_text: 'usuário',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'usuario não pode estar vazia!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomInput(
                          controller: password,
                          label_text: 'senha',
                          is_password: true,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'senha não pode estar vazia!';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                            
                            },
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
                                  int.parse(password.text.trim()), login.text.trim());
                              l1.login().then((value) {
                                if (value['login']) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DashBoard(user: value['user'])));
                                } else {
                                  popUpInfoLogin(context, value);
                                }
                              });
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
                            Text('Não tem uma conta ?  '),
                            GestureDetector(
                                onTap: () {
                                  print('ir para o create page');
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
