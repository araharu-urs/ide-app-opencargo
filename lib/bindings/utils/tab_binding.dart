import 'package:open_cargo/controllers/utils/tab_controller.dart';
import 'package:get/get.dart';

class TabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabControllerX>(() => TabControllerX(), fenix: true);
  }
}