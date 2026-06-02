import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/controllers/auth/reset_password/reset_password.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordController controller = Get.find<ResetPasswordController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('reset_password'.tr),
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? Colors.grey[900] : Colors.blueAccent,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'en') Get.updateLocale(const Locale('en', 'US'));
              if (value == 'es') Get.updateLocale(const Locale('es', 'ES'));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'es', child: Text('Español')),
            ],
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    // Header con texto
                    Text(
                      'Forgot your password?'.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Enter your email to reset your password.'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Campo de Email
                    TextField(
                      onChanged: (value) => controller.email.value = value,
                      decoration: InputDecoration(
                        labelText: 'email'.tr,
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Get.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Botón para enviar el correo
                    Obx(() {
                      return ElevatedButton.icon(
                        onPressed: controller.isLoading.value ? null : controller.resetPassword,
                        icon: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                            : const Icon(Icons.send),
                        label: controller.isLoading.value
                            ? Text(
                                'loading'.tr,
                                style: const TextStyle(fontSize: 16),
                              )
                            : Text(
                                'reset_password'.tr,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 10),

                    // Texto de recordatorio
                    GestureDetector(
                      onTap: () {
                        Get.back(); // Navegar a la pantalla anterior
                      },
                      child: Text(
                        'Remember your password? Login'.tr,
                        style: TextStyle(
                          color: Get.isDarkMode ? Colors.blue[300] : Colors.blueAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
