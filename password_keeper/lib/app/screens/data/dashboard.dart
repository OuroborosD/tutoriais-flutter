import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:password_keeper/app/model/password.dart';
import 'package:password_keeper/app/screens/auth/login.dart';
import 'package:password_keeper/app/screens/data/password_page.dart';
import 'package:password_keeper/app/screens/widget/item.dart';
import 'package:password_keeper/utils/DB.dart';
import 'package:password_keeper/app/screens/widget/confirmation.dart';
import '../../model/user.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key, this.user});
  final User? user;

  @override
  State<DashBoard> createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  TextEditingController search = TextEditingController();
  DbHelper db = DbHelper();
  List<Password> list_password = [];
  bool searching = false;
  int flex_search = 4;
  FocusNode focus = FocusNode();
  Password? deleted;

  String place = 'teste';
  String url =
      'https://www.tutorialspoint.com/dart_programming/dart_programming_for_loop.html';
  String login = 'pessoa';
  String senha = '12345';
  int i = 0;

  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      widget.createState();
    });
  }

  void searchingDB() {
    if (search.text.isEmpty || search.text == null) {
      searching = false;
    } else {
      searching = true;
    }
    print(searching);
    setState(() {
      searching;
      //widget.createState();
    });
  }

  // teste 2
  dummy() async {
    Password px = Password();
    int aux = 1;
    List<Password> lista = [];

    px.place = '$place';
    px.url = '$url';
    px.login = '$login + $i';
    px.password = '$senha + $i';
    px.fk_user = 1;
    i += 1;

    await db.insert(px).then((value) {
      print('	linha 66-------arquivo: px------- valor:$px	');

      setState(() {});
    });
  }

  deleteAllPassword() {
    db.deletepassword(widget.user!.id!).then((value) {
      Navigator.pop(context);
      setState(() {
        widget.createState();
      });
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
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
                        //BOOK como chamr uma fun????o de pois que saiu da pagina
                        builder: (context) => PasswordPage(user: widget.user)))
                // o push ?? um futre ent??o pode ser usado o then, quando ele retorna a pagina.
                .then((value) {
              setState(() {
                widget.createState();
              });
            });
          },
          child: Icon(Icons.add),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 224, 58, 63),
                    ),
                    currentAccountPictureSize: Size.square(85),
                    accountName: Text(
                      widget.user!.login!,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    accountEmail: null,
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        '${widget.user!.login![0]}${widget.user!.login![1]}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255,122, 93, 81),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person_remove,
                      color: Color.fromARGB(255, 224, 58, 63),
                    ),
                    title: Text("Apagar Usuario",style: TextStyle(color: Color.fromARGB(255,122, 93, 81),),),
                    onTap: () {
                      Confirmation(
                        context: context,
                        user: widget.user,
                        text:
                            'tem certeza que quer apagar todo o Usuario:${widget.user!.login!}\n\n ao clicar em corfirmar todos os dados ser??o perdidos',
                        fun: () {
                          db.deletepassword(widget.user!.id!).then((value) {
                            db.delete(widget.user!.id!).then((value) {
                              //refresh();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            });
                          });
                        },
                      );
                      //Navegar para outra p??gina
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 224, 58, 63),
                    ),
                    title: Text("apagar senhas"),
                    onTap: () {
                      Confirmation(
                          //BOOK recriar, parte para mandar fun????o assincrona
                          context: context,
                          user: widget.user,
                          text:
                              'Tem certeza que quer apagar todos as senhas? \n\n ao clicar em corfirmar todos as contas ser??o apagados',
                          fun: () {
                            db.deletepassword(widget.user!.id!).then((value) {
                              setState(() {
                                widget.createState();
                              });
                            });
                          });
                      //Navegar para outra p??gina
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 224, 58, 63),
                    ),
                    title: Text("add 1 dummy account"),
                    onTap: () {
                      dummy();
                    },
                  )
                ],
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 224, 58, 63),
                ),
                title: Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                  // o push ?? um futre ent??o pode ser usado o then, quando ele retorna a pagina.

                  //Navegar para outra p??gina
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: 8,
              ),
              //BOOK se n??o colocar o expanded, vai ficar com tamanho fixo, mesmo quando abre o keyboad. ?? isso que voc?? quer
              Stack(children: [
                //BOOK layout usando o stack, coloca um campo maior no come??o, para dar cor
                Container(
                    height: 100.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255,122, 93, 81),
                      
                    )),
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 224, 58, 63),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  //color: Colors.white,
                  //BOOK como verificar se algo tem focado de forma simples
                  // child: Focus(
                  // onFocusChange: (focus) {
                  //   if (focus) {
                  //     setState(() {
                  //       flex_search = 3;
                  //       print(
                  //           '	linha 165-------arquivo: ------- valor:$flex_search	');
                  //     });
                  //   } if(!focus) {
                  //     setState(() {
                  //       flex_search = 2;

                  //       print(
                  //           '	linha 175-------arquivo: ------- valor:$flex_search	');
                  //     });
                  //   }
                  // },
                  child: TextField(
                    controller: search,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (value) {
                      searchingDB(); //altera o estado cada vez que digita algo.
                    },
                    decoration: const InputDecoration(
                      //label: Text('local'),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 3)),
                      
                      hintText: "facebook..",
                      hintStyle: TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                  //flex: 22,
                  child: RefreshIndicator(
                onRefresh: refresh,
                //BOOK refazer codigo do future builder
                child: FutureBuilder<List>(
                  //BOOK adicionar como fazer a pesquisa
                  future: searching == true
                      ? db.search(search.text, widget.user!.id!)
                      : db.getAll(widget.user),
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.red),
                              strokeWidth: 5,
                            ),
                          ),
                        );

                      default:
                        if (snapshot.hasError) {
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        }
                        if (snapshot.data!.isEmpty || snapshot.data == null) {
                          return Center(
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              alignment: Alignment.center,
                              child: searching
                                  ? const Text(
                                      'Nem um Registo encontrado!',
                                      style: TextStyle(fontSize: 22, color: Color.fromARGB(255,122, 93, 81),),
                                    )
                                  : const Text(
                                      'Sem registros no Banco',
                                      style: TextStyle(fontSize: 22, color: Color.fromARGB(255,122, 93, 81),),
                                    ),
                            ),
                          );
                        } else {
                          list_password = snapshot.data as List<Password>;
                          return ListView.builder(
                              itemCount: list_password.length,
                              itemBuilder: ((context, index) {
                                //BOOK usando dismissable
                                return Dismissible(
                                  key: Key(index
                                      .toString()), // que tem que ser algo unico, que pode ser convertido em String
                                  background: Container(
                                    color: Colors
                                        .white, // ?? assim que colcoa a cor de fundo que aparede do slide
                                  ),
                                  onDismissed: (direction) {
                                    print(direction);
                                    print('${list_password[index]}');
                                    print(
                                        '	linha 263-------arquivo: ------- valor:${list_password[index]}	');
                                    deleted = list_password[index];
                                    db
                                        .deleteOnePassword(
                                            list_password[index].id!)
                                        .then((value) {
                                      print(value);
                                      //setState(() {});
                                    });
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars(); // limpa a snackbar antiga caso aparece uma nova
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      duration: const Duration(
                                          seconds:
                                              6), // para saber o tempo de dura????o que fica aparecendo
                                      content:
                                          Text('${deleted!.place} apagado!'),
                                      action: SnackBarAction(
                                          label: 'Defazer',
                                          onPressed: () {
                                            db.insert(deleted).then((value) {
                                              setState(() {});
                                            });
                                          }),
                                    ));
                                  },

                                  child: GestureDetector(
                                    child: ItemPassword(
                                      p1: list_password[index],
                                    ),
                                    onTap: () {
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
                                    onDoubleTap: () async {
                                      final url =
                                          Uri.parse(list_password[index].url!);
                                      _launchInBrowser(url);
                                    },
                                    onLongPress: () async {
                                      await Share.share(
                                          """${list_password[index].place}\n link:${list_password[index].url}\n login: ${list_password[index].login}\n senha: ${list_password[index].password}
                                                          """,
                                          subject: 'informa????es');
                                    },
                                  ),
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
