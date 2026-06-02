import 'package:open_cargo/controllers/public/home_controller.dart';
import 'package:open_cargo/routes/app_pages.dart';
import 'package:open_cargo/routes/app_routes.dart';
import 'package:open_cargo/services/permisos/permisos_service.dart';
import 'package:open_cargo/utils/localitacion/translations.dart';
import 'package:open_cargo/utils/notifications/notificacion.dart';
import 'package:open_cargo/utils/pusher/pusher.dart';
import 'package:open_cargo/utils/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await NotificationService().init();
  
  await PermissionService.requestInitialPermissions();

  Get.put(HomeController());
  await GetStorage.init();
  PusherService().initializePusher();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final String? token = box.read('token');
    // final String? role = box.read('rol');

    String initialRoute = AppRoutes.login;

    if (token != null && token.isNotEmpty) {
      initialRoute = AppRoutes.tabs;
    }
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        translations: AppTranslations(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        theme: themeController.lightTheme,
        darkTheme: themeController.darkTheme,
        themeMode: themeController.themeMode.value,
        getPages: AppPages.pages,
      );
    });
  }
}
