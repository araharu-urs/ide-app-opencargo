import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import '../../../../controllers/auth/login/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find<LoginController>();
    final fillColor = Get.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: ThemeUi.principal, width: 1.5),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'login'.tr,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'enter_credentials'.tr,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.grey[500],
          ),
        ),
        const SizedBox(height: 24),

        // Email
        TextField(
          onChanged: (v) => controller.email.value = v,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'email'.tr,
            prefixIcon: const Icon(Icons.email_outlined),
            filled: true,
            fillColor: fillColor,
            border: inputBorder,
            enabledBorder: inputBorder,
            focusedBorder: focusedBorder,
          ),
        ),
        const SizedBox(height: 16),

        // Password con toggle
        Obx(() => TextField(
              onChanged: (v) => controller.password.value = v,
              obscureText: controller.obscurePassword.value,
              decoration: InputDecoration(
                labelText: 'password'.tr,
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: controller.obscurePassword.toggle,
                ),
                filled: true,
                fillColor: fillColor,
                border: inputBorder,
                enabledBorder: inputBorder,
                focusedBorder: focusedBorder,
              ),
            )),

        // Forgot password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Get.toNamed('/reset-password'),
            child: Text(
              'Forgot password?'.tr,
              style: const TextStyle(
                color: ThemeUi.principal,
                fontSize: 13,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Login button
        Obx(() => Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: Get.isDarkMode
                      ? [Colors.grey[800]!, Colors.blueGrey[800]!]
                      : [ThemeUi.principal, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton.icon(
                onPressed:
                    controller.isLoading.value ? null : controller.login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: controller.isLoading.value
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Icon(Icons.login, color: Colors.white),
                label: Text(
                  controller.isLoading.value ? 'loading'.tr : 'login'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            )),
        const SizedBox(height: 8),

        // Skip for now
        Center(
          child: TextButton(
            onPressed: () => Get.toNamed('/tabs'),
            child: Text(
              'Skip for now'.tr,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
