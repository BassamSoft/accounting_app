import 'package:accounting_app/controller/addcategories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color.dart';

class BottomBarCategories extends GetView<AddCategoriesController> {
  const BottomBarCategories(
      {super.key,
      required this.total,
      required this.totalPrice,
      this.onPressed});
  final String total;
  final String totalPrice;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    AddCategoriesController controller = Get.put(AddCategoriesController());
    return GetBuilder<AddCategoriesController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.acsentColor,
                          ),
                          child: IconButton(
                            onPressed: () {
                              controller.addCategories(context);
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: [
                            const Text(
                              "الاقســام:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppColor.mainFont,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              " ${controller.categoriesCount}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "الحسابات:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: AppColor.mainFont,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              " ${controller.accountCount}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColor.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          ],
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
