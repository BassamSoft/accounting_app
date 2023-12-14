import 'package:accounting_app/controller/addcategories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/color.dart';
import '../widget/bottombarCategories.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddCategoriesController controller = Get.put(AddCategoriesController());
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controller.insertDataAccount();
      //     Get.snackbar("success", "account add succssefly");
      //   },
      //   child: const Icon(Icons.add),
      // ),
      appBar: AppBar(
        foregroundColor: AppColor.acsentColor,
        backgroundColor: Colors.grey[200],
        title: const Text(
          "  دفتر حسابي",
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
              controller.readDataCategories();
            },
            child: const Icon(Icons.delete, color: AppColor.acsentColor),
          )
        ],
      ),
      bottomNavigationBar: BottomBarCategories(
        total: "الاجمالي",
        totalPrice: "${1000}",
        onPressed: () {},
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    Positioned(
                      top: 100,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: const CircleAvatar(
                                  backgroundColor: AppColor.acsentColor,
                                  radius:
                                      40, // Adjust the radius value as desired
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'دفتر الحسابات',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.6),
                                  fontFamily: "NotoKufiArabic",
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 580,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    ListTile(
                      onTap: () {},
                      trailing: const Icon(
                        Icons.category_outlined,
                        color: AppColor.acsentColor,
                      ),
                      title: const Text(
                        "الاقسام",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'NotoKufiArabic'),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      trailing: const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: AppColor.acsentColor,
                      ),
                      title: const Text(
                        "الحسابات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'NotoKufiArabic'),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed("/currencyScreen");
                      },
                      trailing: const Icon(
                        Icons.currency_exchange,
                        color: AppColor.acsentColor,
                      ),
                      title: const Text(
                        "العملات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'NotoKufiArabic'),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      trailing: const Icon(
                        Icons.add_to_drive,
                        color: AppColor.acsentColor,
                      ),
                      title: const Text(
                        "جوجل درايف",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'NotoKufiArabic'),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed("/backupscreen");
                      },
                      trailing: const Icon(
                        Icons.backup_outlined,
                        color: AppColor.acsentColor,
                      ),
                      title: const Text(
                        " نسخ احتياطي",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'NotoKufiArabic'),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      trailing: const Icon(
                        Icons.file_upload,
                        color: AppColor.acsentColor,
                      ),
                      title: const Text(
                        "  تقارير",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'NotoKufiArabic'),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      trailing: const Icon(
                        Icons.settings,
                        color: AppColor.acsentColor,
                      ),
                      title: const Text(
                        " الاعدادت",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'NotoKufiArabic'),
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),

      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: GetBuilder<AddCategoriesController>(builder: (controller) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed("/CustomerScreen", arguments: {
                              "accounts": controller.categories[index]
                                  ['categories_id']
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: AppColor.acsentColor, width: 1.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Icon(
                                    Icons.account_box,
                                    color: AppColor.acsentColor,
                                    size: 60,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${controller.categories[index]['categories_name']}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontFamily: "NotoKufiArabic",
                                  ),
                                ),
                                const Text(
                                  "${0}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.acsentColor,
                                    fontFamily: "NotoKufiArabic",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }),
          ),
        ),
      ),
    );
  }
}
