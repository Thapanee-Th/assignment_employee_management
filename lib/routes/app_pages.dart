import 'package:employee_management/screens/home/home_screen_binding.dart';
import 'package:employee_management/screens/home/views/home_screen.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const splashScreen = Routes.splashScreen;
  static const home = Routes.home;

  static final routes = [
    GetPage(name: home, page: () => HomeScreen(), binding: HomeScreenBinding()),
  ];
}
