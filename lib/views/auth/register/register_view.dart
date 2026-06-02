import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/auth/register/register_controller.dart';
import 'package:open_cargo/views/auth/register/widgets/input_text.dart';
import 'package:open_cargo/views/auth/register/widgets/tabs_profile.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
        'register'.tr,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
        centerTitle: true,
       backgroundColor:  ThemeUi.principal,
        elevation: 1,
        iconTheme: IconThemeData(color: theme.iconTheme.color),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildProfileSelector(controller, theme),
              const SizedBox(height: 30),
              buildTextField(controller.nameController, 'name'.tr, Icons.person, theme),
              const SizedBox(height: 15),
              buildTextField(
                controller.emailController,
                'email'.tr,
                Icons.email,
                theme,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              Obx(() {
                if (controller.selectedProfile.value == "Aduanas" ||
                    controller.selectedProfile.value == "Distribuidores") {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildTextField(
                        controller.companyController,
                      'company_name'.tr,
                        Icons.business,
                        theme,
                      ),
                      const SizedBox(height: 15),
                      buildTextField(controller.rfcController,'rfc'.tr, Icons.badge, theme),
                      const SizedBox(height: 15),
                    ],
                  );
                }
                return const SizedBox();
              }),
              buildTextField(controller.passwordController, 'password'.tr, Icons.lock, theme, isObscure: true),
              const SizedBox(height: 15),
              buildTextField(controller.confirmPasswordController, 'confirm_password'.tr, Icons.lock, theme, isObscure: true),
              const SizedBox(height: 30),
              Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeUi.principal,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 3,
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        :  Text(
                            'register_button'.tr,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
