import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'success_modal.dart'; // Importamos la modal de éxito

class ErrorModal {
  static void show(BuildContext context, String errorMessage) {
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
                    Icons.error_outline,
                    color: Get.isDarkMode ? Colors.red[300] : Colors.redAccent,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'An error occurred'.tr,
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
                'Error Details:'.tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    fontSize: 14,
                    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 20,color: Colors.white,),
                    label: Text('Close'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.isDarkMode ? Colors.blueGrey : Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _sendErrorReport(context, errorMessage);
                    },
                    icon: const Icon(Icons.bug_report, size: 20,color: Colors.white,),
                    label: Text('Send Report'.tr),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.isDarkMode ? Colors.redAccent : Colors.red,
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

  // Método que simula el envío del reporte con un loader Cupertino
  static Future<void> _sendErrorReport(BuildContext context, String error) async {
    // Mostrar Loader Cupertino
    showDialog(
      context: context,
      barrierDismissible: false, // Evitar que el usuario cierre el modal mientras carga
      builder: (BuildContext context) {
        return Center(
          child: CupertinoActivityIndicator(radius: 20),
        );
      },
    );

    // Simular un retraso de 3 segundos
    await Future.delayed(const Duration(seconds: 3));

    // Cerrar el Loader
    Navigator.pop(context);

    // Cerrar el modal de error
    Navigator.pop(context);

    // Mostrar modal de éxito
    SuccessModal.show(context);
  }
}
