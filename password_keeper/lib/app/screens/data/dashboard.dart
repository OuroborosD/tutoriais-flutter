import 'package:flutter/material.dart';
import 'package:password_keeper/app/model/password.dart';
import 'package:password_keeper/app/screens/auth/login.dart';
import 'package:password_keeper/app/screens/data/add_password.dart';
import 'package:password_keeper/app/screens/data/password_page.dart';
import 'package:password_keeper/app/screens/widget/item.dart';
import 'package:password_keeper/utils/DB.dart';

import '../../model/user.dart';

class DashBoard extends StatefulWidget {
  DashBoard({super.key, this.user});
  final User? user;

  @override
  State<DashBoard> createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  DbHelper db = DbHelper();
  List<Password> list_password = [];

  Future<Null> refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      widget.createState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        //BOOK como chamr uma função de pois que saiu da pagina
                        builder: (context) => AddPasword(user: widget.user)))
                // o push é um futre então pode ser usado o then, quando ele retorna a pagina.
                .then((value) {
              setState(() {
                widget.createState();
              });
            });
          },
          child: Icon(Icons.add),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 224, 58, 63),
                ),
                currentAccountPictureSize: Size.square(85),
                accountName: Text(
                  widget.user!.login!,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                accountEmail: null,
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '${widget.user!.login![0]}${widget.user!.login![1]}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 224, 58, 63),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person_remove,
                  color: Color.fromARGB(255, 224, 58, 63),
                ),
                title: Text("apagar usuario"),
                onTap: () {
                  db.deletepassword(widget.user!.id!).then((value) {
                    db.delete(widget.user!.id!).then((value) {
                      //refresh();
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              //BOOK como chamr uma função de pois que saiu da pagina
                              builder: (context) => Login()));
                    });
                  });
                  //Navegar para outra página
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 224, 58, 63),
                ),
                title: Text("apagar senhas"),
                onTap: () {
                  db.deletepassword(widget.user!.id!).then((value) {
                    Navigator.pop(context);
                    setState(() {
                      widget.createState();
                    });
                  });
                  //Navegar para outra página
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 224, 58, 63),
                ),
                title: Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          //BOOK como chamr uma função de pois que saiu da pagina
                          builder: (context) => Login()));
                  // o push é um futre então pode ser usado o then, quando ele retorna a pagina.

                  //Navegar para outra página
                },
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Text('menus'),
              ),
              Expanded(
                  flex: 9,
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    //BOOK refazer codigo do future builder
                    child: FutureBuilder<List>(
                      future: db.getAll(widget.user),
                      builder: ((context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(
                              child: Container(
                                width: 200,
                                height: 200,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 5,
                                ),
                              ),
                            );
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                child: Icon(Icons.error),
                              );
                            } else {
                              list_password = snapshot.data as List<Password>;
                              return ListView.builder(
                                  itemCount: list_password.length,
                                  itemBuilder: ((context, index) {
                                    return GestureDetector(
                                      child: ItemPassword(
                                        p1: list_password[index],
                                      ),
                                      onTap: () {
                                        print(
                                            '	linha 180-------arquivo: dashboad------- valor:${list_password[index].login}	');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PasswordPage(
                                                      acount:
                                                          list_password[index],
                                                    ))).then((value) => {
                                              setState(() {
                                                widget.createState();
                                              })
                                            });
                                      },
                                    );
                                  }));
                            }
                        }
                      }),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
