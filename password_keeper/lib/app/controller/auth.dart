class Account {
  Account({this.user, this.password, this.id});
  int? id;
  String? user;
  String? password;

  Account.fromMap(Map map) {
    id = map['id'];
    user = map['value'];
    password = map['password'];
   
  }
  Map<String, dynamic> toMap() {
    // transforma o objeto em mapa
    Map<String, dynamic> map = {
      'user': user,

      'password': password,

    };
    if (id != null) {
      
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'id: $id, user: $user, password: $password';
  }
}
