import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../routes/app_routes.dart';

class RoleMiddleware extends GetMiddleware {
 @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    final String? token = box.read('token');
    final String? role = box.read('rol');

    if (token == null || token.isEmpty) {
      return const RouteSettings(name: AppRoutes.login);
    }

    if (role == null || role.isEmpty) {
      return const RouteSettings(name: AppRoutes.login);
    }

    // Definir rutas permitidas según rol
    final Map<String, List<String>> roleRoutes = {
      "Agencia": [AppRoutes.tabs,AppRoutes.home, AppRoutes.agencia],
      "Transporte": [AppRoutes.tabs,AppRoutes.home, AppRoutes.transporte],
      "Publico": [AppRoutes.tabs,AppRoutes.home,  AppRoutes.publico],
    };

    if (!roleRoutes.containsKey(role)) {
      return const RouteSettings(name: AppRoutes.login);
    }

    // Si el usuario intenta acceder a una ruta no permitida, enviarlo a la principal de su rol
    if (route != null && !roleRoutes[role]!.contains(route)) {
      return RouteSettings(name: roleRoutes[role]!.first);
    }

    return null;
  }
}
