import 'package:shared_preferences/shared_preferences.dart';
//BOOK como usar chered preference
class PreferencesAuth{
  saveOnlyLogin(String? login, bool yes_no) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', login!);
    prefs.setBool('save_login?', yes_no);
  }

  Future<String?>  getOnlyLogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginHas = prefs.getString('login');
    return loginHas;
  }

  Future<bool?> getCheked()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? checked = prefs.getBool('save_login?');
    return checked;
  }

  

}
