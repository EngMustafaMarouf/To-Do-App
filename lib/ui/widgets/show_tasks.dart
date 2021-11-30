import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/controllers/task_controller.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/services/notification_services.dart';
import 'package:to_do/ui/pages/add_task_page.dart';
import 'package:to_do/ui/size_config.dart';
import 'package:to_do/ui/themes.dart';
import 'package:to_do/ui/widgets/task_tile.dart';

import 'add_date_bar.dart';

class ShowTasks extends StatelessWidget {
  ShowTasks({Key? key}) : super(key: key);

 TaskController taskController = Get.put(TaskController());


  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    //RxList tasks = taskController.taskList ;

    return Obx((){
      if(taskController.taskList.isNotEmpty){
        return Expanded(
          child: RefreshIndicator(
            onRefresh:()=> taskController.getTasks(),
            child: ListView.builder(
                itemCount: taskController.taskList.length,
                scrollDirection: SizeConfig.orientation == Orientation.landscape?Axis.horizontal:Axis.vertical,
                itemBuilder: (ctx,index){

                  //handling repeated tasks
                  final task = taskController.taskList[index];
                  DateTime onlyDate1 = DateTime(AddDateBar.selectedDate.year, AddDateBar.selectedDate.month, AddDateBar.selectedDate.day);
                  DateTime onlyDate2 = DateTime(DateFormat.yMd().parse(task.date).year, DateFormat.yMd().parse(task.date).month, DateFormat.yMd().parse(task.date).day);
                  final difference = onlyDate1.difference(onlyDate2).inDays;
                 // print(onlyDate1);
                 // print(onlyDate2);
                 // print('Difference: $difference ');
                 //difference % 30 == 0 ::::: Not that we can't that : because not all months equals each other
                  if(task.date == DateFormat.yMd().format(AddDateBar.selectedDate) ||
                      task.repeat == 'Daily' ||
                      (task.repeat == 'Weekly' && difference % 7 == 0)||
                      (task.repeat == 'Monthly' && DateFormat.yMd().parse(task.date).day == AddDateBar.selectedDate.day )){


                     var  hour = task.startTime.toString().split(':')[0];
                     var minutes = task.startTime.toString().split(':')[1];
                     minutes = minutes.toString().split(' ')[0];
                     print(hour);
                     print(minutes);
                    NotifyHelper().scheduledNotification(int.parse(hour),int.parse(minutes),task);


                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(seconds: 1),
                      child: SlideAnimation(
                        horizontalOffset: 300,
                        child: FadeInAnimation(
                            child: TaskTile(task: taskController.taskList[index])),
                      ),
                    );
                  }else{
                    return Container();
                  }
                },
            ),
          ),
        );
      }else{
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(seconds: 2),
            child: SingleChildScrollView(
              child: Wrap(  //this is dynamic it sometimes row and sometimes column according to you landscape
                //alignment: WrapAlignment.center,          //this like mainAxis
                crossAxisAlignment: WrapCrossAlignment.center,   //this is CrossAxis
                direction:SizeConfig.orientation == Orientation.landscape? Axis.horizontal:Axis.vertical,
                children: [

                  SizeConfig.orientation == Orientation.landscape?const SizedBox(height: 5,):const SizedBox(height: 70,),
                  SvgPicture.asset('assets/images/task.svg',color: primaryClr.withOpacity(0.7),height: 150,semanticsLabel: 'Task',),
                  const SizedBox(height: 20,),
                  const Text("You don't have any tasks yet!\nAdd new tasks",textAlign: TextAlign.center,),
                  SizeConfig.orientation == Orientation.landscape?const SizedBox(height: 10,):const SizedBox(height: 10,),



                ],
              ),
            ),
          ),
        );
      }
    });

  }
}
