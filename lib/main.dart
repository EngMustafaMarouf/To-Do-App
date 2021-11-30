import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do/services/notification_services.dart';
import 'package:to_do/services/theme_services.dart';
import 'package:to_do/ui/pages/home_page.dart';
import 'package:to_do/ui/pages/notification_page.dart';
import 'package:to_do/ui/themes.dart';

import 'db/db_helper.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();  //initialization and creating a data base
  await GetStorage.init();  //to load Data from storage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeServices().theme,
      theme: Themes.light,
      darkTheme: Themes.dark,
      home: const HomePage(),
    );
  }
}


