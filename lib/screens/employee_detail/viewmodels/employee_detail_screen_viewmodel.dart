import 'package:employee_management/routes/app_pages.dart';
import 'package:employee_management/services/employee_service.dart';
import 'package:flutter/material.dart';
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
    if (Get.arguments != null && Get.arguments is Employee) {
      employee.value = Get.arguments as Employee;
    } else if (Get.arguments != null &&
        Get.arguments is Map &&
        Get.arguments['employee'] is Map<String, dynamic>) {
      employee.value = Employee.fromJson(
        Get.arguments['employee'] as Map<String, dynamic>,
      );
    }
  }

  void editEmployee() async {
    final result = await Get.toNamed(
      Routes.employeeEdit,
      arguments: employee.value,
    );
    if (result != null && result is Map && result['success'] == true) {
      var emp =
          await _employeeService.getEmployeeById(employee.value.id) ??
          employee.value;
      debugPrint('Fetched employee for update: ${emp.toJson()}');
      employee.value.name = emp.name;
      employee.value.email = emp.email;
      employee.value.position = emp.position;
      employee.value.phone = emp.phone;
      employee.refresh();
      debugPrint(
        'Fetched employee.value for update: ${employee.value.toJson()}',
      );
      Get.snackbar(
        'Success',
        'Employee ${result['employeeName']} updated!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void deleteEmployee(BuildContext context) {
    Get.dialog(
      Builder(
        // Provides a BuildContext within the dialog
        builder: (dialogContext) {
          final theme = Theme.of(dialogContext);
          return AlertDialog(
            title: const Text('Delete Employee'),
            content: Text(
              'Are you sure you want to delete ${employee.value.name}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final result = await _employeeService.deleteEmployee(
                    employee.value.id,
                  );
                  debugPrint('Delete result: $result');

                  Get.back(); // Close dialog
                  Get.back(
                    result: {'success': true},
                  ); // Go back to previous screen
                  // Handle delete logic here
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          );
        },
      ),
    );
    // showDialog(
    //   context: context,
    //   builder:
    //       (context) => AlertDialog(
    //         title: const Text('Delete Employee'),
    //         content: Text(
    //           'Are you sure you want to delete ${employee.value.name}?',
    //         ),
    //         actions: [
    //           TextButton(
    //             onPressed: () => Navigator.pop(context),
    //             child: const Text('Cancel'),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context); // Close dialog
    //               Navigator.pop(context); // Go back to previous screen
    //               // Handle delete logic here
    //             },
    //             style: TextButton.styleFrom(foregroundColor: Colors.red),
    //             child: const Text('Delete'),
    //           ),
    //         ],
    //       ),
    // );
  }
}
