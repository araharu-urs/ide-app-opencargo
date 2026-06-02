import 'package:open_cargo/controllers/public/home_controller.dart';
import 'package:get/get.dart';

class TransporteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
