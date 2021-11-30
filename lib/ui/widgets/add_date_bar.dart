import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/ui/themes.dart';


class AddDateBar extends StatefulWidget {
  const AddDateBar({Key? key}) : super(key: key);
  static DateTime selectedDate = DateTime.now();
  @override
  _AddDateBarState createState() => _AddDateBarState();
}

class _AddDateBarState extends State<AddDateBar> {

  TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      width: 70,
      height: 100,
      initialSelectedDate: AddDateBar.selectedDate,
      selectionColor: Get.isDarkMode?Colors.deepPurple:Colors.orange.withOpacity(0.5),
      selectedTextColor: Colors.green,
      dayTextStyle: bodyStyle,
      monthTextStyle: bodyStyle,
      dateTextStyle: bodyStyle,
      onDateChange: (newDate){
      setState(() {
        AddDateBar.selectedDate = newDate;
        taskController.getTasks();
        //print(AddDateBar.selectedDate);
        //print(selectedDate);
      });
      },


    );
  }
}
