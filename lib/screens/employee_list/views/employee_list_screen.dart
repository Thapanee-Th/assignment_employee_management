import 'package:employee_management/screens/employee_list/viewmodels/employee_list_screen_viewmodel.dart';
import 'package:employee_management/screens/employee_list/views/widget/employee_list_tile_widget.dart';
import 'package:employee_management/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeListsScreen extends StatelessWidget {
  EmployeeListsScreen({super.key});
  final EmployeeListsScreenViewModel viewModel =
      Get.find<EmployeeListsScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('พนักงานในบริษัท'),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          viewModel.onAddEmployee();
        },
      ),
      body: Obx(() {
        return viewModel.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : EmployeeListView(
              employees: viewModel.filteredEmployees,
              onEmployeeTap: (employee) {
                viewModel.getDetail(employee);
              },
              onEmployeeEdit: (employee) {
                // Edit employee
                //rint('Edit: ${employee.name}');
              },
              onEmployeeDelete: (employee) {
                // setState(() {
                //   employees.removeWhere((e) => e.id == employee.id);
                // });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${employee.name} deleted'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Implement undo functionality
                      },
                    ),
                  ),
                );
              },
            );
      }),
    );
  }

  Widget menuItem(String menuName, double width, Function onClick) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        width: width, // 80% of screen width
        padding: const EdgeInsets.fromLTRB(16.0, 26.0, 16.0, 26.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade100.withAlpha(90),
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withAlpha(30),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: Text(
          menuName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
