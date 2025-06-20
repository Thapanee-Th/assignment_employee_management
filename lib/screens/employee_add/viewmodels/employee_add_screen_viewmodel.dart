import 'package:employee_management/services/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/employee.dart';
import 'package:uuid/uuid.dart';

class EmployeeAddScreenViewModel extends GetxController {
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
  final Uuid _uuid = Uuid();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  void saveEmployee() async {
    if (editFormKey.currentState!.validate()) {
      final emp = Employee(
        id: _uuid.v4(),
        name: nameController.text,
        email: emailController.text,
        position: positionController.text,
        phone: phoneController.text,
      );
      if (await _employeeService.addEmployee(emp)) {
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
