import 'package:employee_management/screens/employee_outsource_list/viewmodels/employee_outsource_list_screen_viewmodel.dart';
import 'package:get/get.dart';

class EmployeeOutsourceListsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmployeeOutsourceListsScreenViewModel(), fenix: true);
  }
}
