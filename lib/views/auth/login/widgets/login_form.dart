import 'package:open_cargo/widgets/exceptions/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth/login/login_controller.dart';
import '../../../../utils/theme_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'login'.tr,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) => controller.email.value = value,
                decoration: InputDecoration(
                  labelText: 'email'.tr,
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                onChanged: (value) => controller.password.value = value,
                decoration: InputDecoration(
                  labelText: 'password'.tr,
                  prefixIcon: const Icon(Icons.lock_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Obx(() {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: Get.isDarkMode
                          ? [Colors.grey[800]!, Colors.blueGrey[800]!]
                          : [Colors.blueAccent, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton.icon(
                    onPressed:
                        controller.isLoading.value ? null : controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .transparent, // Fondo transparente para ver el degradado
                      shadowColor: Colors.transparent, // Sin sombra extra
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: controller.isLoading.value ? 0 : 5,
                    ),
                    icon: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : Icon(
                            Icons.login,
                            color:
                                Get.isDarkMode ? Colors.white : const Color.fromARGB(179, 255, 255, 255),
                          ),
                    label: controller.isLoading.value
                        ? Text(
                            'loading'.tr,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          )
                        : Text(
                            'login'.tr,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  ),
                );
              }),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () async {
                    try {
                      // Verificar si la ruta existe antes de navegar
                      if (Get.routeTree.matchRoute('/tabs').route == null) {
                        throw Exception(
                            'Route "/reset-password" not found'); // Lanzar error manualmente
                      }

                      // Si la ruta existe, navegar
                      await Get.toNamed('/tabs');
                    } catch (e) {
                      // Capturar el error y mostrarlo en el modal
                      ErrorModal.show(context, e.toString());
                    }
                  },
                  child: Text(
                    'Skip for now'.tr,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      // Verificar si la ruta existe antes de navegar
                      if (Get.routeTree.matchRoute('/reset-password').route ==
                          null) {
                        throw Exception(
                            'Route "/reset-password" not found'); // Lanzar error manualmente
                      }

                      // Si la ruta existe, navegar
                      await Get.toNamed('/reset-password');
                    } catch (e) {
                      // Capturar el error y mostrarlo en el modal
                      ErrorModal.show(context, e.toString());
                    }
                  },
                  child: Text(
                    'Forgot password?'.tr,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
