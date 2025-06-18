import 'package:employee_management/screens/employee_outsource_add/viewmodels/employee_outsource_add_screen_viewmodel.dart';
import 'package:get/get.dart';

class EmployeeOutsourceAddScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeOutsourceAddScreenViewModel(), fenix: true);
  }
}
