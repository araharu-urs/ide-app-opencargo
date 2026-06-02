import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/viajes/viajes_controller.dart';
import 'package:open_cargo/models/viajes/ofertas_model.dart';
import 'package:open_cargo/views/auth/user/agencia/widgets/modal_detalle_oferta.dart';

void showDetailsModal(int viajeId) {
  final ViajeController viajeController = Get.put(ViajeController());
  final theme = Theme.of(Get.context!);
  final isDark = theme.brightness == Brightness.dark;

  // Cargar las ofertas asociadas al viaje
  viajeController.fetchUsuariosOfertando(viajeId);

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: Get.height * 0.95,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Encabezado
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "offers_received".tr,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close, color: theme.iconTheme.color),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),

          // 🔹 Lista de ofertas
          Expanded(
            child: Obx(() {
              if (viajeController.isLoadingOferta.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (viajeController.usuariosOfertando.isEmpty) {
                return Center(
                  child: Text(
                    "no_offers_available".tr,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                  ),
                );
              }

              return ListView.builder(
                itemCount: viajeController.usuariosOfertando.length,
                itemBuilder: (context, index) {
                  final UsuarioOfertaModel oferta = viajeController.usuariosOfertando[index];

                  return Card(
                    color: theme.cardColor,
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          // 🔹 Avatar
                          CircleAvatar(
                            backgroundColor: Colors.green[200],
                            radius: 28,
                            child: Text(
                              oferta.name[0],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // 🔹 Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  oferta.name,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Text("fleet".trParams({'value': oferta!.tipo}),
                                    style: theme.textTheme.bodyMedium),
                                Text("status".trParams({'value': oferta.estado}),
                                    style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor)),
                               
                              ],
                            ),
                          ),

                          // 🔹 Botón ver
                          ElevatedButton.icon(
                            onPressed: () => showOfertaDetalleModal(oferta.id_oferta),
                            icon: const Icon(Icons.visibility, size: 18, color: Colors.white),
                            label: Text("view".tr, style: const TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeUi.principal,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    ),
    isDismissible: true,
    enableDrag: true,
  );
}

