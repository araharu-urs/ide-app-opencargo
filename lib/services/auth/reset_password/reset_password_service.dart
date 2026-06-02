import 'package:open_cargo/models/auth/reset_password/reset_password.dart';
import 'package:get/get.dart';

class ResetPasswordService extends GetConnect {
  Future<bool> resetPassword(String email) async {
    final ResetPasswordModel data = ResetPasswordModel(email: email);

    final response = await post('https://api.ejemplo.com/reset-password', data.toJson());
    return response.statusCode == 200;
  }
}
