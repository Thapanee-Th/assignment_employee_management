import 'package:employee_management/models/employee_outsource.dart';
import 'package:flutter/material.dart';

// Employee ListView Widget
class EmployeeOutsourceListView extends StatelessWidget {
  final List<EmployeeOutsource> employees;
  final Function(EmployeeOutsource)? onEmployeeTap;
  final Function(EmployeeOutsource)? onEmployeeEdit;
  final Function(EmployeeOutsource)? onEmployeeDelete;
  final bool showActions;
  final bool showSalary;

  const EmployeeOutsourceListView({
    super.key,
    required this.employees,
    this.onEmployeeTap,
    this.onEmployeeEdit,
    this.onEmployeeDelete,
    this.showActions = true,
    this.showSalary = true,
  });

  @override
  Widget build(BuildContext context) {
    if (employees.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No employees found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: employees.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final employee = employees[index];
        return EmployeeListTile(
          employee: employee,
          onTap: onEmployeeTap,
          onEdit: onEmployeeEdit,
          onDelete: onEmployeeDelete,
          showActions: showActions,
          showSalary: showSalary,
        );
      },
    );
  }
}

// Individual Employee List Tile
class EmployeeListTile extends StatelessWidget {
  final EmployeeOutsource employee;
  final Function(EmployeeOutsource)? onTap;
  final Function(EmployeeOutsource)? onEdit;
  final Function(EmployeeOutsource)? onDelete;
  final bool showActions;
  final bool showSalary;

  const EmployeeListTile({
    super.key,
    required this.employee,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.showActions = true,
    this.showSalary = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(Icons.person),
        title: _buildTitle(),
        subtitle: _buildSubtitle(),
        trailing: IconButton(
          onPressed: () {
            _showDeleteConfirmation(context);
          },
          icon: Icon(Icons.delete, size: 30, color: Colors.red.shade500),
        ),
        onTap: onTap != null ? () => onTap!(employee) : null,
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          employee.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 2),
        Text(
          employee.company,
          style: TextStyle(
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.phone, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                employee.phone ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            const Icon(Icons.email, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                employee.email ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit?.call(employee);
            break;
          case 'delete':
            _showDeleteConfirmation(context);
            break;
        }
      },
      itemBuilder:
          (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 18),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 18, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Employee'),
            content: Text('Are you sure you want to delete ${employee.name}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onDelete?.call(employee);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }
}
