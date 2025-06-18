import 'package:employee_management/screens/employee_list/viewmodels/employee_list_screen_viewmodel.dart';
import 'package:get/get.dart';

class EmployeeListsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeListsScreenViewModel(), fenix: true);
  }
}
