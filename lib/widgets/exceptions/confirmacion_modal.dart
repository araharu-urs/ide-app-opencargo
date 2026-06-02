import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmModal {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm, // Acción cuando se presiona "Sí"
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Get.isDarkMode ? Colors.grey[900] : Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    color: Get.isDarkMode ? Colors.orange[300] : Colors.orangeAccent,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context), // Cerrar modal sin confirmar
                    icon: const Icon(Icons.close, size: 20,color: Colors.white,),
                    label: Text('No'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.isDarkMode ? Colors.blueGrey : Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // Cerrar modal antes de ejecutar la acción
                      onConfirm(); // Ejecutar la acción confirmada
                    },
                    icon: const Icon(Icons.check_circle, size: 20,color: Colors.white),
                    label: Text('Yes'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.isDarkMode ? Colors.greenAccent : Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
