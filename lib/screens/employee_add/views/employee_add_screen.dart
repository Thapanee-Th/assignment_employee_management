import 'package:employee_management/screens/employee_add/viewmodels/employee_add_screen_viewmodel.dart';
import 'package:employee_management/widgets/text_form_field_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeAddScreen extends StatelessWidget {
  EmployeeAddScreen({super.key});
  final EmployeeAddScreenViewModel viewModel =
      Get.find<EmployeeAddScreenViewModel>();

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
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
