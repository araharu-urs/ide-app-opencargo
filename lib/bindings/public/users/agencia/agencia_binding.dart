import 'package:open_cargo/controllers/public/home_controller.dart';
import 'package:get/get.dart';

class AgenciaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
