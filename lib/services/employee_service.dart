import 'dart:convert';
import 'package:employee_management/services/json_asset_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/employee.dart';

class EmployeeService {
  final JsonAssetsService _jsonService = JsonAssetsService();
  static const String _storageKey = 'employees';

  // Get all employees
  Future<List<Employee>> getAllEmployees() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? employeesJson = prefs.getString(_storageKey);
      List<Employee> employees = [];
      debugPrint('employeesJson: $employeesJson');

      if (employeesJson == null ||
          employeesJson.isEmpty ||
          employeesJson == '[]') {
        employees = await _jsonService.loadJsonModelList<Employee>(
          'assets/data/employees.json',
          (json) => Employee.fromJson(json),
        );

        // 1. Convert List<Employee> to List<Map<String, dynamic>>
        List<Map<String, dynamic>> employeeMaps =
            employees.map((employee) => employee.toJson()).toList();
        // 2. Encode the List<Map<String, dynamic>> to a JSON string
        employeesJson = jsonEncode(employeeMaps);
        // 3. Save the JSON string to SharedPreferences
        await prefs.setString(_storageKey, employeesJson);
      } else {
        List<dynamic> employeeMaps = jsonDecode(employeesJson);

        //  Convert the List<dynamic> (of maps) to a List<Employee>
        employees = employeeMaps.map((map) => Employee.fromJson(map)).toList();
      }

      return employees;
    } catch (e) {
      debugPrint('Error getting employees: $e');
      return [];
    }
  }

  // Add new employee
  Future<bool> addEmployee(Employee employee) async {
    try {
      final List<Employee> employees = await getAllEmployees();
      employees.add(employee);

      final prefs = await SharedPreferences.getInstance();
      final String employeesJson = json.encode(
        employees.map((emp) => emp.toJson()).toList(),
      );

      return await prefs.setString(_storageKey, employeesJson);
    } catch (e) {
      debugPrint('Error adding employee: $e');
      return false;
    }
  }

  // Update employee
  Future<bool> updateEmployee(Employee employee) async {
    try {
      final List<Employee> employees = await getAllEmployees();
      final int index = employees.indexWhere((emp) => emp.id == employee.id);

      if (index != -1) {
        employees[index] = employee;

        final prefs = await SharedPreferences.getInstance();
        final String employeesJson = json.encode(
          employees.map((emp) => emp.toJson()).toList(),
        );

        return await prefs.setString(_storageKey, employeesJson);
      }
      return false;
    } catch (e) {
      debugPrint('Error updating employee: $e');
      return false;
    }
  }

  // Delete employee
  Future<bool> deleteEmployee(String employeeId) async {
    try {
      final List<Employee> employees = await getAllEmployees();
      employees.removeWhere((emp) => emp.id == employeeId);

      final prefs = await SharedPreferences.getInstance();
      final String employeesJson = json.encode(
        employees.map((emp) => emp.toJson()).toList(),
      );

      return await prefs.setString(_storageKey, employeesJson);
    } catch (e) {
      debugPrint('Error deleting employee: $e');
      return false;
    }
  }

  // Get employee by ID
  Future<Employee?> getEmployeeById(String employeeId) async {
    try {
      final List<Employee> employees = await getAllEmployees();
      var emp = employees.firstWhere((emp) => emp.id == employeeId);
      return emp;
    } catch (e) {
      debugPrint('Error getting employee by ID: $e');
      return null;
    }
  }
}
