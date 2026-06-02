import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("change_password".tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.appBarTheme.foregroundColor)),
        centerTitle: true,
        backgroundColor: ThemeUi.principal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔷 Logo
            Center(
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/closca-app.appspot.com/o/open%20cargomorado.png?alt=media&token=2d882778-427f-480a-a732-7338968e802e',
                height: 100,
              ),
            ),
            const SizedBox(height: 30),

            // 📩 Instrucción
            Text(
              "enter_email_instruction".tr,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 20),

            // ✉️ Campo de correo
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: theme.textTheme.bodyMedium?.color),
              decoration: InputDecoration(
                hintText: "email".tr,
                prefixIcon: const Icon(Icons.email, color: Colors.blueAccent),
                filled: true,
                fillColor: theme.inputDecorationTheme.fillColor ??
                    (theme.brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.grey[200]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 🔘 Botón Enviar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.snackbar("success".tr, "reset_link_sent".tr,
                      snackPosition: SnackPosition.BOTTOM);
                },
                icon: const Icon(Icons.send, color: Colors.white),
                label: Text("send_reset_link".tr,
                    style: const TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeUi.principal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
