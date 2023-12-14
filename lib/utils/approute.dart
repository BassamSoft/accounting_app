import 'package:accounting_app/screen/accountScreen.dart';
import 'package:accounting_app/screen/currencyscreen.dart';
import 'package:accounting_app/screen/loockscreen.dart';
import 'package:get/get.dart';

import '../screen/backupScreen.dart';
import '../screen/operationscreen.dart';

List<GetPage<dynamic>> route = [
  GetPage(name: "/", page: () => const LockScreen()),
  // GetPage(name: "/", page: () => const RadioButtonState()),

  GetPage(name: "/CustomerScreen", page: () => const CustomerScreen()),
  GetPage(
      name: "/OperationAccountView", page: () => const OperationAccountView()),
  GetPage(name: "/currencyScreen", page: () => const CurrencyScreen()),
  GetPage(name: "/backupscreen", page: () => BackupScreen()),
];
