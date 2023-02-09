
import 'package:password_keeper/utils/DB.dart';

import '../model/user.dart';

class LoginController{


}



class CreateController{
  CreateController(this.login,this.password);
    String? login;
    int? password;

  User user = User();
  DbHelper db = DbHelper();

 void create(){
  user.login = this.login;
  user.password = this.password;
  db.getUser(user.login).then((value){
    if (value){
      print('usuario já cadastrado no sistema');
    }else{
      db.insert(user).then((value){
        db.getAll(user).then((value){
          print(value);
        });
      });
    }
  });



 }

}