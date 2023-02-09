class User {
  User({this.login, this.password, this.id});
  int? id;
  String? login;
  int? password;

  User.fromMap(Map map) {
    id = map['id'];
    login = map['login'];
    password = map['password'];
  }
  Map<String, dynamic> toMap() {
    // transforma o objeto em mapa
    Map<String, dynamic> map = {
      'login': login,
      'password': password,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'id: $id, login: $login, password: $password';
  }
}
