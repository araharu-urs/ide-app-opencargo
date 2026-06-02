import 'package:open_cargo/services/auth/reset_password/reset_password_service.dart';
import 'package:open_cargo/widgets/exceptions/error_modal.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  var email = ''.obs;
  var isLoading = false.obs;

  final ResetPasswordService resetPasswordService = ResetPasswordService();

  void resetPassword() async {
    try {
      isLoading(true);
      bool success = await resetPasswordService.resetPassword(email.value);
      if (success) {
        Get.snackbar('Éxito', 'Se envió un enlace de recuperación a tu correo');
        Get.back(); // Regresar a la pantalla anterior
      } else {
        Get.snackbar('Error', 'No se pudo procesar la solicitud');
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
    } finally {
      isLoading(false);
    }
  }
}
