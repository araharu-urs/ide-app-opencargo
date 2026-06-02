import 'package:open_cargo/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../routes/app_routes.dart';
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    final String? token = box.read('token');

    if (token == null || token.isEmpty) {
      if (route == AppRoutes.login) {
        return null; // Si ya está en login, no redirigir de nuevo
      }
      return const RouteSettings(name: AppRoutes.login);
    }

    return null; // Permitir la navegación si ya tiene sesión
  }
}