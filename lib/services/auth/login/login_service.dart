import 'package:open_cargo/env.dart';
import 'package:open_cargo/models/auth/login/login_model.dart';
import 'package:open_cargo/models/auth/login/login_response_model.dart';
import 'package:open_cargo/widgets/exceptions/error_modal.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginService extends GetConnect {
  Future<LoginResponse?> login(String email, String password) async {
    try {
      final LoginModel loginData = LoginModel(email: email, password: password);

      final response = await post('${Env.baseUrl}/auth/login', loginData.toJson());

      if (response.statusCode == 200) {
        print(response.body);
        // Mapear la respuesta al modelo LoginResponse
        final loginResponse = LoginResponse.fromJson(response.body);
        
        // Almacenar el token si el login es exitoso
        if (loginResponse.accessToken.isNotEmpty) {
          GetStorage().write('token', loginResponse.accessToken);
          GetStorage().write('id', loginResponse.user.id.toString());
           GetStorage().write('rol', loginResponse.user.rol);
            GetStorage().write('nombre', loginResponse.user.name);
             GetStorage().write('correo', loginResponse.user.email);
           GetStorage().write('token_notificacion', loginResponse.user.token_notificacion);
        }
        return loginResponse;
      } else {
        ErrorModal.show(Get.context!, "Error ${response.statusCode}: ${response.bodyString}");
        return null; // Retornar null si ocurre un error en la solicitud
      }
    } catch (e) {
      ErrorModal.show(Get.context!, "Excepción en login: $e");
      return null; // Retornar null si ocurre una excepción
    }
  }
}


