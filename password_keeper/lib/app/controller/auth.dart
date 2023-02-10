import 'package:password_keeper/utils/DB.dart';

import '../model/user.dart';

class LoginController {
  LoginController(this.password,this.username);
  String? username;
  int? password;
  User user = User();
  DbHelper db = DbHelper();
  
  Future<Map> login()async{
    Map<String,dynamic> response =  {'login':false, 'response':''};
    user.login = username;
    user.password = password;
    try {
      await db.loginUser(user).then((value){
        response['login'] = true;
      });
    }catch(e){
      print(e);
      print('usuario não existe');
      if(await db.userExist(username)){
          response['response'] = 'senha incorreta';
          print('senha incorreta');
      }else{
        response['response'] = 'usuario incorreto';
        print('usuario incorreto');
      }
    }

    return response;
  }

}

class CreateController {
  CreateController(this.login, this.password);
  String? login;
  int? password;

  User user = User();
  DbHelper db = DbHelper();

  Future<bool> create() async {
    bool createdUser = false;

    user.login = login;
    user.password = password;

    await db.userExist(user.login).then((value) async {
      if (!value) {
        createdUser = true;
        db.insert(user).then((value) {});
      } else {}
    });

    return createdUser;
  }
}
