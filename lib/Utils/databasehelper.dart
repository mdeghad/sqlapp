import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlfliteapp/Models/task.dart';

class DataBase_Helper{
  static final  dataBaseName="task.db";
  static final  database_version=1;

  static final tableName="task";
  static final colTitle="title";
  static final colId="id";

  DataBase_Helper._constructor();

  static final DataBase_Helper instance=new DataBase_Helper._constructor();

  static Database database;

Future<Database> get _database async{
  if(database!=null) return database;
  database =await initDataBase();
  return database;
}

  initDataBase() async{
  String path=join(await getDatabasesPath(),dataBaseName);
  return await openDatabase(path,version: database_version,onCreate: _onCreate);
  }

  Future _onCreate(Database database1,int version) async{
await database1.execute("CREATE TABLE $tableName($colId INTEGER PRIMARY KEY,$colTitle TEXT NOT NULL)");
  }

  Future<int> insert(Task task)async{
     Database db=await instance._database;
     var result=await db.insert(tableName, task.toMap());
     return result;
  }


  Future<int> delete(Task task)async{
    Database db=await instance._database;
    var result=await db.delete(tableName, where: '$colId=?', whereArgs: ['id']);
    return result;
  }

  Future<List<Map<String,dynamic>>> getAllData()async{
    Database db=await instance._database;
    var result=await db.query(tableName, orderBy: '$colId DESC');
    return result;
  }

  // Future<int> updateNote() async {
  //   var dbClient = await _database;
  //   return await dbClient.update(tableName, where: "$colId = ?", whereArgs: [note.id]);
  //
  // }


  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance._database;
    int id = row[colId];
    return await db.update(tableName, row, where: '$colId = ?', whereArgs: [id]);
  }
  // Future<int> update(Task task) async {
  //   var dbClient = await _database;
  //   return await dbClient.update(
  //     tableName,
  //     task.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [task.id],
  //   );
  // }
}