import 'package:get/get.dart';
import 'package:note_keeper/app/modules/user/controllers/user_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.put<UserController>(UserController());
  }
}
