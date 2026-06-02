import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';

class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Notificaciones".tr,
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
              icon: Icons.notifications_active,
              title: "Notificaciones push".tr,
              trailing: Switch(value: true, onChanged: (bool value) {}),
            ),
            _buildSettingOption(
              context,
              icon: Icons.email,
              title: "Notificaciones por correo".tr,
              trailing: Switch(value: false, onChanged: (bool value) {}),
            ),
            _buildSettingOption(
              context,
              icon: Icons.sms,
              title: "Notificaciones por SMS".tr,
              trailing: Switch(value: false, onChanged: (bool value) {}),
            ),
            _buildSettingOption(
              context,
              icon: Icons.volume_up,
              title: "Sonidos de notificación".tr,
              onTap: () => Get.toNamed('/notification-sound'),
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
