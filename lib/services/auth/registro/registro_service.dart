import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_cargo/env.dart';
import 'package:open_cargo/widgets/exceptions/error_modal.dart';

class RegistroService extends GetConnect {
  final GetStorage _storage = GetStorage();

  /// 📌 Función para registrar un nuevo usuario
  Future<Map<String, dynamic>> register(
      String name, String email, String password, int rolId) async {
    try {
      final response = await post(
        '${Env.baseUrl}/auth/register',
        jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "rol": rolId,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = response.body;
        print(response.body);
          return {"success": true, "message": "Registro exitoso"};
       
      } else {
        ErrorModal.show(Get.context!, response.statusCode.toString());
        return {
          "success": false,
          "message": response.body['message'] ?? "Error en el registro"
        };
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return {"success": false, "message": "Error de conexión: $e"};
    }
  }
}
