class Password {
  Password({this.place,this.url,this.login, this.password, this.id, this.fk_user});
  int? id;
  String? place;
  String? url;
  String? login;
  String? password;
  // ignore: non_constant_identifier_names
  int? fk_user;

  Password.fromMap(Map map) {
    id = map['id'];
    place = map['place'];
    url = map['url'];
    login = map['login'];
    password = map['password'];
    fk_user = map['fk_user'];
  }
  Map<String, dynamic> toMap() {
    // transforma o objeto em mapa
    Map<String, dynamic> map = {
      'place': place,
      'url': url,
      'login': login,
      'password': password,
      'fk_user': fk_user,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'id: $id, place: $place, password: $password';
  }
}
