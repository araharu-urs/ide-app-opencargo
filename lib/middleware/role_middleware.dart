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

    final normalizedRole = role.toLowerCase().trim();

    final Map<String, List<String>> roleRoutes = {
      "agencia":    [AppRoutes.tabs, AppRoutes.home, AppRoutes.agencia],
      "transporte": [AppRoutes.tabs, AppRoutes.home, AppRoutes.transporte],
      "publico":    [AppRoutes.tabs, AppRoutes.home, AppRoutes.publico],
    };

    if (!roleRoutes.containsKey(normalizedRole)) {
      return const RouteSettings(name: AppRoutes.login);
    }

    if (route != null && !roleRoutes[normalizedRole]!.contains(route)) {
      return RouteSettings(name: roleRoutes[normalizedRole]!.first);
    }

    return null;
  }
}
