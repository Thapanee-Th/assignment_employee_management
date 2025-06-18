import 'package:employee_management/screens/employee_edit/viewmodels/employee_edit_screen_viewmodel.dart';
import 'package:employee_management/widgets/text_form_field_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EmployeeEditScreen extends StatelessWidget {
  EmployeeEditScreen({super.key});
  final EmployeeEditScreenViewModel viewModel =
      Get.find<EmployeeEditScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Employee')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: viewModel.editFormKey,
          child: Column(
            children: [
              TextFormFieldWidget(
                controller: viewModel.nameController,
                label: 'Name',
                //  decoration: const InputDecoration(labelText: 'Name'),
                validator: viewModel.validator,
              ),
              const SizedBox(height: 16.0),
              TextFormFieldWidget(
                controller: viewModel.emailController,
                label: 'Email',
                // decoration: const InputDecoration(labelText: 'Email'),
                validator: viewModel.validator,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextFormFieldWidget(
                controller: viewModel.phoneController,
                // decoration: const InputDecoration(labelText: 'Phone'),
                label: 'Phone',
                validator: viewModel.validator,
              ),
              const SizedBox(height: 16.0),
              TextFormFieldWidget(
                controller: viewModel.positionController,
                //decoration: const InputDecoration(labelText: 'Position'),
                label: 'Position',
                validator: viewModel.validator,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: viewModel.saveEmployee,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: _getAvatarColor(),
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: _getAvatarColor().withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                viewModel.employee.value?.name ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            viewModel.employee.value?.name ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Position
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Text(
              viewModel.employee.value?.position ?? '',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Employee ID
          Text(
            'ID: ${viewModel.employee.value?.id}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(10),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.contact_phone, color: Colors.blue, size: 24),
              SizedBox(width: 8),
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            icon: Icons.email,
            label: 'Email',
            value: viewModel.employee.value?.email ?? '',
            onTap: () => _launchEmail(viewModel.employee.value?.email ?? ''),
          ),
          const SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.phone,
            label: 'Phone',
            value: viewModel.employee.value?.phone ?? '',
            onTap: () => _launchPhone(viewModel.employee.value?.phone ?? ''),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.badge, color: Colors.blue, size: 24),
              SizedBox(width: 8),
              Text(
                'Employee Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Employee ID', viewModel.employee.value?.id ?? ''),
          const SizedBox(height: 12),
          _buildInfoRow('Full Name', viewModel.employee.value?.name ?? ''),
          const SizedBox(height: 12),
          _buildInfoRow('Position', viewModel.employee.value?.position ?? ''),
          const SizedBox(height: 12),
          _buildInfoRow('Status', 'Active', valueColor: Colors.green),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.blue.shade600, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onLongPress: () => _copyToClipboard(value),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: valueColor ?? Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getAvatarColor() {
    final colors = [
      Colors.blue.shade600,
      Colors.green.shade600,
      Colors.orange.shade600,
      Colors.purple.shade600,
      Colors.teal.shade600,
      Colors.indigo.shade600,
    ];
    return colors[viewModel.employee.value!.id.hashCode % colors.length];
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'share':
        _shareEmployee(context);
        break;
      case 'delete':
        _deleteEmployee(context);
        break;
    }
  }

  void _shareEmployee(BuildContext context) {
    final shareText = '''
Employee Details:
Name: ${viewModel.employee.value?.name}
Position: ${viewModel.employee.value?.position}
Email: ${viewModel.employee.value?.email}
Phone: ${viewModel.employee.value?.phone}
''';

    // Show share dialog
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Share Employee'),
            content: Text(shareText),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: shareText));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Employee details copied to clipboard'),
                    ),
                  );
                },
                child: const Text('Copy'),
              ),
            ],
          ),
    );
  }

  void _deleteEmployee(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Employee'),
            content: Text(
              'Are you sure you want to delete ${viewModel.employee.value?.name}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to previous screen
                  // Handle delete logic here
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  void _launchEmail(String email) {
    // Implement email launching
    print('Launch email to: $email');
  }

  void _launchPhone(String phone) {
    // Implement phone calling
    print('Call phone: $phone');
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
