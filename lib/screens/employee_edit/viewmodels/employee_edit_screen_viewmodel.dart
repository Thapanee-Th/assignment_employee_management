import 'package:employee_management/services/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/employee.dart';

class EmployeeEditScreenViewModel extends GetxController {
  final EmployeeService _employeeService = EmployeeService();

  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  // Use RxString for reactive updates, or simply TextEditingController
  // For pre-filling, TextEditingController is often more straightforward.
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController positionController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();

  // Rx variable to hold the employee being edited
  var employee = Rx<Employee?>(null);

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Employee) {
      employee.value = Get.arguments as Employee;
      // Pre-fill the form fields with existing employee data
      nameController.text = employee.value!.name;
      emailController.text = employee.value!.email ?? '';
      phoneController.text = employee.value!.phone ?? '';
      positionController.text = employee.value!.position ?? '';
    }
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  void saveEmployee() async {
    if (editFormKey.currentState!.validate()) {
      final emp = Employee(
        id: employee.value!.id, // Keep the original ID
        name: nameController.text,
        email: emailController.text,
        position: positionController.text,
        phone: phoneController.text,
      );
      if (await _employeeService.updateEmployee(emp)) {
        // Get.snackbar(
        //   'Success',
        //   'Employee ${employee.value!.name} updated!',
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
        // await Future.delayed(const Duration(seconds: 2));
        // Get.back();
        Get.back(result: {'success': true, 'employeeName': emp.name});
      } else {
        Get.snackbar(
          'Error',
          'Failed to update employee',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
