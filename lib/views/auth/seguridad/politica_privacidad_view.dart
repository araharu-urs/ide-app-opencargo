import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Política de Privacidad".tr,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: ThemeUi.principal,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("📌 Introducción", textTheme, colorScheme),
            _buildParagraph(
              "Bienvenido a Open Cargo. Tu privacidad es importante para nosotros. "
              "En esta política, explicamos cómo recopilamos, usamos y protegemos "
              "tu información personal.",
              textTheme,
              colorScheme,
            ),
            _buildDivider(colorScheme),

            _buildSectionTitle("🔹 Información que recopilamos", textTheme, colorScheme),
            _buildParagraph(
              "Recopilamos información personal que proporcionas directamente, "
              "como tu nombre, dirección de correo electrónico y número de teléfono. "
              "También podemos recopilar datos sobre tu uso de la plataforma.",
              textTheme,
              colorScheme,
            ),
            _buildDivider(colorScheme),

            _buildSectionTitle("🔐 Cómo protegemos tu información", textTheme, colorScheme),
            _buildParagraph(
              "Implementamos medidas de seguridad avanzadas para proteger "
              "tu información contra accesos no autorizados, alteraciones o destrucción.",
              textTheme,
              colorScheme,
            ),
            _buildDivider(colorScheme),

            _buildSectionTitle("📋 Derechos del usuario", textTheme, colorScheme),
            _buildParagraph(
              "Tienes derecho a acceder, rectificar o eliminar tu información personal. "
              "Si deseas realizar cambios, puedes contactarnos en cualquier momento.",
              textTheme,
              colorScheme,
            ),
            _buildDivider(colorScheme),

            _buildSectionTitle("📅 Cambios en la política", textTheme, colorScheme),
            _buildParagraph(
              "Podemos actualizar esta política ocasionalmente. Notificaremos cualquier "
              "cambio significativo mediante nuestra plataforma o correo electrónico.",
              textTheme,
              colorScheme,
            ),
            const SizedBox(height: 20),

            // 🔹 Botón Aceptar
            Align(
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.check_circle, size: 20, color: Colors.white),
                label: const Text("Aceptar", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeUi.principal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextTheme textTheme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: colorScheme.onBackground,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text, TextTheme textTheme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface.withOpacity(0.7),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Divider(color: colorScheme.outlineVariant),
    );
  }
}
