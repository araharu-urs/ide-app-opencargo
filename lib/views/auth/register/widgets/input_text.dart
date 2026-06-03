import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';

Widget buildTextField(
  TextEditingController controller,
  String label,
  IconData icon, {
  bool isObscure = false,
  VoidCallback? onToggleObscure,
  TextInputType inputType = TextInputType.text,
}) {
  final fillColor = Get.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;
  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  );
  final focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: ThemeUi.principal, width: 1.5),
  );

  return TextField(
    controller: controller,
    obscureText: isObscure,
    keyboardType: inputType,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: onToggleObscure != null
          ? IconButton(
              icon: Icon(isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
              onPressed: onToggleObscure,
            )
          : null,
      filled: true,
      fillColor: fillColor,
      border: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: focusedBorder,
    ),
  );
}
