import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/views/auth/user/agencia/widgets/modal_detalle_carga.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildHeader() {
  return Row(
    children: [
      // 🔍 Campo de búsqueda
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: "Buscar entre tus viajes",
                    hintStyle: TextStyle(
                      color: Get.isDarkMode ? Colors.white54 : Colors.black54,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    // TODO: Agregar función de búsqueda
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(width: 10),

      // ➕ Botón de acción
      GestureDetector(
        onTap: () {
          CreateTripModal.show(Get.context!);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ThemeUi.principal, // Color azul
            shape: BoxShape.circle, // Forma redonda
          ),
          child: const Icon(Icons.add,
              color: Colors.white, size: 24), // Icono de agregar
        ),
      ),
    ],
  );
}
