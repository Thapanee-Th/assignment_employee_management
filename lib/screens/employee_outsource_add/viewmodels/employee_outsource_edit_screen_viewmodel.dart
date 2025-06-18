import 'package:employee_management/models/employee_outsource.dart';
import 'package:employee_management/services/employee_outsource_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeOutsourceEditScreenViewModel extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is EmployeeOutsource) {
      employee.value = Get.arguments as EmployeeOutsource;
      // Pre-fill the form fields with existing employee data
      nameController.text = employee.value!.name;
      emailController.text = employee.value!.email ?? '';
      phoneController.text = employee.value!.phone ?? '';
      companyController.text = employee.value!.company;
      usernameController.text = employee.value!.username;
      addressController.text = employee.value!.address;
      zipController.text = employee.value!.zip;
      stateController.text = employee.value!.state;
      countryController.text = employee.value!.country;
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
      final emp = EmployeeOutsource(
        id: employee.value!.id, // Keep the original ID
        name: nameController.text,
        email: emailController.text,

        phone: phoneController.text,
        company: employee.value!.company,
        address: employee.value!.address,
        state: employee.value!.state,
        country: employee.value!.country,
        zip: employee.value!.zip,
        username: employee.value!.username,
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
