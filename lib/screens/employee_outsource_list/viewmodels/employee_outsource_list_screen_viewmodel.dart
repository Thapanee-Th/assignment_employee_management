import 'package:employee_management/models/employee_outsource.dart';
import 'package:employee_management/routes/app_pages.dart';
import 'package:employee_management/services/employee_outsource_service.dart';

import 'package:get/get.dart';
import '../../../models/employee.dart';

class EmployeeOutsourceListsScreenViewModel extends GetxController {
  final EmployeeOutsourceService _employeeService = EmployeeOutsourceService();

  // Observable variables
  final RxList<EmployeeOutsource> employees = <EmployeeOutsource>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedDepartment = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadEmployees();
  }

  // Load all employees
  Future<void> loadEmployees() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final List<EmployeeOutsource> employeeList =
          await _employeeService.getAllEmployees();
      employees.assignAll(employeeList);
    } catch (e) {
      errorMessage.value = 'Failed to load employees: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Add new employee
  Future<bool> addEmployee(EmployeeOutsource employee) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final bool success = await _employeeService.addEmployee(employee);
      if (success) {
        employees.add(employee);
        Get.snackbar(
          'Success',
          'Employee added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        errorMessage.value = 'Failed to add employee';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error adding employee: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  onAddEmployee() async {
    final result = await Get.toNamed(Routes.employeeOutsourceAdd);
    if (result != null && result is Map && result['success'] == true) {
      loadEmployees();
      Get.snackbar(
        'Success',
        'Employee added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Update employee
  Future<bool> updateEmployee(EmployeeOutsource employee) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final bool success = await _employeeService.updateEmployee(employee);
      if (success) {
        final int index = employees.indexWhere((emp) => emp.id == employee.id);
        if (index != -1) {
          employees[index] = employee;
        }
        Get.snackbar(
          'Success',
          'Employee updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        errorMessage.value = 'Failed to update employee';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error updating employee: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete employee
  Future<bool> deleteEmployee(String employeeId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final bool success = await _employeeService.deleteEmployee(employeeId);
      if (success) {
        employees.removeWhere((emp) => emp.id == employeeId);

        Get.snackbar(
          'Success',
          'Employee deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        errorMessage.value = 'Failed to delete employee';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error deleting employee: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Get employee by ID
  Employee? getEmployeeById(String employeeId) {
    try {
      return employees.firstWhere((emp) => emp.id == employeeId);
    } catch (e) {
      return null;
    }
  }

  // Clear search and filters
  void clearFilters() {
    searchQuery.value = '';
    selectedDepartment.value = '';
    loadEmployees();
  }

  getDetail(EmployeeOutsource employee) async {
    final result = await Get.toNamed(
      Routes.employeeOutsourceDetail,
      arguments: employee,
    );

    if (result != null && result is Map && result['success'] == true) {
      loadEmployees();
    }
  }

  // Get filtered employees count
  int get employeesCount => employees.length;
}
