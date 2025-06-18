import 'package:employee_management/screens/employee_outsource_edit/viewmodels/employee_outsource_edit_screen_viewmodel.dart';

import 'package:get/get.dart';

class EmployeeOutsourceEditScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeOutsourceEditScreenViewModel(), fenix: true);
  }
}
