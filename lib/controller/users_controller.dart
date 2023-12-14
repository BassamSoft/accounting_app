import 'package:accounting_app/data/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UsersControllers extends GetxController {
  DatabaseSql? databaseSql = DatabaseSql();

  List<Map> users = [];
  List<Map> accounts = [];

  TextEditingController? catName;

  insertDatauser() async {
    int respone = await databaseSql!.insertData('''
INSERT INTO 'users' ('usersname' ,'usersemail')
VALUES('بسام' ,'mohammd @gmail.com')
''');
    // ignore: avoid_print
    print(respone);
  }

  insertDataAccount() async {
    int respone = await databaseSql!.insertData('''
INSERT INTO 'accounts' ( 'accountName', 'accountBalance')
      VALUES ('bassamsoft'  , '1000')
''');
    // ignore: avoid_print
    print(respone);
  }

  Future<List<Map>?> readDatauser() async {
    List<Map> respone = await databaseSql!.readData("SELECT * FROM 'users'");
    // ignore: avoid_print
    users.addAll(respone);
    print("$respone");
    return null;
  }

  Future<List<Map>?> readDataAccounts() async {
    List<Map> respone = await databaseSql!.readData("SELECT * FROM 'account'");
    // ignore: avoid_print
    accounts.addAll(respone);
    print("$respone");
    update();
    return null;
  }

  deleteUser() async {
    int respone =
        await databaseSql!.deleteData("DELETE FROM 'users' WHERE usersid = 1");
    // ignore: avoid_print
    print("$respone");
  }

  updateDataUser() async {
    int respone = await databaseSql!.updateData(
        "UPDATE 'users' SET 'usersname' ='ali ali ' WHERE usersid = 2");
    // ignore: avoid_print
    print("$respone");
  }

  deletDatabase() async {
    await databaseSql!.deleteMyDatabase();
  }

  @override
  void onInit() {
    catName = TextEditingController();
    readDataAccounts();
    super.onInit();
  }
}
