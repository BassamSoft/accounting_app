// ignore: file_names
import 'package:accounting_app/controller/backup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/database.dart';

// ignore: use_key_in_widget_constructors
class BackupScreen extends StatelessWidget {
  final BackupController backupController = Get.find<BackupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                DatabaseSql? databaseSql = Get.find<DatabaseSql>();
                await databaseSql.backupDatabase();
                Get.snackbar("success", "Backup database successfly");
              },
              child: const Text('Create Backup'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                DatabaseSql? databaseSql = Get.find<DatabaseSql>();
                await databaseSql.restoreDatabase();
                Get.snackbar("success", "Restore database successfly");
              },
              child: const Text('Restore from Backup'),
            ),
          ],
        ),
      ),
    );
  }
}
