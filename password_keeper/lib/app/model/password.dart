class Password {
  Password({this.place,this.login, this.password, this.id});
  int? id;
  String? place;
  String? url;
  String? login;
  String? password;

  Password.fromMap(Map map) {
    id = map['id'];
    place = map['place'];
    url = map['url'];
    password = map['password'];
  }
  Map<String, dynamic> toMap() {
    // transforma o objeto em mapa
    Map<String, dynamic> map = {
      'place': place,
      'url': url,
      'password': password,
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
