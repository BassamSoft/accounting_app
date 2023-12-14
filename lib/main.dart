import 'package:accounting_app/data/database.dart';
import 'package:accounting_app/utils/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/backup_controller.dart';

void main() {
  Get.put(DatabaseSql());
  Get.put(BackupController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      locale: const Locale("ar"),
      getPages: route,
    );
  }
}
