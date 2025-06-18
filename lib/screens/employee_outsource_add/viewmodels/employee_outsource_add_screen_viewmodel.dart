import 'package:employee_management/models/employee_outsource.dart';
import 'package:employee_management/services/employee_outsource_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class EmployeeOutsourceAddScreenViewModel extends GetxController {
  final EmployeeOutsourceService _employeeService = EmployeeOutsourceService();

  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  // Use RxString for reactive updates, or simply TextEditingController
  // For pre-filling, TextEditingController is often more straightforward.
  late TextEditingController nameController = TextEditingController();
  late TextEditingController companyController = TextEditingController();
  late TextEditingController usernameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController zipController = TextEditingController();
  late TextEditingController stateController = TextEditingController();
  late TextEditingController countryController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();

  // Rx variable to hold the employee being edited
  var employee = Rx<EmployeeOutsource?>(null);
  final Uuid _uuid = Uuid();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  void saveEmployee() async {
    if (editFormKey.currentState!.validate()) {
      final emp = EmployeeOutsource(
        id: _uuid.v4(),
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        company: companyController.text,
        address: addressController.text,
        state: stateController.text,
        country: countryController.text,
        zip: zipController.text,
        username: usernameController.text,
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
