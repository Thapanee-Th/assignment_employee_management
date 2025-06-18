import 'package:employee_management/screens/employee_detail/viewmodels/employee_detail_screen_viewmodel.dart';

import 'package:get/get.dart';

class EmployeeDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeDetailScreenViewModel(), fenix: true);
  }
}
