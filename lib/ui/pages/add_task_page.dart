import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/size_config.dart';
import 'package:to_do/ui/widgets/button.dart';
import 'package:to_do/ui/widgets/input_field.dart';

import '../themes.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TaskController taskController = Get.put(TaskController());

  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  //TextEditingController titleController = TextEditingController();
  //TextEditingController noteController = TextEditingController();

  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a').format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  int selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int selectedColor = 0;

  Widget buildDropDownButton(List itemsList, bool isRemind) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DropdownButton(
              dropdownColor: Get.isDarkMode ? Colors.brown : Colors.orange,
              value: isRemind ? selectedRemind : selectedRepeat,
              underline: Container(),
              borderRadius: BorderRadius.circular(15),
              icon: const Visibility(
                visible: false, child: Icon(Icons.arrow_drop_down),),
              items: itemsList.map((val) {
                return DropdownMenuItem(value: val,
                    child: isRemind ? Text('$val minutes early') : Text(val));
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  if (isRemind) {
                    selectedRemind = newVal as int;
                  } else {
                    selectedRepeat = newVal.toString();
                  }
                });
              },

            ),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget buildCircleAvatar(Color color, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = index;
        });
      },
      child: CircleAvatar(
        radius: 15,
        backgroundColor: color,
        child: selectedColor == index ? const Icon(
          Icons.done, size: 20, color: Colors.white,) : null,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add Task', style: titleStyle),
                ],
              ),
              Text('Title', style: titleStyle,),
              const SizedBox(height: 5,),
              InputField(title: 'title',
                hint: 'Enter title here',
                controller: titleController,),
              const SizedBox(height: 10,),
              Text('Note', style: titleStyle,),
              const SizedBox(height: 5,),
              InputField(title: 'Note',
                hint: 'Enter note here',
                controller: noteController,),
              const SizedBox(height: 10,),
              Text('Date', style: titleStyle,),
              const SizedBox(height: 5,),
              InputField(
                title: 'Date', hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined),
                  onPressed: getDateFromUser,), function: getDateFromUser,),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Start Time', style: titleStyle,),
                        const SizedBox(height: 5,),
                        InputField(
                          title: 'Note', hint: startTime, widget: IconButton(
                          icon: const Icon(Icons.access_alarm),
                          onPressed: () => getTimeFromUser(true),
                        ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 7,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('End Time', style: titleStyle,),
                        const SizedBox(height: 5,),
                        InputField(
                          title: 'Note', hint: endTime, widget: IconButton(
                          icon: const Icon(Icons.access_alarm),
                          onPressed: () => getTimeFromUser(false),),),
                      ],
                    )
                    ,),
                ],
              ),
              const SizedBox(height: 10,),
              Text('Remind', style: titleStyle,),
              const SizedBox(height: 5,),
              //InputField(title: 'Note', hint: '5 minutes early',widget: const Icon(Icons.arrow_drop_down),),
              buildDropDownButton(remindList, true),
              const SizedBox(height: 10,),
              Text('Repeat', style: titleStyle,),
              const SizedBox(height: 5,),
              buildDropDownButton(repeatList, false),
              const SizedBox(height: 13,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Task Color', style: titleStyle,),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          buildCircleAvatar(bluishClr, 0),
                          const SizedBox(width: 5,),
                          buildCircleAvatar(pinkClr, 1),
                          const SizedBox(width: 5,),
                          buildCircleAvatar(orangeClr, 2),
                        ],
                      ),
                    ],
                  ),
                  MyButton(label: 'Create Task', onTap:addTaskToDo)
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() =>
      AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
          taskController.getTasks();
        },
            icon: const Icon(Icons.arrow_back_ios, color: primaryClr,)),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.jpeg'),
            radius: 20,
          ),
          SizedBox(width: 15,),
        ],
      );


  bool validateData() {
    if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar(
          'required',
          'Title and Note Field are required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.withOpacity(0.5),
          icon: const Icon(Icons.warning_amber, color: Colors.red,)

      );

      return false;
    }
    return true;
  }

  void addTaskToDo() async {
    if (validateData()) {
      var value = await taskController.addTask(task: Task(
        title: titleController.text,
        note: noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(selectedDate),
        startTime: startTime,
        endTime: endTime,
        color: selectedColor,
        remind: selectedRemind,
        repeat: selectedRepeat,
      ));
      Get.back();
      taskController.getTasks();
      print('return value is : $value');
      //print(titleController.text);
     // print(noteController.text);
    } else {
      print('Error Occurred');
    }
  }

  void getDateFromUser() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );

    setState(() {
      if (pickedDate != null) {
        selectedDate = pickedDate;
      } else {
        print('you canceled operation');
      }
    });
  }

  void getTimeFromUser(bool isStartTime) async {
    var pickedTime = await showTimePicker(
        context: context, initialTime: isStartTime?TimeOfDay.fromDateTime(DateTime.now()):
        TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15)))
    );

    setState(() {
      if (pickedTime != null) {
        String formattedTime = pickedTime.format(context);
        if (isStartTime) {
          startTime = formattedTime;
        } else {
          endTime = formattedTime;
        }
      } else {
        print('you canceled operation');
      }
    });
  }

}