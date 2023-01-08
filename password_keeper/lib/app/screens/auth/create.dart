import 'package:flutter/material.dart';

import 'package:password_keeper/app/screens/auth/login.dart';

class Create extends StatelessWidget {
  const Create({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController login = TextEditingController();
    TextEditingController password1 = TextEditingController();
    TextEditingController password2 = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ));
        },
        child: Icon(
          Icons.login,
          size: 40,
        ),
        backgroundColor: Color.fromARGB(88, 192, 45, 45),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                height: 400,
                color: Color.fromARGB(88, 192, 45, 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: login,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          label: Text(
                            'Usuario',
                            style: TextStyle(color: Colors.black),
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 6))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'insira o usuario!';
                        }
                      },
                    ),
                    TextFormField(
                      controller: password1,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          label: Text(
                            'Senha',
                            style: TextStyle(color: Colors.black),
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 6))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'senha não pode estar vazia!';
                        }
                      },
                    ),
                    TextFormField(
                      controller: password2,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          label: Text(
                            'Confirme  a Senha',
                            style: TextStyle(color: Colors.black),
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 6))),
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
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('hello word');
                          
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(200, 192, 45, 45),
                      ),
                      child: Text('Login'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
