import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';

class SecuritySettingsView extends StatelessWidget {
  const SecuritySettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Seguridad".tr,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
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
            _buildSettingOption(
              context,
              icon: Icons.lock_outline,
              title: "Cambiar contraseña".tr,
              onTap: () => Get.toNamed('/change-password'),
            ),
            _buildSettingOption(
              context,
              icon: Icons.fingerprint,
              title: "Habilitar autenticación biométrica".tr,
              trailing: Switch(value: true, onChanged: (bool value) {}),
            ),
            _buildSettingOption(
              context,
              icon: Icons.security,
              title: "Verificar actividad de inicio de sesión".tr,
              onTap: () => Get.toNamed('/login-activity'),
            ),
            _buildSettingOption(
              context,
              icon: Icons.privacy_tip,
              title: "Política de privacidad".tr,
              onTap: () => Get.toNamed('/privacy-policy'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: ThemeUi.principal, size: 28),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge,
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
