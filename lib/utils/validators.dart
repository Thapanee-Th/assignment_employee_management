import 'package:flutter/material.dart';

class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Name validation
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    if (value.length > 50) {
      return 'Name must be less than 50 characters';
    }

    return null;
  }

  // Phone number validation
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }

    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    if (value.replaceAll(RegExp(r'[\s\-\(\)]'), '').length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    return null;
  }

  // Salary validation
  static String? validateSalary(String? value) {
    if (value == null || value.isEmpty) {
      return 'Salary is required';
    }

    final salary = double.tryParse(value);
    if (salary == null) {
      return 'Please enter a valid salary amount';
    }

    if (salary < 0) {
      return 'Salary cannot be negative';
    }

    if (salary > 1000000) {
      return 'Salary seems too high. Please verify the amount';
    }

    return null;
  }

  // Position validation
  static String? validatePosition(String? value) {
    if (value == null || value.isEmpty) {
      return 'Position is required';
    }

    if (value.length < 2) {
      return 'Position must be at least 2 characters long';
    }

    return null;
  }

  // Department validation
  static String? validateDepartment(String? value) {
    if (value == null || value.isEmpty) {
      return 'Department is required';
    }

    if (value.length < 2) {
      return 'Department must be at least 2 characters long';
    }

    return null;
  }

  // Address validation
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Address is optional
    }

    if (value.length < 5) {
      return 'Address must be at least 5 characters long';
    }

    if (value.length > 200) {
      return 'Address must be less than 200 characters';
    }

    return null;
  }

  // Date validation
  static String? validateDate(DateTime? value) {
    if (value == null) {
      return 'Date is required';
    }

    final now = DateTime.now();
    if (value.isAfter(now)) {
      return 'Hire date cannot be in the future';
    }

    if (value.isBefore(DateTime(1900))) {
      return 'Hire date seems too old';
    }

    return null;
  }

  // Form validation helper
  static bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState != null) {
      return formKey.currentState!.validate();
    }
    return false;
  }

  // Save form helper
  static void saveForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState != null) {
      formKey.currentState!.save();
    }
  }
}
