import 'package:accounting_app/controller/accountList_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color.dart';

class BottomBarAccount extends GetView<AccountViewController> {
  const BottomBarAccount(
      {super.key,
      required this.total,
      required this.totalPrice,
      this.onPressed});
  final String total;
  final String totalPrice;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.acsentColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: IconButton(
                              onPressed: () {
                                controller.AddAccountDialog(context);
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.acsentColor),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "له: ${100000}ريال",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "علية: ${134774}ريال",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.dangerColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              " الاجمالي : ${134774}ريال",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
