import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/services/notification_services.dart';
import 'package:to_do/services/theme_services.dart';
import 'package:to_do/ui/size_config.dart';
import 'package:to_do/ui/widgets/add_date_bar.dart';
import 'package:to_do/ui/widgets/add_task_bar.dart';
import 'package:to_do/ui/widgets/show_tasks.dart';


import '../themes.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late NotifyHelper notifyHelper ;
  TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions(); // request permissions from IOS
    notifyHelper.initializeNotification();  // this function to initialize Notifications
    taskController.getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    //Get.isDarkMode ? const Icon(Icons.light):const Icon(Icons.dark_mode)
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: buildAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
              children: [
                addTaskBar(),
                const AddDateBar(),
                ShowTasks(),
                //TaskTile(task: Task(id: 1, title: 'Playing', note: 'aaaaaa aaaa aaaa aaa aaa aaa aaa saaa aa aa a  aa aaaa', isCompleted: 0, date: DateTime.now().toString(), startTime: '11:24', endTime: '12:00', color: 1, remind: 0, repeat: '11111')),

              ],
            ),

        ),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
    leading: IconButton(onPressed: (){
      ThemeServices().switchTheme();
      notifyHelper.displayNotification(title: 'Hello Mustafa',body: 'this is my message body');

      }, icon: Get.isDarkMode ? const Icon(Icons.wb_sunny,color: Colors.white,):const Icon(Icons.dark_mode,color: darkGreyClr,),),
    elevation: 0,
    backgroundColor: context.theme.backgroundColor,
    actions: [
      IconButton(onPressed:()=>  showDialog(), icon: const Icon(Icons.cleaning_services_outlined,color: Colors.red,)),
      const CircleAvatar(
        backgroundImage:  AssetImage('assets/images/person.jpeg'),
        radius: 20,
      ),
      SizedBox(width: 15,),
    ],
  );
}
//taskController.deleteAllTask(taskController.tableName)

void showDialog(){
  TaskController taskController = Get.put(TaskController());
  Get.defaultDialog(
    title: 'Remove All Tasks',
    content: const FittedBox(child: Text('Are you sure to delete all tasks?',style: TextStyle(fontSize: 18),)),
    actions: [
      TextButton(onPressed: (){
        taskController.deleteAllTask(taskController.tableName);  // deleting all tasks
        NotifyHelper().cancelAllScheduleNotification();         // deleting all notifications
        Get.back();
      }, child: const Text('Yes',style: TextStyle(fontSize: 18,color: Colors.green))),
      TextButton(onPressed: ()=> Get.back(), child: const Text('Cancel',style: TextStyle(fontSize: 18,color: Colors.red))),
    ]  ,
  );
}
