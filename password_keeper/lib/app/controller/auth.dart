import 'package:password_keeper/utils/DB.dart';

import '../model/user.dart';

class LoginController {}

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

    await db.getUser(user.login).then((value) async {
      if (value) {
        createdUser = true;
        db.insert(user).then((value) {});
      } else {}
    });

    return createdUser;
  }
}
