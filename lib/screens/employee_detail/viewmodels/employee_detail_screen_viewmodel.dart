import 'package:employee_management/services/employee_service.dart';
import 'package:get/get.dart';
import '../../../models/employee.dart';

class EmployeeDetailScreenViewModel extends GetxController {
  final EmployeeService _employeeService = EmployeeService();

  // Observable variables
  final Rx<Employee> employee =
      Employee(id: '', name: '', email: '', position: '', phone: '').obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedDepartment = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      employee.value = Employee.fromJson(Get.arguments?['employee']);
    }
  }
}
