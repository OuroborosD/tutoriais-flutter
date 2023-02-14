import 'package:password_keeper/app/controller/auth.dart';
import 'package:password_keeper/app/model/password.dart';
import 'package:password_keeper/app/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String table = 'user'; // para auxiliar criamos uma variá-vel
final String table2 = 'password';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal(); // não precisa

  factory DbHelper() => _instance; // não precisa entender
  DbHelper.internal(); // não precisa entender
  Database? _db;
  Future<Database> get db async {
    if (_db != null) {
      // verifica se o banco existe
      return _db!;
    } else {
      // caso não exista ele vai criar
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    // cria o banco de dados
    final databasePath = await getDatabasesPath(); // pega o caminho onde

    final path = join(databasePath, 'password.db');
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE $table(
              id INTEGER PRIMARY KEY, 
              login TEXT, 
              password INTEGER
    )
    """);

      //BOOK refazer a parte de chave estrangeira, no livro, pois não funciona o ON CASCEDE naquela forma
      // await db.execute("""
      //         CREATE TABLE $table2(
      //           id INTEGER PRIMARY KEY AUTOINCREMENT,
      //           place text NOT NULL,
      //           url TEXT DEFAULT "N/A",
      //           login TEXT NOT NULL,
      //           password TEXT NOT NULL,
      //           fk_user INTEGER NOT NULL,
      //           FOREIGN KEY (fk_user) REFERENCES $table(id) ON DELETE CASCADE
      //       );""");
      await db.execute("""
              CREATE TABLE $table2(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                place text NOT NULL,
                url TEXT DEFAULT "N/A",
                login TEXT NOT NULL,
                password TEXT NOT NULL,
                fk_user INTEGER NOT NULL,
                CONSTRAINT fk_constraint
                  FOREIGN KEY (fk_user)
                  REFERENCES $table(id)
                  ON DELETE CASCADE)
""");
    });
  }

  Future<dynamic> insert(dynamic bank) async {
    Database dbTodo = await db;
    // pega o nome da classe que foi colocada.
    String nome_class = bank.runtimeType.toString();
    print(nome_class);
    bank.id = await dbTodo.insert(
        nome_class == 'User' ? table : table2, bank.toMap());
    return bank;
  }

  Future<int> delete(int id) async {
    // o delete retorna um numero inteiro
    Database dbTodo = await db;
    return await dbTodo.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletepassword(int id) async {
    // o delete retorna um numero inteiro
    Database dbTodo = await db;
    return await dbTodo.delete(table2, where: 'fk_user = ?', whereArgs: [id]);
  }

  Future<int> update(dynamic bank) async {
    Database dbTodo = await db;
    return await dbTodo
        .update(table2, bank.toMap(), // o toMap iria dar erro, se fosse objeto
            where: 'id = ?',
            whereArgs: [bank.id]);
  }

  Future<List> getAll1() async {
    Database dbTodo = await db;
    List<User> lista = [];
    List listMap = await dbTodo.rawQuery("SELECT * FROM $table");
    for (Map m in listMap) {
      print('lista $m');
      lista.add(User.fromMap(m));
    }
    print(lista);
    return lista;
  }

  Future<List> getAll(dynamic generic_class) async {
    Database dbTodo = await db;
    List<Password> lista = [];
    List listMap = await dbTodo
        .rawQuery("SELECT * FROM $table2 WHERE fk_user = ${generic_class.id};");
    for (Map m in listMap) {
      print('lista $m');
      lista.add(Password.fromMap(m));
    }
    return lista;
  }

  Future<int?> getSize() async {
    Database dbTodo = await db;
    return Sqflite.firstIntValue(
        await dbTodo.rawQuery("SELECT COUNT(*)FROM $table"));
  }

  Future<int> deleteAll() async {
    Database dbTodo = await db;
    return dbTodo.rawDelete('DELETE FROM $table');
  }

  Future fechardb() async {
    Database dbTodo = await db;
    dbTodo.close();
  }

//-----------------------------single
  Future<bool> userExist(String? login) async {
    bool? exist;
    Database dbKeeper = await db;
    List<Object> lista = [];
    List listMap = await dbKeeper
        .rawQuery("SELECT login FROM $table WHERE login = '${login}';");

    if (listMap.isEmpty) {
      print('usuario não enctrontado no banco');
      print(listMap);
      exist = false;
    } else {
      print('usuario encontado no banco');
      print(listMap);
      exist = true;
    }
    return exist;
  }

  Future<User> loginUser(User user) async {
    Database dbKeeper = await db;
    List list = await dbKeeper.rawQuery(
        "SELECT * FROM user WHERE login = '${user.login}' AND password = ${user.password};");
    print('linha 136-------arquivo: DB.dart------- valor:$list');
    return User.fromMap(list[0]);
  }

  Future<List> search(String search, int fk) async {
    Database dbKeeper = await db;
    List<Password> list = [];
    List listMap = await dbKeeper.rawQuery(
        "SELECT * FROM $table2 WHERE place Like '$search%' and fk_user= $fk;");
    for (Map m in listMap) {
      list.add(Password.fromMap(m));
    }
    print('linha 174-------arquivo: DB.dart------- valor:$list');
    return list;
  }

  Future<dynamic> insertPassword(User user, Password password) async {
    Database dbTodo = await db;
    password.id = await dbTodo.insert(table, password.toMap());
    return password;
  }
}
