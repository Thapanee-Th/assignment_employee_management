import 'package:employee_management/screens/employee_outsource_detail/viewmodels/employee_outsource_detail_screen_viewmodel.dart';

import 'package:get/get.dart';

class EmployeeOutsourceDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeOutsourceDetailScreenViewModel(), fenix: true);
  }
}
