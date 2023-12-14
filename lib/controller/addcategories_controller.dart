import 'package:accounting_app/data/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color.dart';

class AddCategoriesController extends GetxController {
  DatabaseSql? databaseSql = DatabaseSql();

  TextEditingController? catName;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  List<Map> categories = [];

  var categoriesCount;
  var accountCount;

  initial() {
    catName = TextEditingController();
    getCounts();
  }

  insertCategories() async {
    if (formstate.currentState!.validate()) {
      update();
      int respone = await databaseSql!.insertData('''
INSERT INTO 'categories' ( 'categories_name')
      VALUES ( '${catName!.text}')
''');
      // Get.snackbar("success", " تمت الاضافه بنجاح");
      readDataCategories();
      getCounts();
      // ignore: avoid_print
      print(respone);

      update();
    } else {
      return null;
    }
  }

  Future<Map<String, int>> getCounts() async {
    final db = databaseSql;

    final subquery1 = await db!
        .readData('SELECT COUNT(categories_id) AS cateCount FROM categories');
    final subquery2 = await db
        .readData('SELECT COUNT(account_id) AS accountCount FROM account');

    categoriesCount = subquery1.first['cateCount'] as int;
    accountCount = subquery2.first['accountCount'] as int;
    print(categoriesCount);
    print(accountCount);
    update();
    readDataCategories();

    return {'cateCount': categoriesCount, 'accountCount': accountCount};
  }

  // ignore: body_might_complete_normally_nullable
  Future<List<Map>?> readDataCategories() async {
    categories.clear();
    update();
    List<Map> respone =
        await databaseSql!.readData("SELECT * FROM 'categories'");
    // ignore: avoid_print
    categories.addAll(respone);
    // ignore: avoid_print
    print("$respone");
    update();
  }

  deletCategories() async {
    int respone = await databaseSql!.deleteData("DELETE FROM 'categories'");
    // ignore: avoid_print
    print("$respone");
    update();
  }

  deletDatabase() async {
    await databaseSql!.deleteMyDatabase();
  }

  @override
  void onInit() {
    readDataCategories();
    initial();
    super.onInit();
  }

  Future<dynamic> addCategories(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: 400,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.acsentColor,
                    ),
                    child: const Text(
                      " تصنيف  جديد",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppColor.mainFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Reduce spacing
                  Container(
                    height: 45,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Form(
                      key: formstate,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a category name';
                          }
                          return null;
                        },
                        controller: catName,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColor.acsentColor),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]!),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          hintText: 'اسم  القسم',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.acsentColor),
                        ),
                        child: const Text(
                          ' حفظ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppColor.mainFont,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {
                          // Add logic for adding the data
                          insertCategories();
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(width: 20), // Reduce spacing

                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.acsentColor),
                        ),
                        child: const Text(
                          ' الغاء',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppColor.mainFont,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {
                          // Add logic for adding the data
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Reduce spacing
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
