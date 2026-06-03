import 'package:open_cargo/routes/app_routes.dart';
import 'package:open_cargo/services/auth/login/login_service.dart';
import 'package:open_cargo/widgets/exceptions/error_modal.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var obscurePassword = true.obs;

  final LoginService loginService = LoginService();

  void login() async {
    try {
      isLoading(true);
      final loginResponse =
          await loginService.login(email.value, password.value);

      if (loginResponse != null && loginResponse.accessToken.isNotEmpty) {
        Get.snackbar('Success', 'Welcome ${loginResponse.user.name}');
        Get.offAllNamed(AppRoutes.tabs);
      } else {
        Get.snackbar('Error', 'Invalid credentials');
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
    } finally {
      isLoading(false);
    }
  }
}
