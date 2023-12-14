// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/color.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          backgroundColor: AppColor.acsentColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          foregroundColor: AppColor.acsentColor,
          backgroundColor: Colors.grey[200],
          title: const Text(
            "العـمــلات",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppColor.mainFont,
              color: Colors.black,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Get.snackbar("success", "database remove successfly");
              },
              child: const Icon(Icons.delete, color: AppColor.acsentColor),
            )
          ],
        ),
        body: Center(
            child: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Card(
                        color: Colors.grey[200],
                        child: ListTile(
                          title: Text(
                            "ريال يمني",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.black.withOpacity(0.8),
                              fontFamily: "NotoKufiArabic",
                            ),
                          ),
                          trailing: Text(
                            "2",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.black.withOpacity(0.8),
                              fontFamily: "NotoKufiArabic",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        color: Colors.grey[200],
                        child: ListTile(
                          title: Text(
                            "سعودي ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.black.withOpacity(0.8),
                              fontFamily: "NotoKufiArabic",
                            ),
                          ),
                          trailing: Text(
                            "2",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Colors.black.withOpacity(0.8),
                              fontFamily: "NotoKufiArabic",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
