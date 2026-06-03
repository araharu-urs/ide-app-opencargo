import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/auth/register/register_controller.dart';
import 'widgets/input_text.dart';
import 'widgets/tabs_profile.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find<RegisterController>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Gradient background — full screen
          Container(
            height: screenHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ThemeUi.principal, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Header — logo + title + subtitle + back arrow
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.30,
            child: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: 4,
                    left: 4,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 20),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icon.png', height: 60),
                        const SizedBox(height: 10),
                        const Text(
                          'Open Cargo',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'create_account'.tr,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // White floating card — bottom 74%
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.74,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 20),
                ],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                    20, 28, 20, MediaQuery.of(context).viewInsets.bottom + 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'register'.tr,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'fill_your_details'.tr,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Profile selector
                    buildProfileSelector(controller, Theme.of(context)),
                    const SizedBox(height: 20),

                    // Name
                    buildTextField(
                      controller.nameController,
                      'name'.tr,
                      Icons.person_outlined,
                    ),
                    const SizedBox(height: 16),

                    // Email
                    buildTextField(
                      controller.emailController,
                      'email'.tr,
                      Icons.email_outlined,
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // Conditional: company + RFC
                    Obx(() {
                      if (controller.selectedProfile.value == 'Aduanas' ||
                          controller.selectedProfile.value == 'Distribuidores') {
                        return Column(
                          children: [
                            buildTextField(
                              controller.companyController,
                              'company_name'.tr,
                              Icons.business_outlined,
                            ),
                            const SizedBox(height: 16),
                            buildTextField(
                              controller.rfcController,
                              'rfc'.tr,
                              Icons.badge_outlined,
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }
                      return const SizedBox();
                    }),

                    // Password
                    Obx(() => buildTextField(
                          controller.passwordController,
                          'password'.tr,
                          Icons.lock_outlined,
                          isObscure: controller.obscurePassword.value,
                          onToggleObscure: controller.obscurePassword.toggle,
                        )),
                    const SizedBox(height: 16),

                    // Confirm password
                    Obx(() => buildTextField(
                          controller.confirmPasswordController,
                          'confirm_password'.tr,
                          Icons.lock_outlined,
                          isObscure: controller.obscureConfirm.value,
                          onToggleObscure: controller.obscureConfirm.toggle,
                        )),
                    const SizedBox(height: 28),

                    // Register button
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
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.registerUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2),
                                  )
                                : Text(
                                    'register_button'.tr,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                          ),
                        )),
                    const SizedBox(height: 12),

                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'already_have_account'.tr,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            'sign_in'.tr,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: ThemeUi.principal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
