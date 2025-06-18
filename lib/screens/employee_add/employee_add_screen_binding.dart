import 'package:employee_management/screens/employee_add/viewmodels/employee_add_screen_viewmodel.dart';

import 'package:get/get.dart';

class EmployeeAddScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeAddScreenViewModel(), fenix: true);
  }
}
