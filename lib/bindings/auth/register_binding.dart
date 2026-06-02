import 'package:get/get.dart';
import 'package:open_cargo/controllers/auth/register/register_controller.dart';


class RegisterBinding extends Bindings {
  @override
  void dependencies() {
Get.put(RegisterController());
  }
}