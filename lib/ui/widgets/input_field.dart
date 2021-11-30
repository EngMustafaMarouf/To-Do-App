import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/ui/size_config.dart';

import '../themes.dart';

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.function,
  }) : super(key: key);

  final String title;
  final String hint;
  TextEditingController? controller;
  Widget? widget;
  Function? function;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth,

        child: TextFormField(
            controller: controller,
            readOnly: widget != null? true:false,
            autofocus: false,
            cursorColor: Get.isDarkMode?Colors.white:Colors.black12,
            style: subTitleStyle,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: subTitleStyle,
              contentPadding: const  EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1,color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: widget,
            ),
          ),
    );
  }
}
