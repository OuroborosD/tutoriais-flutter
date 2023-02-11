import 'package:flutter/material.dart';
import 'package:password_keeper/app/model/password.dart';
import 'package:password_keeper/app/screens/data/add_password.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPasword(user: widget.user)));
          },
          child: Icon(Icons.add),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPictureSize: Size.square(85),
                accountName: Text(
                  widget.user!.login!,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                accountEmail: null,
                currentAccountPicture: CircleAvatar(
                  child: Text(
                      '${widget.user!.login![0]}${widget.user!.login![1]}'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
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
                child: Text('menus'),
              ),
              Expanded(
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
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
                              return Text('data');
                            }));
                      }
                  }
                }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
