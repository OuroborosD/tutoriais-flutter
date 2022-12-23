import 'package:ntodo/app/model/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


const  String  table= 'todos'; // para auxiliar criamos uma variá-vel com o nome da table

class DbHelper{
  static final DbHelper _instance =  DbHelper.internal();// não preci-sa entender
  factory DbHelper() => _instance;// não precisa entender
  DbHelper.internal();// não precisa entender

  Database? _db;

  Future<Database>get db async{
    if(_db != null){ // verifica se o banco existe
      return _db!;
    }else{// caso não exista ele vai criar 
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async{// cria o banco de dados
    final databasePath = await  getDatabasesPath();// pega o caminho onde está feito
    final path = join(databasePath,'tarefas.db'); // (caminho_tel, nome_db)

    return openDatabase(
      path, version:1,
      onCreate: (Database db, int version) async{
        await db.execute(
           """CREATE TABLE $table(
                id INTEGER PRIMARY KEY, title TEXT, status INTEGER
           )
           """
        );
      } );
  }

  Future<Todo> insert(Todo tarefas) async{
    Database dbTodo = await db;
    tarefas.id = await dbTodo.insert(table, tarefas.toMap());//pick the OB-JECT, convert him to a MAP, and inser into table.
    return tarefas;
    
  }

  // Future<Todo> getTodo(int id) async{
  //   Database dbTodo = await db;
  //   List<Map> maps = await dbTodo.query(table,
  //     columns: ['id','tarefa','data']);
  // }

  Future<int> delete(int id) async{// o delete retorna um numero in-teiro
    Database dbTodo = await db;
    return await dbTodo.delete(table, where: 'id = ?', whereArgs:[id]);
  }
  
  Future<int> update(Todo tarefas) async{// o delete retorna um nu-mero inteiro
    Database dbTodo = await db;
    return await dbTodo.update(table, tarefas.toMap(), where: 'id = ?', whereArgs: [tarefas.id]);
  }

  Future<List> getAll()async{
    Database dbTodo = await db;
    List listMap = await dbTodo.rawQuery("SELECT * FROM $table ORDER BY status;");// recieve all table data, in format LIST <MAP>
    List<Todo>  listTodo = [];
    for(Map m in listMap){// convert LIST<MAP> in MAP
      listTodo.add(Todo.fromMap(m));//pick MAP, and convert them to OBJECT
    }
    return listTodo;
  }

  Future<int?> getSize() async{
    Database dbTodo =await db;
    return Sqflite.firstIntValue(await dbTodo.rawQuery("SELECT COUNT(*) FROM $table"));
  }

   Future<int> deleteAll() async{
    Database dbTodo = await db;
    return dbTodo.rawDelete('DELETE FROM $table');
  }

  Future fechardb() async{
    Database dbTodo = await db;
    dbTodo.close();
  }

 

}
