import 'package:accounting_app/controller/opertions_controller.dart';
import 'package:accounting_app/widget/bottombaopertions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/color.dart';

class OperationAccountView extends StatelessWidget {
  const OperationAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    OpertionsController controller = Get.put(OpertionsController());
    return Scaffold(
        appBar: AppBar(
          foregroundColor: AppColor.acsentColor,
          backgroundColor: Colors.grey[200],
          title: GetBuilder<OpertionsController>(builder: (controller) {
            return Text(
              "${controller.accountName}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppColor.mainFont,
                color: Colors.black,
                fontSize: 15,
              ),
              overflow: TextOverflow.ellipsis,
            );
          }),
          actions: [
            MaterialButton(
              onPressed: () {
                controller.deleteOpertions();
                Get.snackbar("success", "database remove successfly");
              },
              child: const Icon(Icons.picture_as_pdf_rounded,
                  color: AppColor.acsentColor),
            )
          ],
        ),
        bottomNavigationBar: BottomBarOpertions(
          total: "الاجمالي",
          totalPrice: "${1000}",
          onPressed: () {},
        ),
        body: GetBuilder<OpertionsController>(builder: (controller) {
          return controller.opertions.isEmpty
              ? const Center(
                  child: Text("لانوجد عمليات"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.opertions.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(right: 5, left: 5, top: 5),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Table(
                          defaultVerticalAlignment: TableCellVerticalAlignment
                              .middle, // Aligns text widgets vertically in the middle
                          columnWidths: const {
                            0: FlexColumnWidth(
                                1), // Adjusts the width of the first column
                            1: FlexColumnWidth(
                                5), // Adjusts the width of the second column
                            2: FlexColumnWidth(
                                1), // Adjusts the width of the third column
                            3: FlexColumnWidth(
                                1), // Adjusts the width of the fourth column
                          },
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment
                                      .middle, // Aligns text widgets vertically in the middle
                                  child: Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center, // Aligns text widgets horizontally in the center
                                      children: [
                                        const SizedBox(width: 5),
                                        Flexible(
                                          flex: 3,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Text(
                                                "${controller.opertions[index]['opert_amount']} ريال",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        AppColor.mainFont,
                                                    color: controller.opertions[
                                                                    index][
                                                                'opert_status'] ==
                                                            0
                                                        ? AppColor.MainColor
                                                        : AppColor.dangerColor,
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 13,
                                                    height: 2),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${controller.opertions[index]['opert_detail']}",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              fontFamily: AppColor.mainFont,
                                              color: Colors.black,
                                              fontSize: 12,
                                              height: 1.5,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 2,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              child: Text(
                                                "${controller.opertions[index]['account_balance']} ريال",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        AppColor.mainFont,
                                                    color: controller.opertions[
                                                                    index][
                                                                'opert_status'] ==
                                                            0
                                                        ? AppColor.MainColor
                                                        : AppColor.dangerColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    height: 2),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, right: 10),
                                            child: Text(
                                              "${controller.opertions[index]['opert_deta']}",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontFamily: AppColor.mainFont,
                                                color: AppColor.grey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
        }));
  }
}
