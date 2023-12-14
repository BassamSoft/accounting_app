// ignore_for_file: file_names

import 'package:accounting_app/controller/accountList_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/color.dart';
import '../widget/bottombaraccount.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AccountViewController controller = Get.put(AccountViewController());
    return Scaffold(
        appBar: AppBar(
          foregroundColor: AppColor.acsentColor,
          backgroundColor: Colors.grey[200],
          title: const Text(
            "  العـمــلاء ",
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
                controller.deletDatabase();
                Get.snackbar("success", "database remove successfly");
              },
              child: const Icon(Icons.delete, color: AppColor.acsentColor),
            )
          ],
        ),
        bottomNavigationBar: BottomBarAccount(
          total: "الاجمالي",
          totalPrice: "${1000}",
          onPressed: () {},
        ),
        body: Center(
          child: GetBuilder<AccountViewController>(builder: ((controller) {
            return ListView.builder(
              itemCount: controller.accounts.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed("/OperationAccountView", arguments: {
                      "accountid": controller.accounts[index]['account_id']
                    });
                  },
                  child: Card(
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      children: [
                                        const Flexible(
                                          flex: 2,
                                          child: IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              Icons.arrow_drop_up,
                                              size: 40,
                                              color: AppColor.MainColor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            "${controller.accounts[index]['account_name']}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: AppColor.mainFont,
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColor.MainColor,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                "${controller.accounts[index]['opert_count']}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        AppColor.mainFont,
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    height: 1.6),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Flexible(
                                          flex: 2,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 6.0),
                                            child: controller.accounts[index]
                                                        ['opert_count'] ==
                                                    0
                                                ? const Text(
                                                    "${0} ريال",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppColor.mainFont,
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                    ),
                                                  )
                                                : Text(
                                                    "${controller.accounts[index]['account_balance']} ريال",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          AppColor.mainFont,
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                );
              },
            );
          })),
        ));
  }
}
