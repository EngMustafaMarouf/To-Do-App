import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes.dart';

class NotificationPage extends StatefulWidget {
  final String payLoad;

  const NotificationPage({Key? key,required this.payLoad}) : super(key: key);
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  String _payLoad = '';

  @override
  void initState(){
    _payLoad = widget.payLoad;
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: Text(_payLoad.split('|')[0],style: TextStyle(color: Get.isDarkMode?Colors.white:Colors.black)),
        leading: IconButton(
          onPressed: ()=> Get.back(),
          icon: Icon(Icons.arrow_back_ios,color: Get.isDarkMode?Colors.white:darkGreyClr),),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
      ),
      body: SafeArea(
          child: Column(
            children:  [
              const SizedBox(height: 25,),
              Text('Hello,Mustafa',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Get.isDarkMode?Colors.white:darkGreyClr),),
              const SizedBox(height: 10,),
              Text('You have a new reminder',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18,color: Get.isDarkMode?Colors.grey[100]:darkGreyClr),),
              const SizedBox(height: 5,),
              Expanded(child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                decoration: BoxDecoration(
                  color: primaryClr,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Row(
                        children: const [
                          Icon(Icons.ac_unit,size: 25,color: Colors.white,),
                          SizedBox(width: 20,),
                          Text("Title",style: TextStyle(color: Colors.white,fontSize: 25),)
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(_payLoad.split('|')[0],style: const TextStyle(color: Colors.white),),
                      const SizedBox(height: 20,),
                      Row(
                        children: const [
                          Icon(Icons.description,size: 25,color: Colors.white,),
                          SizedBox(width: 20,),
                          Text("Description",style: TextStyle(color: Colors.white,fontSize: 25),)
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(_payLoad.split('|')[1],style: const TextStyle(color: Colors.white),textAlign: TextAlign.justify,),
                      const SizedBox(height: 20,),
                      Row(
                        children: const [
                          Icon(Icons.calendar_today_outlined,size: 25,color: Colors.white,),
                          SizedBox(width: 20,),
                          Text("Date",style: TextStyle(color: Colors.white,fontSize: 25),)
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(_payLoad.split('|')[2],style: const TextStyle(color: Colors.white),textAlign: TextAlign.justify,),
                    ],
                  ),
                ),
              ))
            ],
          ),
      ),
    );
  }
}
