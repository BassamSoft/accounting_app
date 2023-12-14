// import 'package:accounting_app/data/database.dart';
// import 'package:get/get.dart';

// class ViewCategoriesController extends GetxController {
//   List<Map> categories = [];

//   DatabaseSql databaseSql = DatabaseSql();
//   var categoriesCount;
//   var accountCount;
//   // ignore: body_might_complete_normally_nullable
//   Future<List<Map>?> readDatauser() async {
//     categories.clear();
//     update();
//     List<Map> respone =
//         await databaseSql.readData("SELECT * FROM 'categories'");
//     // ignore: avoid_print
//     categories.addAll(respone);
//     // ignore: avoid_print
//     print("$respone");
//     update();
//   }

//   deletCategories() async {
//     int respone = await databaseSql.deleteData("DELETE FROM 'categories'");
//     // ignore: avoid_print
//     print("$respone");
//     update();
//   }

//   deletDatabase() async {
//     await databaseSql.deleteMyDatabase();
//   }

//   @override
//   void onInit() {
//     readDatauser();

//     super.onInit();
//   }
// }
