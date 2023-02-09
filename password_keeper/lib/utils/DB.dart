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

    final path = join(databasePath, 'alura_bank.db');
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE $table(
              id INTEGER PRIMARY KEY, 
              login TEXT, 
              password INTEGER
    )
    """);
      await db.execute("""
              CREATE TABLE $table2(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                place text NOT NULL,
                url TEXT DEFAULT "N/A",
                password TEXT NOT NULL,
                fk_user INTEGER NOT NULL,
                FOREIGN KEY (fk_user) REFERENCES $table(id) ON DELETE CASCADE
            );""");
    });
  }

  Future<dynamic> insert(dynamic bank) async {
    Database dbTodo = await db;
    bank.id = await dbTodo.insert(table, bank.toMap());
    return bank;
  }

  Future<int> delete(int id) async {
    // o delete retorna um numero inteiro
    Database dbTodo = await db;
    return await dbTodo.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(dynamic bank) async {
    Database dbTodo = await db;
    return await dbTodo
        .update(table, bank.toMap(), where: 'id = ?', whereArgs: [bank.id]);
  }

  Future<bool> getUser(String? login) async {
    bool? empty;
    Database dbTodo = await db;
    List<Object> lista = [];
    List listMap =
        await dbTodo.rawQuery("SELECT login FROM $table WHERE login = $login");
    print(listMap);
    if (listMap.isEmpty) {
      print('entoru no vazio');

      empty = false;
    } else {
      print('entoru no cheio');
      empty = true;
    }
    return empty;
  }

  Future<List> getAll(Object generic_class) async {
    Database dbTodo = await db;
    List<Object> lista = [];
    List listMap = await dbTodo.rawQuery("SELECT * FROM $table;");
    if (generic_class.runtimeType == User) {
      List listMap = await dbTodo.rawQuery(
          "SELECT * FROM $table;"); // pega todas as tables, retornadas em MAP
      for (Map m in listMap) {
        //pega a lista, separa  cada item
        // e joga dentro da função fromMap
        // que tranforma o MAP em Objeto User
        print('lista $m');
        lista.add(User.fromMap(m));
      }
    } else {
      List listMap = await dbTodo.rawQuery("SELECT * FROM $table2;");
      for (Map m in listMap) {
        print('lista $m');
        lista.add(Password.fromMap(m));
      }
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
}