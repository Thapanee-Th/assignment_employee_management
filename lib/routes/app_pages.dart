import 'package:employee_management/screens/employee_add/employee_add_screen_binding.dart';
import 'package:employee_management/screens/employee_add/views/employee_add_screen.dart';
import 'package:employee_management/screens/employee_detail/employee_detail_screen_binding.dart';
import 'package:employee_management/screens/employee_detail/views/employee_detail_screen.dart';
import 'package:employee_management/screens/employee_edit/employee_edit_screen_binding.dart';
import 'package:employee_management/screens/employee_edit/views/employee_edit_screen.dart';
import 'package:employee_management/screens/employee_list/employee_list_screen_binding.dart';
import 'package:employee_management/screens/employee_list/views/employee_list_screen.dart';
import 'package:employee_management/screens/employee_outsource_detail/employee_outsource_detail_screen_binding.dart';
import 'package:employee_management/screens/employee_outsource_detail/views/employee_outsource_detail_screen.dart';
import 'package:employee_management/screens/employee_outsource_list/employee_outsource_list_screen_binding.dart';
import 'package:employee_management/screens/employee_outsource_list/views/employee_outsource_list_screen.dart';
import 'package:employee_management/screens/home/home_screen_binding.dart';
import 'package:employee_management/screens/home/views/home_screen.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const splashScreen = Routes.splashScreen;
  static const home = Routes.home;
  static const employeeLists = Routes.employeeLists;
  static const employeeDetail = Routes.employeeDetail;
  static const employeeOutsourceLists = Routes.employeeOutsourceLists;
  static const employeeOutsourceDetail = Routes.employeeOutsourceDetail;
  static const employeeEdit = Routes.employeeEdit;
  static const employeeAdd = Routes.employeeAdd;

  static final routes = [
    GetPage(name: home, page: () => HomeScreen(), binding: HomeScreenBinding()),
    GetPage(
      name: employeeLists,
      page: () => EmployeeListsScreen(),
      binding: EmployeeListsScreenBinding(),
    ),
    GetPage(
      name: employeeDetail,
      page: () => EmployeeDetailScreen(),
      binding: EmployeeDetailScreenBinding(),
    ),
    GetPage(
      name: employeeAdd,
      page: () => EmployeeAddScreen(),
      binding: EmployeeAddScreenBinding(),
    ),
    GetPage(
      name: employeeEdit,
      page: () => EmployeeEditScreen(),
      binding: EmployeeEditScreenBinding(),
    ),
    GetPage(
      name: employeeOutsourceLists,
      page: () => EmployeeOutsourceListsScreen(),
      binding: EmployeeOutsourceListsScreenBinding(),
    ),
    GetPage(
      name: employeeOutsourceDetail,
      page: () => EmployeeOutsourceDetailScreen(),
      binding: EmployeeOutsourceDetailScreenBinding(),
    ),
  ];
}
