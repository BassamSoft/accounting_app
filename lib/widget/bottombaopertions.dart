import 'package:accounting_app/controller/opertions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color.dart';

class BottomBarOpertions extends GetView<OpertionsController> {
  const BottomBarOpertions(
      {super.key,
      required this.total,
      required this.totalPrice,
      this.onPressed});
  final String total;
  final String totalPrice;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    OpertionsController controller = Get.put(OpertionsController());
    return GetBuilder<OpertionsController>(builder: (controller) {
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
                                  controller.AddOpertion(context);
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
                                children: [
                                  Text(
                                    "له: ${controller.opertStatus0Total}ريال",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "علية: ${controller.opertStatus1Total}ريال",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: AppColor.dangerColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                " الاجمالي : ${controller.accountBalance}ريال",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
    });
  }
}
