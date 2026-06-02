import 'package:get_storage/get_storage.dart';
import 'package:open_cargo/services/auth/auth_service.dart';
import 'package:open_cargo/views/auth/acerca/sobre_app_view.dart';
import 'package:open_cargo/views/auth/acerca/soporte_view.dart';
import 'package:open_cargo/views/auth/cuenta/cambiar_password.dart';
import 'package:open_cargo/views/auth/cuenta/perfil_view.dart';
import 'package:open_cargo/views/auth/preferencias/apariencia_view.dart';
import 'package:open_cargo/views/auth/preferencias/notificaciones_view.dart';
import 'package:open_cargo/views/auth/seguridad/configuraciones_seguridad_view.dart';
import 'package:open_cargo/views/auth/seguridad/politica_privacidad_view.dart';
import 'package:open_cargo/views/auth/user/settings/widgets/cerrar_sesion_button.dart';
import 'package:open_cargo/views/auth/user/settings/widgets/header.dart';
import 'package:open_cargo/views/auth/user/settings/widgets/items.dart';
import 'package:open_cargo/views/public/profile/widgets/titulo.dart';
import 'package:open_cargo/widgets/exceptions/confirmacion_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = AuthService.isUserLoggedIn(); // Verificar sesión

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:
          isLoggedIn ? _buildSettingsList(context) : _buildLoginPrompt(context),
    );
  }

  // 📌 Vista de configuración
  Widget _buildSettingsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          buildUserHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                buildSectionTitle("account".tr),
                buildSettingsItem(Icons.person_outline, "profile".tr, () {
                  Get.to(ProfileEditView());
                }),
                buildSettingsItem(Icons.lock_outline, "change_password".tr,
                    () {
                  Get.to(ChangePasswordView());
                }),

                const SizedBox(height: 15),

                buildSectionTitle("preferences".tr),
                buildSettingsItem(Icons.notifications_none, "notifications".tr,
                    () {
                  Get.to(() => const NotificationSettingsView());
                }),
                buildSettingsItem(Icons.color_lens_outlined, "appearance".tr,
                    () {
                  Get.to(() => const AppearanceSettingsView());
                }),

                const SizedBox(height: 15),

                buildSectionTitle("security".tr),
                buildSettingsItem(
                    Icons.privacy_tip_outlined, "privacy_policy".tr, () {
                  Get.to(PrivacyPolicyView());
                }),
                buildSettingsItem(Icons.security, "security_settings".tr, () {
                  Get.to(() => const SecuritySettingsView());
                }),

                const SizedBox(height: 15),

                buildSectionTitle("about".tr),
                buildSettingsItem(Icons.info_outline, "about_app".tr, () {
                  Get.to(() => const AboutAppView());
                }),
                buildSettingsItem(Icons.help_outline, "support_help".tr, () {
                  Get.to(() => const SupportHelpView());
                }),

                const SizedBox(height: 30),

                // Botón de cerrar sesión
                buildLogoutButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }



  // 📌 Botón de cerrar sesión estilizado


  // 📌 Mensaje cuando el usuario no ha iniciado sesión
  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.account_circle,
                  size: 60, color: Colors.blueAccent),
              const SizedBox(height: 10),
              const Text(
                "Inicio de sesión requerido",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Debes iniciar sesión para administrar tu cuenta.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  AuthService.logout();
                  Get.toNamed('/login');
                },
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                label: const Text("Ir a inicio de sesión"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
