import 'package:employee_management/screens/employee_outsource_list/viewmodels/employee_outsource_list_screen_viewmodel.dart';
import 'package:employee_management/screens/employee_outsource_list/views/widget/employee_outsource_list_tile_widget.dart';
import 'package:employee_management/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeOutsourceListsScreen extends StatelessWidget {
  EmployeeOutsourceListsScreen({super.key});
  final EmployeeOutsourceListsScreenViewModel viewModel =
      Get.find<EmployeeOutsourceListsScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('พนักงาน Outsource'),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              viewModel.onAddEmployee();
            },
          ),
        ],
      ),

      body: Obx(() {
        return viewModel.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : EmployeeOutsourceListView(
              employees: viewModel.employees,
              onEmployeeTap: (employee) {
                viewModel.getDetail(employee);
              },
              onEmployeeEdit: (employee) {
                // Edit employee
                //rint('Edit: ${employee.name}');
              },
              onEmployeeDelete: (employee) {
                viewModel.deleteEmployee(employee.id);
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
