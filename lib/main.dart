import 'package:employee_management/binding/initial_binding.dart';
import 'package:employee_management/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(AppConstants.primaryColorValue),
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(AppConstants.primaryColorValue),
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(AppConstants.primaryColorValue),
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(AppConstants.primaryColorValue),
          foregroundColor: Colors.white,
        ),
      ),
      // home: EmployeeListView(),
      initialRoute: AppPages.home,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
    );
  }
}
