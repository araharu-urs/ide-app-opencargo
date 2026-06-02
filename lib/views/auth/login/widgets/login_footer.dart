import 'package:open_cargo/widgets/exceptions/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Text(
            "Don't have an account?".tr,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          TextButton(
            onPressed: () async {
              try {
               

                // Si la ruta existe, navegar
                await Get.toNamed('/register');
              } catch (e) {
                // Capturar el error y mostrarlo en el modal
                ErrorModal.show(context, e.toString());
              }
            },
            child: Text(
              'Sign Up'.tr,
              style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
