import 'package:open_cargo/routes/app_routes.dart';
import 'package:open_cargo/services/auth/login/login_service.dart';
import 'package:open_cargo/widgets/exceptions/error_modal.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  final LoginService loginService = LoginService();

  void login() async {
    try {
      isLoading(true);
      final loginResponse =
          await loginService.login(email.value, password.value);

      if (loginResponse != null && loginResponse.accessToken.isNotEmpty) {
        Get.snackbar('Success', 'Welcome ${loginResponse.user.name}');
        GetStorage().write('token', loginResponse.accessToken);
        GetStorage().write('id', loginResponse.user.id.toString());
        GetStorage().write('rol', loginResponse.user.rol);
        GetStorage().write('nombre', loginResponse.user.rol);
        GetStorage().write('correo', loginResponse.user.rol);
        GetStorage().write('imagen', loginResponse.user.imagen);
        GetStorage()
            .write('token_notificacion', loginResponse.user.token_notificacion);
        // Guardar datos del usuario en GetStorage
        GetStorage().write('user', {
          'id': loginResponse.user.id,
          'name': loginResponse.user.name,
          'email': loginResponse.user.email,
        });
        final String? role = GetStorage().read('rol');

        String redirectRoute = AppRoutes.tabs; // Asegurar que siempre va a Tabs
        if (role == "agencia") {
          redirectRoute = AppRoutes.tabs;
        } else if (role == "transporte") {
          redirectRoute = AppRoutes.tabs;
        } else if (role == "publico") {
          redirectRoute = AppRoutes.tabs;
        }

        Get.offAllNamed(redirectRoute);
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
