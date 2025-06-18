import 'package:employee_management/screens/home/viewmodels/home_screen_viewmodel.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenViewModel(), fenix: true);
  }
}
