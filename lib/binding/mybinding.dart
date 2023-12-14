import 'package:get/get.dart';

import '../controller/backup_controller.dart';
import '../data/database.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DatabaseSql());
    Get.put(BackupController());
  }
}
