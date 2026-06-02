import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class AuthService {
  static final _storage = GetStorage();

  // Verificar si el usuario tiene sesión activa
  static bool isUserLoggedIn() {
    final String? token = _storage.read('token');
    return token != null && token.isNotEmpty;
  }

  // Cerrar sesión
  static void logout() {
     GetStorage().erase();
    _storage.remove('token');
    _storage.remove('nombre');
    _storage.remove('correo');
    _storage.remove('imagen');
    _storage.remove('rol');
  }
  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.tuapp.com/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Guardar datos del usuario en el almacenamiento
        _storage.write('user', data['user']);
        _storage.write('token', data['token']);

        return {"success": true, "message": "Registro exitoso"};
      } else {
        return {"success": false, "message": data['message']};
      }
    } catch (e) {
      return {"success": false, "message": "Error de conexión"};
    }
  }
}
