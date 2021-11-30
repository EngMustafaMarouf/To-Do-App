import 'package:flutter/material.dart';
import 'package:to_do/ui/themes.dart';


class MyButton extends StatelessWidget {
  const MyButton({Key? key,required this.label,required this.onTap}) : super(key: key);

  final String label;
  final Function() onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 100,
        decoration: BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: Text(label,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
      ),
    );
  }
}
