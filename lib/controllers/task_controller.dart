import 'package:get/get.dart';
import 'package:to_do/db/db_helper.dart';
import 'package:to_do/models/task.dart';

class TaskController extends GetxController {
  RxList taskList = [].obs;
  DBHelper  dbHelper = DBHelper();

  String tableName = DBHelper.tableName;


  //add data(task) to data base and return  a response(id of task)
  addTask({required Task task}){
    return dbHelper.insertTask(task);
  }

  //delete data(task) from data base
  Future<void> deleteTask({required Task task}) async{
    await dbHelper.deleteTask(task);
    await getTasks(); // to update changes
  }

  Future<void> deleteAllTask(String tableName) async{
    await dbHelper.deleteAllTask(tableName);
    await getTasks(); // to delete All Tasks
  }



  //update isCompleted  from data base
  void updateTask({required int id}) async{  // marks a task as completed
    await dbHelper.updateTask(id);
    await getTasks(); // to update changes
  }
 //update date  from data base
  void updateDate({required String date,required int id}) async{  // marks a task as completed
    await dbHelper.updateDate(date,id);
    await getTasks(); // to update changes
  }


  //get data(tasks) from data base
  Future<void> getTasks() async{
    final List<Map<String, Object?>>? tasks = await  dbHelper.query();
    taskList.assignAll(tasks!.map((task){
      return Task.fromJson(task);
    }).toList());
  }
}
