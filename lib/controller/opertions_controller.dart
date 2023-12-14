import 'package:accounting_app/data/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color.dart';

class OpertionsController extends GetxController {
  DatabaseSql databaseSql = DatabaseSql();
  int? accountid;
  List<Map> opertions = [];
  List<Map> opertionsDetials = [];

  var opertStatus0Total;
  var opertStatus1Total;
  var accountBalance;

  int? selectedRadio = 0;
  dynamic accountName;
  TextEditingController? amountOpertion;
  TextEditingController? detialsOpertions;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  insertOpertion() async {
    if (formstate.currentState!.validate()) {
      update();
      int respone = await databaseSql.insertData('''
INSERT INTO 'opertaions' ( 'opert_detail' ,'opert_amount' ,'opert_status' ,'opert_account')
      VALUES ('${detialsOpertions!.text}' ,'${amountOpertion!.text}' ,'$selectedRadio' ,'$accountid')
''');
      Get.snackbar("success", " تمت الاضافه بنجاح");
      print(amountOpertion!.text);
      print(detialsOpertions!.text);
      print(selectedRadio);
      print("------------------------------ $accountid");

      // ignore: avoid_print
      print(respone);

      update();
      readOpertionAccount();
      getDetialsaccount();
    }
  }

  intialData() {
    accountid = Get.arguments['accountid'];
    accountName = readAccountByid();
    amountOpertion = TextEditingController();
    detialsOpertions = TextEditingController();
    readOpertionAccount();
    getDetialsaccount();
  }

// WHERE opert_account = ?', accountid!
  readOpertionAccount() async {
    opertions.clear();
    update();
    List<Map> respone = await databaseSql.readDataByid(
        'SELECT * FROM opertionsaccount WHERE opert_account = ? ', accountid!);
    // ignore: avoid_print
    opertions.addAll(respone);
    // ignore: avoid_print
    print("$respone");
    update();
    return null;
  }

  getDetialsaccount() async {
    opertionsDetials.clear();
    update();

    List<Map> response2 = await databaseSql.readData('''
    SELECT
      SUM(CASE WHEN opert_status = 0 THEN opert_amount ELSE 0 END) AS opertStatus0Total,
      SUM(CASE WHEN opert_status = 1 THEN opert_amount ELSE 0 END) AS opertStatus1Total,
      account_balance
    FROM
      opertionsaccount
  ''');

    if (response2.isNotEmpty) {
      var result = response2[0];
      opertStatus0Total = result['opertStatus0Total'];
      opertStatus1Total = result['opertStatus1Total'];
      accountBalance = result['account_balance'];

      // Use the variables as needed
      // ...

      update();
    }
  }

  readAccountByid() async {
    opertions.clear();
    update();
    List<Map> response = await databaseSql.readDataByid(
        'SELECT * FROM account WHERE account_id = ?', accountid!);
    if (response.isNotEmpty) {
      // تعيين اسم الحساب في متغير واحد
      accountName = response.first['account_name']; // ignore: avoid_print
      // ignore: avoid_print
      print(accountName);
      // تحديث الواجهة إذا كانت مطلوبة
      update();
      return accountName;
    } else {
      return null;
    }
  }

  changValueRadio(int value) {
    selectedRadio = value;
    // ignore: avoid_print
    print(selectedRadio);
    update();
  }

  deleteOpertions() async {
    int respone = await databaseSql.deleteData("DELETE FROM 'opertaions'");
    // ignore: avoid_print
    print("$respone");
    update();
  }

  @override
  void onInit() {
    intialData();
    super.onInit();
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> AddOpertion(BuildContext context) {
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
              child: Form(
                key: formstate,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.acsentColor,
                      ),
                      child: const Text(
                        " عملية جديده  ",
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: TextFormField(
                        controller: null,
                        enabled: false, // تعيين الحقل غير قابل للتحرير
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
                          hintText: accountName,
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 160,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300], // لون الخلفية
                          ), // ارتفاع العنصر
                          child: TextFormField(
                            controller: amountOpertion,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a account Phone';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColor.acsentColor),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[200]!),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: '  المبلغ',
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                            onTap: () {},
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 5),
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
                      height: 100,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: TextFormField(
                        controller: detialsOpertions,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a account Phone';
                          }
                          return null;
                        },
                        maxLines: 3,
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
                          hintText: '   تفاصيل العمليه',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: GetBuilder<OpertionsController>(
                            builder: ((controller) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: controller.selectedRadio == 0,
                                      onChanged: (bool? value) {
                                        if (value != null && value) {
                                          controller.changValueRadio(0);
                                        }
                                      },
                                      activeColor: AppColor.acsentColor,
                                    ),
                                    const Text(
                                      'له',
                                      style: TextStyle(
                                        fontFamily: AppColor.mainFont,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Checkbox(
                                      value: controller.selectedRadio == 1,
                                      onChanged: (bool? value) {
                                        if (value != null && value) {
                                          controller.changValueRadio(1);
                                        }
                                      },
                                      activeColor: AppColor.acsentColor,
                                    ),
                                    const Text(
                                      'عليه',
                                      style: TextStyle(
                                        fontFamily: AppColor.mainFont,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                )))),
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
                            insertOpertion();
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
          ),
        );
      },
    );
  }
}
