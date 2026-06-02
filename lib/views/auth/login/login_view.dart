import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/utils/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/login_header.dart';
import 'widgets/login_form.dart';
import 'widgets/login_footer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Elimina el botón "Atrás"
        title: Text('login'.tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor:  ThemeUi.principal,
        actions: [
          IconButton(
            icon:
                Icon(Get.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: themeController.toggleTheme, // Cambiar el tema
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'en') Get.updateLocale(Locale('en', 'US'));
              if (value == 'es') Get.updateLocale(Locale('es', 'ES'));
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'en', child: Text('English')),
              PopupMenuItem(value: 'es', child: Text('Español')),
            ],
          ),
        ],
      ),
     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            LoginHeader(),
            LoginForm(),
            LoginFooter(),
          ],
        ),
      ),
    );
  }
}
