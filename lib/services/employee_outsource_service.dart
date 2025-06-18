import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:employee_management/models/employee_outsource.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeOutsourceService {
  static const String _apiEmployee =
      'https://fake-json-api.mock.beeceptor.com/users';
  final Dio _dio = Dio();

  static const String _storageKey = 'employeesOutsource';

  // Get all employees
  Future<List<EmployeeOutsource>> getAllEmployees() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? employeesJson = prefs.getString(_storageKey);
      List<EmployeeOutsource> employees = [];
      debugPrint('employeesJson: $employeesJson');

      if (employeesJson == null ||
          employeesJson.isEmpty ||
          employeesJson == '[]') {
        final response = await _dio.get(_apiEmployee);

        if (response.statusCode == 200) {
          List<dynamic> data = response.data;
          employees =
              data.map((json) => EmployeeOutsource.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load employees from API');
        }

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
        employees =
            employeeMaps.map((map) => EmployeeOutsource.fromJson(map)).toList();
      }

      return employees;
    } catch (e) {
      debugPrint('Error getting employees: $e');
      return [];
    }
  }

  // Add new employee
  Future<bool> addEmployee(EmployeeOutsource employee) async {
    try {
      final List<EmployeeOutsource> employees = await getAllEmployees();
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
  Future<bool> updateEmployee(EmployeeOutsource employee) async {
    try {
      final List<EmployeeOutsource> employees = await getAllEmployees();
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
      final List<EmployeeOutsource> employees = await getAllEmployees();
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
  Future<EmployeeOutsource?> getEmployeeById(String employeeId) async {
    try {
      final List<EmployeeOutsource> employees = await getAllEmployees();
      return employees.firstWhere((emp) => emp.id == employeeId);
    } catch (e) {
      debugPrint('Error getting employee by ID: $e');
      return null;
    }
  }
}
