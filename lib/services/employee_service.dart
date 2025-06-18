import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/employee.dart';

class EmployeeService {
  static const String _storageKey = 'employees';

  // Get all employees
  Future<List<Employee>> getAllEmployees() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? employeesJson = prefs.getString(_storageKey);

      if (employeesJson == null || employeesJson.isEmpty) {
        return [];
      }

      final List<dynamic> employeesList = json.decode(employeesJson);
      return employeesList.map((json) => Employee.fromJson(json)).toList();
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
      return employees.firstWhere((emp) => emp.id == employeeId);
    } catch (e) {
      debugPrint('Error getting employee by ID: $e');
      return null;
    }
  }

  // Search employees
  Future<List<Employee>> searchEmployees(String query) async {
    try {
      final List<Employee> employees = await getAllEmployees();
      final String lowercaseQuery = query.toLowerCase();

      return employees
          .where(
            (emp) =>
                emp.name.toLowerCase().contains(lowercaseQuery) ||
                emp.email.toLowerCase().contains(lowercaseQuery) ||
                emp.position.toLowerCase().contains(lowercaseQuery),
          )
          .toList();
    } catch (e) {
      debugPrint('Error searching employees: $e');
      return [];
    }
  }
}
