import 'package:flutter/material.dart';


import 'package:password_keeper/app/screens/auth/create.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController login = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Create(),));
        },
        child: Icon(
          Icons.account_circle_outlined,
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
                height: 300,
                color: Color.fromARGB(88, 192, 45, 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: login,
                      style: TextStyle(color: Colors.white),
                      decoration:const  InputDecoration(
                          label: Text('Usuario', style: TextStyle(color: Colors.black),),
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
                      controller: password,
                      style: TextStyle(color: Colors.white),
                      decoration:const  InputDecoration(
                          label: Text('Senha', style: TextStyle(color: Colors.black),),
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
                    ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
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
