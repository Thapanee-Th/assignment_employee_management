import 'package:employee_management/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Employee Edit Page (Placeholder)
class EmployeeEditPage extends StatelessWidget {
  final Employee employee;

  const EmployeeEditPage({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Edit Employee Form\n(Implementation pending)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// Example usage with your JSON data
class ExampleUsage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample employee data matching your JSON structure
    final employee = Employee(
      id: "6c84fb90-12c4-11e1-840d-7b25c5ee775a",
      name: "Feil - Kutch",
      position: "Front-End Developer",
      email: "Feil@gmail.com",
      phone: "0899999999",
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Employee Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => EmployeeDetailPage(employee: employee),
            //   ),
            // );
          },
          child: const Text('View Employee Details'),
        ),
      ),
    );
  }
}
