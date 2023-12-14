import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/database.dart';

class BackupController extends GetxController {
  static const String backupTableName = 'backup_info';
  static const String backupColumnName = 'backup_date';

  DatabaseSql? databaseSql;

  // Create a backup of the database and store backup information
  Future<void> createBackup() async {
    await databaseSql!.backupDatabase();
    await _storeBackupInfo();
  }

  // Restore the database from the most recent backup
  Future<void> restoreFromBackup() async {
    String? backupPath = await _getLatestBackupPath();
    if (backupPath != null) {
      await databaseSql!.restoreDatabase();
      print('Database restored from backup: $backupPath');
    } else {
      print('No backup found.');
    }
  }

  // Store backup information in the database
  Future<void> _storeBackupInfo() async {
    Database? db = await databaseSql!.db;
    String backupDate = DateTime.now().toIso8601String();

    await db!.transaction((txn) async {
      await txn.execute('''
        CREATE TABLE IF NOT EXISTS $backupTableName (
          $backupColumnName TEXT PRIMARY KEY
        )
      ''');
      await txn.rawInsert(
          'INSERT INTO $backupTableName($backupColumnName) VALUES(?)',
          [backupDate]);
    });

    print('Backup information stored in the database.');
  }

  // Retrieve the path of the most recent backup
  Future<String?> _getLatestBackupPath() async {
    Database? db = await databaseSql!.db;

    List<Map<String, dynamic>> results = await db!.query(
      backupTableName,
      orderBy: '$backupColumnName DESC',
      limit: 1,
    );

    if (results.isNotEmpty) {
      String backupDate = results.first[backupColumnName];
      String databasePath = await getDatabasesPath();
      String databaseName = 'account.db';
      String backupPath =
          join(databasePath, 'backups', 'backup_$backupDate', databaseName);
      return backupPath;
    }

    return null;
  }
}
