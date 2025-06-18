import 'package:employee_management/screens/home/viewmodels/home_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/employee.dart';
import '../../../utils/constants.dart';

class EmployeeListView extends StatelessWidget {
  EmployeeListView({super.key});

  final HomeScreenViewModel viewModel = Get.put(HomeScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuSelection(value),
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'filter',
                    child: Row(
                      children: [
                        Icon(Icons.filter_list),
                        SizedBox(width: 8),
                        Text('Filter by Department'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Icon(Icons.clear_all),
                        SizedBox(width: 8),
                        Text('Clear Filters'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  viewModel.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => viewModel.loadEmployees(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (viewModel.employees.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text(
                  'No employees found',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Add your first employee to get started',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Statistics Card
            Container(
              margin: const EdgeInsets.all(AppConstants.paddingMedium),
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(
                  AppConstants.borderRadiusMedium,
                ),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    'Total',
                    viewModel.employeesCount.toString(),
                    Icons.people,
                  ),
                ],
              ),
            ),

            // Search and Filter Info
            if (viewModel.searchQuery.value.isNotEmpty ||
                viewModel.selectedDepartment.value.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMedium,
                ),
                padding: const EdgeInsets.all(AppConstants.paddingSmall),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadiusSmall,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.orange[700],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _getFilterInfo(),
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => viewModel.clearFilters(),
                      child: const Text(
                        'Clear',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

            // Employee List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                itemCount: viewModel.employees.length,
                itemBuilder: (context, index) {
                  final employee = viewModel.employees[index];
                  return _buildEmployeeCard(employee, context);
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => null),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Color(AppConstants.primaryColorValue)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildEmployeeCard(Employee employee, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppConstants.paddingMedium),
        leading: CircleAvatar(
          backgroundColor: Color(AppConstants.primaryColorValue),
          child: Text(
            employee.name.substring(0, 1).toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          employee.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const SizedBox(height: 4), Text(employee.position)],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => null,
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: 'view',
                  child: Row(
                    children: [
                      Icon(Icons.visibility),
                      SizedBox(width: 8),
                      Text('View Details'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
        ),
        onTap: () => Get.to(() => null),
      ),
    );
  }

  String _getFilterInfo() {
    String info = '';
    if (viewModel.searchQuery.value.isNotEmpty) {
      info += 'Search: "${viewModel.searchQuery.value}"';
    }
    if (viewModel.selectedDepartment.value.isNotEmpty) {
      if (info.isNotEmpty) info += ' | ';
      info += 'Department: ${viewModel.selectedDepartment.value}';
    }
    return info;
  }

  void _showSearchDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Search Employees'),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Enter name, email, position, or department',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            viewModel.searchEmployees(value);
            Get.back();
          },
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              viewModel.searchEmployees(searchController.text);
              Get.back();
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'filter':
        // _showDepartmentFilterDialog();
        break;
      case 'clear':
        viewModel.clearFilters();
        break;
    }
  }

  void _showDeleteConfirmation(Employee employee) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Employee'),
        content: Text('Are you sure you want to delete ${employee.name}?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              viewModel.deleteEmployee(employee.id);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
