import 'package:sqflite/sqflite.dart';
import 'package:to_do/models/task.dart';

class DBHelper{  // Dealing with Data Base


  static Database? _db;
  static const  int _version = 1;
  static const String tableName = 'tasks';

  // initialize and Creating  the DB
  static Future<void> initDb()async {
    print('init DB function Called');
    if(_db != null){
      print('DB not null');
    }else{
      try{
        String _path = await getDatabasesPath()+'tasks.db';
        _db = await openDatabase(_path,version: _version,onCreate: (Database db, int version) async {
          // When creating the db, create the table
          print('start creating DB');
          await db.execute(
              'CREATE TABLE $tableName('
              'id INTEGER PRIMARY KEY, '
              'title STRING, note TEXT, date STRING, '
              'startTime STRING, endTime STRING, '
              'remind INTEGER, repeat STRING, '
              'color INTEGER, '
              'isCompleted INTEGER)'
          );

          print('DB Created');

        });

      }catch(e){
        print('an error occurred  $e');
      }


    }
  }

  Future<int> insertTask(Task task) async{
    print('insert function Called');
    return await _db!.insert(tableName, task.toJson());
  }

  Future<int> deleteTask(Task task) async{
    print('delete function Called');
    //? operator should be an ID
    //Note that it check id in where must be tha same id in whereArgs
    return await _db!.delete(tableName,where: 'id = ?',whereArgs: [task.id]);
  }

  Future<int> deleteAllTask(String _tableName) async{
    print('delete All function Called');
    return await _db!.delete(_tableName);
  }


  Future<int> updateTask(int id) async{
    print('Row update function Called');
    //now that rawUpdate will update row only but update will update all table
    //? operator should be an ID
    //Note that it check id in where must be tha same id in whereArgs
    //Note that title only will be updated
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
    ''',[1,id]);
    // 1 will be assigned to isCompleted and id will be assigned to id in where to compare
  }

  Future<int> updateDate(String date, int id) async{
    print('Row update function 2 Called');
    //now that rawUpdate will update row only but update will update all table
    //? operator should be an ID
    //Note that it check id in where must be tha same id in whereArgs
    //Note that title only will be updated
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET date = ?
    WHERE id = ?
    ''',[date,id]);
    // 1 will be assigned to isCompleted and id will be assigned to id in where to compare
  }



  Future<List<Map<String, Object?>>> query() async{
    print('Query function Called');
    //it will show all table as a list of map
    return await _db!.query(tableName);
  }





}