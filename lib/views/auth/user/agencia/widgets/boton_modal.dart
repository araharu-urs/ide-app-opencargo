import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget modalButton(IconData icon, String label, Color textColor, Color bgColor) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton.icon(
        onPressed: () => Get.snackbar(label, "Acción en desarrollo"),
        icon: Icon(icon, size: 18, color: textColor),
        label: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    ),
  );
}