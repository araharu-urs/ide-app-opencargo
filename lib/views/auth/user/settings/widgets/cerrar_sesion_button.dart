  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/services/auth/auth_service.dart';
import 'package:open_cargo/widgets/exceptions/confirmacion_modal.dart';

Widget buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: ElevatedButton.icon(
        onPressed: () {
          ConfirmModal.show(
            context: context,
            title: "Cerrar sesión",
            message: "¿Seguro que deseas cerrar sesión?",
            onConfirm: () {
              AuthService.logout();
              Get.offAllNamed('/login');
            },
          );
        },
        icon: const Icon(
          Icons.exit_to_app,
          size: 20,
          color: Colors.white,
        ),
        label: const Text("Cerrar sesión", style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }