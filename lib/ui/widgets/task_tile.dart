import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/services/notification_services.dart';
import 'package:to_do/ui/size_config.dart';

import '../themes.dart';



class TaskTile extends StatefulWidget {

  const TaskTile({Key? key,required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  
  final taskController = Get.put(TaskController());
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: showSheet,
        child: Container(
          width: SizeConfig.orientation == Orientation.landscape?SizeConfig.screenWidth/2:SizeConfig.screenWidth,
          padding: EdgeInsets.all(SizeConfig.orientation == Orientation.landscape?5:8),
         // margin: EdgeInsets.only(top: 5,right: 20),
          decoration: BoxDecoration(
            color: getColor(widget.task.color!),
            borderRadius: BorderRadius.circular(20),

          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.task.title!,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)),
                        const SizedBox(height: 10,),
                        Row(children: [
                          const Icon(Icons.access_alarm),
                          const SizedBox(width: 10,),
                          Text('${widget.task.startTime} - ${widget.task.endTime}'),
                        ],),
                        const SizedBox(height: 8,),
                        Text(widget.task.note!),

                      ],
                    ),
              ),

               RotatedBox(quarterTurns: 3,child:widget.task.isCompleted == 1? const Text('Completed'): const Text('To Do')),


            ],
          ),
        ),
      ),
    );
  }

  getColor(int color) {
    switch(color){
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      default:
        return orangeClr;
    }
  }

  showSheet(){
    Get.bottomSheet(
      Container(
        height: widget.task.isCompleted == 0?SizeConfig.screenHeight*0.4:SizeConfig.screenHeight*0.3,
        decoration: BoxDecoration(
          color: Get.isDarkMode?Colors.grey.withOpacity(0.7):darkGreyClr.withOpacity(0.9),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [
              //SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(width: 40,height: 5,decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(30)),),
              ),
              if(widget.task.isCompleted == 0)
              buildMaterialButton('Task Completed',(){
                  setState(() {
                    NotifyHelper().cancelScheduleNotification(widget.task);  //cancel notification because it is completed
                    taskController.updateTask(id: widget.task.id!);

                    Get.back();
                  });
              }),
              buildMaterialButton('Delete Task',(){
                NotifyHelper().cancelScheduleNotification(widget.task);     //cancel notification because it is deleted
                taskController.deleteTask(task: widget.task);
                Get.back();
              }),
              const Divider(color: Colors.red),
              buildMaterialButton('Cancel',(){
                Get.back();
              }),
            ],
          ),
        ),
      )
    );
  }

  Widget buildMaterialButton(String label,Function function){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed:()=> function(),
        color: label == 'Delete Task'?Colors.red[300]:Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 13),
          child: Text(label,style: const TextStyle(color: Colors.white,fontSize: 20),),
        ),
      ),
    );
  }
}
