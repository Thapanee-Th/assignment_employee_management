import 'package:employee_management/screens/employee_edit/viewmodels/employee_edit_screen_viewmodel.dart';

import 'package:get/get.dart';

class EmployeeEditScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeEditScreenViewModel(), fenix: true);
  }
}
