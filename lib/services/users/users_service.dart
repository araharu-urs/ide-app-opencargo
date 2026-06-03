import 'dart:convert';

import 'package:open_cargo/env.dart';
import 'package:open_cargo/models/user/roles_model.dart';
import 'package:http/http.dart' as http;

import 'package:open_cargo/models/user/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserService extends GetConnect {
  final box = GetStorage();

  Future<List<UserModel>?> getUsers() async {
    final token = box.read('token');
    try {
      final response = await get(
        '${Env.baseUrl}/users/all',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return UserModel.fromJsonList(response.body);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<List<RolModel>?> getRoles() async {
    try {
      final token = box.read('token');
      final response = await get(
        '${Env.baseUrl}/roles/all',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return RolModel.fromJsonList(response.body);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<Map<String, dynamic>> registerToken(
      String userId, String token) async {
    try {
      final response = await http.post(
        Uri.parse("${Env.baseUrl}/users/token-notificacion"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "user_id": userId,
          "token_notificacion": token,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {"success": true, "message": data['message']};
      } else {
        return {
          "success": false,
          "message": data['message'] ?? 'Error al registrar token'
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error de conexión: $e"};
    }
  }
}
