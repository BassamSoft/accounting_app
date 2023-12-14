import 'package:accounting_app/controller/addcategories_controller.dart';
import 'package:accounting_app/data/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color.dart';

class AccountViewController extends GetxController {
  List<Map> accounts = [];

  DatabaseSql databaseSql = DatabaseSql();

  AddCategoriesController controllerCat = Get.put(AddCategoriesController());

  int? categoryId;

  TextEditingController? accountName;
  TextEditingController? accountPhone;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  insertAccount() async {
    if (formstate.currentState!.validate()) {
      update();
      int respone = await databaseSql.insertData('''
INSERT INTO 'account' ( 'account_name' ,'account_cat' ,'account_Phone')
      VALUES ('${accountName!.text}' ,'$categoryId' ,'${accountPhone!.text}')
''');
      Get.snackbar("success", " تمت الاضافه بنجاح");
      print(respone);

      update();
      accountDataList();
    } else {
      return null;
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<List<Map>?> accountDataList() async {
    accounts.clear();
    update();
    List<Map> respone = await databaseSql.readDataByid(
        'SELECT * FROM accountdata WHERE categories_id = ?', categoryId!);
    // ignore: avoid_print
    accounts.addAll(respone);
    // ignore: avoid_print
    print("$respone");
    update();
  }

  deletDatabase() async {
    await databaseSql.deleteMyDatabase();
  }

  @override
  void onInit() {
    initial();
    super.onInit();
  }

  deleteaccount() async {
    int respone = await databaseSql.deleteData("DELETE FROM 'account'");
    // ignore: avoid_print
    print("$respone");
    update();
  }

  initial() {
    categoryId = Get.arguments['accounts'];
    accountName = TextEditingController();
    accountPhone = TextEditingController();
    accountDataList();
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> AddAccountDialog(BuildContext context) {
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
                      " حساب جديد",
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
                  Form(
                    key: formstate,
                    child: Container(
                      height: 45,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: TextFormField(
                        controller: accountName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a account name';
                          }
                          return null;
                        },
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
                          hintText: 'اسم الحساب',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[300], // لون الخلفية
                        ), // ارتفاع العنصر
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              ' العمله', // نص العملة
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10), // المسافة بين النص والأيقونة
                            IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColor.acsentColor,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Reduce spacing
                  Container(
                    height: 45,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      controller: accountPhone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a account Phone';
                        }
                        return null;
                      },
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
                        hintText: ' رقم الهاتف',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () {},
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
                          insertAccount();
                          Navigator.of(context).pop();

                          // insertOPertionsAccount();
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
