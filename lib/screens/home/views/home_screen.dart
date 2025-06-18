import 'package:employee_management/routes/app_pages.dart';
import 'package:employee_management/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        backgroundColor: Color(AppConstants.primaryColorValue),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          menuItem(
            'พนักงานในบริษัท',
            MediaQuery.sizeOf(context).width * 0.8,
            () {
              Get.toNamed(Routes.employeeLists);
            },
          ),
          menuItem(
            'พนักงาน Outsource',
            MediaQuery.sizeOf(context).width * 0.8,
            () {
              Get.toNamed(Routes.employeeOutsourceLists);
            },
          ),
        ],
      ),
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
