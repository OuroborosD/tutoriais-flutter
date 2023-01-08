import 'package:password_keeper/app/controller/auth.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String table = 'Account'; // para auxiliar criamos uma variá-vel

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
    id INTEGER PRIMARY KEY, name TEXT, acount INTEGER
    )
    """);
    });
  }

  Future<Account> insert(Account bank) async {
    Database dbTodo = await db;
    bank.id = await dbTodo.insert(table, bank.toMap());
    return bank;
  }

  Future<int> delete(int id) async {
    // o delete retorna um numero inteiro
    Database dbTodo = await db;
    return await dbTodo.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Account bank) async {
    Database dbTodo = await db;
    return await dbTodo
        .update(table, bank.toMap(), where: 'id = ?', whereArgs: [bank.id]);
  }

  Future<List> getAll() async {
    Database dbTodo = await db;
    List listMap = await dbTodo.rawQuery("SELECT * FROM $table;");
    List<Account> listTodo = [];
    for (Map m in listMap) {
      // convert LIST<MAP> in MAP
      listTodo.add(Account.fromMap(m)); //pick MAP, and convert them to

    }
    return listTodo;
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
