import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/utils/theme_controller.dart'; // Importa tu ThemeController

class AppearanceSettingsView extends StatelessWidget {
  const AppearanceSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  appBar: AppBar(
    title: Text(
      "appearance".tr, // 🔸 TRADUCCIÓN
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.white,
      ),
    ),
    backgroundColor: ThemeUi.principal,
    iconTheme: const IconThemeData(color: Colors.white),
    centerTitle: true,
    elevation: 0,
  ),
  body: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        // 🌙 Modo oscuro
        Obx(() => _buildSettingOption(
              icon: Icons.brightness_6,
              title: "dark_mode".tr,
              trailing: Switch(
                value: themeController.themeMode.value == ThemeMode.dark,
                onChanged: (bool value) {
                  themeController.toggleTheme();
                },
              ),
            )),

        // 🔤 Tamaño de fuente
        _buildSettingOption(
          icon: Icons.text_fields,
          title: "font_size".tr,
          onTap: () => Get.toNamed('/font-size'),
        ),

        // 🎨 Color de tema
        _buildSettingOption(
          icon: Icons.palette,
          title: "theme_color".tr,
          onTap: () => Get.toNamed('/theme-color'),
        ),

        // 🌐 Selector de idioma
        _buildSettingOption(
          icon: Icons.language,
          title: "language".tr,
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            onSelected: (value) {
              if (value == 'en') Get.updateLocale(const Locale('en', 'US'));
              if (value == 'es') Get.updateLocale(const Locale('es', 'ES'));
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'en', child: Text('English'.tr)),
              PopupMenuItem(value: 'es', child: Text('Español'.tr)),
            ],
          ),
        ),
      ],
    ),
  ),
);

  }

  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: ThemeUi.principal, size: 28),
      title: Text(
        title,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
