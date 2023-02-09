import 'package:flutter/material.dart';
import 'package:password_keeper/app/controller/auth.dart';

import 'package:password_keeper/app/screens/auth/login.dart';
import 'package:password_keeper/app/screens/widget/header.dart';

class Create extends StatelessWidget {
  const Create({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController login = TextEditingController();
    TextEditingController password1 = TextEditingController();
    TextEditingController password2 = TextEditingController();

    login.text = 'az';
    password1.text = '1234';
    password2.text = '1234';

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
                  key: formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
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
                            if (value.length < 2) {
                              return 'usuário precisa ter pelo menos 2 digitos';
                            }
                            if (!value
                                .toString()
                                .startsWith(RegExp(r'[A-Za-z]'))) {
                              // caso não tenha numero, o sinal é invertido

                              return 'usuario não pode começar com numeros';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: password1,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 224, 58, 63),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
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
                            if (value.length < 4) {
                              return 'senha precisa ter pelo menos 4 digitos';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: password2,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 224, 58, 63),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text('Confirme  a Senha',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 224, 58, 63),
                                )),
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
                            if (password1.text != value) {
                              return 'senhas precisam ser iguais';
                            }
                             return null;
                          }
                         
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              CreateController c1 = CreateController(
                                  login.text, int.parse(password1.text));
                              c1.create().then((value) {
                               
                                popUpInfoCreate(context, c1.login, value);
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
                                'Create',
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
                            const Text('Já tem Conta?  '),
                            GestureDetector(
                                onTap: () {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
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

void popUpInfoCreate(BuildContext context, String? user, bool status) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            alignment: Alignment.center,
            icon: status
                ? const Icon(
                    Icons.check,
                    size: 40,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.error_outline,
                    size: 40,
                    color: Colors.red,
                  ),
            content: status
                ? Text('usuario $user Foi Criado')
                : Text('Usuario $user Já Existe'),
            actions: [
              TextButton(
                  // botão
                  child: const Text('Ok'),
                  onPressed: () {
                    status
                        ? Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()))
                        : Navigator.pop(context);
                  }),
            ],
          ));
}

void snackUserCreateIfo(BuildContext context, String? user, bool status) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 6),
    content: status
        ? Text('usuario ${user} Foi criando')
        : Text('usuario ${user} já existe'),
    action: SnackBarAction(
        // botão
        label: 'OK',
        onPressed: () {
          status
              ? Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()))
              : Navigator.pop(context);
        }),
  ));
}
