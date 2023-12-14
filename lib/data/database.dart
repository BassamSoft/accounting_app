import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseSql {
  static Database? _db;
//لفحص هل تم عمل قاعده اليبانات مرة واحده فقط بدل من كل مرة
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  intialDatabase() async {
    // تحديد مسار قاعده اليبيانات
    String pathdatabase = await getDatabasesPath();
    // ربط المسار باسم قاعده اليبانات
    String path = join(pathdatabase, 'account.db');
    // انشاء قاعده البيانات وتحديد  الاصدار الخاص فيها
    Database mydatabse = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydatabse;
  }

  _onUpgrade(Database db, int oldVersoin, int newVersoin) async {
    // Batch batch = db.batch();
    // batch.execute('''
    //   CREATE VIEW opertionsAccount AS
    // SELECT
    //     account.*,
    //     opertaions.*,
    //     SUM(
    //         CASE
    //             WHEN opertaions.opert_status = 0 THEN opertaions.opert_amount
    //             WHEN opertaions.opert_status = 1 THEN -opertaions.opert_amount
    //         END
    //     ) OVER (PARTITION BY account.account_id ORDER BY opertaions.opert_id) AS account_balance
    // FROM
    //     opertaions
    //     LEFT JOIN account ON account.account_id = opertaions.opert_account
    // WHERE
    //     account.account_id = opertaions.opert_account

    //     ''');
    // await batch.commit();
    // ignore: avoid_print
    print("onUpgrade DataBase success ===============");
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
          CREATE TABLE account (
            account_id INTEGER PRIMARY KEY AUTOINCREMENT,
            account_name TEXT NOT NULL,
            account_created TEXT NOT NULL DEFAULT (datetime('now','localtime')),
            account_cat INTEGER NOT NULL,
            account_Phone INTEGER NOT NULL

          )
        ''');

    batch.execute('''
          CREATE TABLE categories (
            categories_id INTEGER PRIMARY KEY AUTOINCREMENT,
            categories_name TEXT NOT NULL

          )
        ''');

    batch.execute('''
          CREATE TABLE opertaions (
            opert_id INTEGER PRIMARY KEY AUTOINCREMENT,
            opert_detail TEXT NOT NULL,
            opert_amount INTEGER NOT NULL,
            opert_deta TEXT DEFAULT (datetime('now','localtime')),
            opert_status INTEGER NOT NULL DEFAULT 0,
            opert_account INTEGER NOT NULL
          )
        ''');

    batch.execute('''
          CREATE TABLE users (
            users_id INTEGER PRIMARY KEY AUTOINCREMENT,
            users_name TEXT NOT NULL,
            users_email TEXT NOT NULL,
            users_phone TEXT NOT NULL
          )
        ''');
    batch.execute('''
          CREATE VIEW IF NOT EXISTS accountdata AS
          SELECT
              account.*,
              categories.categories_id,
              COUNT(opertaions.opert_id) AS opert_count,
              SUM(
                  CASE
                      WHEN opertaions.opert_status = 0 THEN opertaions.opert_amount
                      WHEN opertaions.opert_status = 1 THEN -opertaions.opert_amount
                  END
              ) AS account_balance
          FROM
              account
              LEFT JOIN opertaions ON account.account_id = opertaions.opert_account
              LEFT JOIN categories ON account.account_cat = categories.categories_id
          GROUP BY account.account_id, categories.categories_id
        ''');
    batch.execute('''
       CREATE VIEW IF NOT EXISTS opertionsaccount AS
SELECT
    account.*,
    opertaions.*,
    (
        SELECT SUM(
            CASE
                WHEN o.opert_status = 0 THEN o.opert_amount
                WHEN o.opert_status = 1 THEN -o.opert_amount
            END
        )
        FROM opertaions o
        WHERE o.opert_account = account.account_id AND o.opert_id <= opertaions.opert_id
    ) AS account_balance
FROM
    opertaions
    LEFT JOIN account ON account.account_id = opertaions.opert_account
WHERE
    account.account_id = opertaions.opert_account;
        ''');
    await batch.commit();
    // ignore: avoid_print
    print("onCreate DataBase success ===============");
  }

//read data from database
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> respone = await mydb!.rawQuery(sql);
    return respone;
  }

//read data by id
  readDataByid(String sql, int id) async {
    Database? mydb = await db;
    List<Map> respone = await mydb!.rawQuery(sql, [id]);
    return respone;
  }

  //insert data in database
  insertData(String sql) async {
    Database? mydb = await db;
    int respone = await mydb!.rawInsert(sql);
    return respone;
  }

  //update data in database
  updateData(String sql) async {
    Database? mydb = await db;
    int respone = await mydb!.rawUpdate(sql);
    return respone;
  }

  //delete data in database
  deleteData(String sql) async {
    Database? mydb = await db;
    int respone = await mydb!.rawDelete(sql);
    return respone;
  }

  deleteMyDatabase() async {
    // تحديد مسار قاعده اليبيانات
    String pathdatabase = await getDatabasesPath();
    // ربط المسار باسم قاعده اليبانات
    String? path = join(pathdatabase, 'account.db');

    await deleteDatabase(path);
  }

  // Backup the database
  Future<void> backupDatabase([String? filePath]) async {
    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = await getDatabasesPath();
    String databaseName = 'account.db';
    String backupPath = '${appDocDir.path}/$databaseName';

    File databaseFile = File('$databasePath/$databaseName');
    File backupFile = File(backupPath);

    // Check if the database file exists
    if (await databaseFile.exists()) {
      // Delete the existing backup file, if any
      if (await backupFile.exists()) {
        await backupFile.delete();
      }
      // Create a new backup file
      await databaseFile.copy(backupPath);
      print('Database backup created successfully: $backupPath');
    } else {
      print('Database file not found.');
    }
  }

  // Restore the database
  Future<void> restoreDatabase() async {
    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = await getDatabasesPath();
    String databaseName = 'account.db';
    String backupPath = '${appDocDir.path}/$databaseName';

    File databaseFile = File('$databasePath/$databaseName');
    File backupFile = File(backupPath);

    // Check if the backup file exists
    if (await backupFile.exists()) {
      // Delete the existing database file, if any
      if (await databaseFile.exists()) {
        await databaseFile.delete();
      }
      // Restore the backup file
      await backupFile.copy('$databasePath/$databaseName');
      print('Database restored successfully.');
    } else {
      print('Backup file not found.');
    }
  }
}
