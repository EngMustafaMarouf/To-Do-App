import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/ui/pages/add_task_page.dart';
import 'package:to_do/ui/themes.dart';

import 'button.dart';

Widget addTaskBar(){

  final TaskController taskController = Get.put(TaskController());

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat.yMMMMd().format(DateTime.now()),style: SubHeadingStyle,),
          Text('Today',style: headingStyle,),
        ],
      ),
      MyButton(label: '+ Add Task', onTap: ()async{
        await Get.to(()=> const AddTaskPage());
      }),
    ],
  );

}