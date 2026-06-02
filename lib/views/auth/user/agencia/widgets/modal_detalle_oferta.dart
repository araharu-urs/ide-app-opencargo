import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/viajes/viajes_controller.dart';
import 'package:open_cargo/models/viajes/oferta_detalle_model.dart';

void showOfertaDetalleModal(int ofertaId) {
  final ViajeController ofertaController = Get.put(ViajeController());
  final theme = Theme.of(Get.context!);
  final isDark = theme.brightness == Brightness.dark;

  ofertaController.fetchOfertaDetalle(ofertaId);
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: Get.height * 0.95,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Obx(() {
        if (ofertaController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final oferta = ofertaController.ofertaDetalle.value;

        if (oferta == null) {
          return Center(
            child: Text(
              "offer_not_found".tr,
              style:
                  theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Encabezado
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Detalles de la Oferta",
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: theme.iconTheme.color),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),

              // 🔹 Usuario
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    radius: 28,
                    child: Text(
                      oferta.name[0],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(oferta.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.hintColor)),
                      Text(oferta.email,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.hintColor)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🔹 Info general
              _buildInfoRow("Tipo de oferta", oferta.tipo),
              _buildInfoRow("Estado", oferta.estado),

              const SizedBox(height: 12),

              // 🔹 Info específica por tipo
              if (oferta.tipo == "Ofertar") ...[
                const SizedBox(height: 10),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                  },
                  border: TableBorder.symmetric(
                    inside: BorderSide(color: Colors.grey.shade300),
                  ),
                  children: [
                    TableRow(children: [
                      _buildTableCell(
                          "Precio por Full", "\$${oferta.precioFull ?? '-'}"),
                      _buildTableCell(
                          "Cantidad Full", oferta.cantidadFull ?? "-"),
                    ]),
                    TableRow(children: [
                      _buildTableCell("Precio por Sencillo",
                          "\$${oferta.precioSencillo ?? '-'}"),
                      _buildTableCell(
                          "Cantidad Sencillo", oferta.cantidadSencillo ?? "-"),
                    ]),
                  ],
                ),
                const SizedBox(height: 20),
              ] else if (oferta.tipo == "Tomar Carga") ...[
                _buildInfoRow(
                    "Contenedores solicitados", oferta.cantidad ?? "-"),
              ],

              const SizedBox(height: 20),

              Obx(() => Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: ofertaController.isLoading.value
                            ? null
                            : () async {
                                await ofertaController.aceptarOferta(ofertaId);
                                Get.snackbar("Acción", "Oferta aceptada",
                                    snackPosition: SnackPosition.BOTTOM);
                                Get.back();
                              },
                        icon: const Icon(Icons.check_circle,
                            color: Colors.white, size: 20),
                        label: ofertaController.isLoading.value
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                            : const Text("Aceptar oferta",
                                style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          minimumSize: const Size(double.infinity, 45),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: ofertaController.isLoading.value
                            ? null
                            : () async {
                                await ofertaController.rechazarOferta(ofertaId);
                                Get.snackbar("Acción", "Oferta rechazada",
                                    snackPosition: SnackPosition.BOTTOM);
                                Get.back();
                              },
                        icon: const Icon(Icons.cancel,
                            color: Colors.white, size: 20),
                        label: ofertaController.isLoading.value
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                            : const Text("Rechazar oferta",
                                style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          minimumSize: const Size(double.infinity, 45),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Get.snackbar("Acción", "Chat iniciado con ${oferta.name}",
                      snackPosition: SnackPosition.BOTTOM);
                },
                icon: const Icon(Icons.message, color: Colors.white, size: 20),
                label: const Text("Enviar mensaje",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  minimumSize: const Size(double.infinity, 45),
                ),
              ),
            ],
          ),
        );
      }),
    ),
    isDismissible: true,
    enableDrag: true,
  );
}

Widget _buildTableCell(String title, String value) {
  final theme = Theme.of(Get.context!);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.hintColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style:
              theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String title, String value) {
  final theme = Theme.of(Get.context!);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold, color: theme.hintColor)),
        Text(value,
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
