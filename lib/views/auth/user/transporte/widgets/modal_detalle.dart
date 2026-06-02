import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/controllers/viajes/viajes_controller.dart';
import 'package:open_cargo/models/viajes/viajes_detalle_model.dart';

void showViajeDetalleModal(int viajeId) {
  final ViajeController viajeController = Get.find<ViajeController>();
  final theme = Theme.of(Get.context!);

  // Cargar detalles antes de mostrar la modal
  viajeController.fetchViajeDetalle(viajeId);

  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: theme.scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Obx(() {
        if (viajeController.isLoadingViajeDetalle.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final viaje = viajeController.viajeDetalle.value;
        if (viaje == null) {
          return Center(
            child: Text("no_trip_found".tr,
                style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
          );
        }

        // Controladores locales para los inputs:

        return DraggableScrollableSheet(
          initialChildSize: 0.95,
          maxChildSize: 1,
          minChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Encabezado
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "trip_details".tr,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: theme.iconTheme.color),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),

                    // 🔹 Datos del viaje
                    _buildInfoRow(
                        Icons.directions_car, "estado".tr, viaje.estado, theme),

                    _buildInfoRow(
                        Icons.place, "origen".tr, viaje.lugarOrigen, theme),
                    _buildInfoRow(
                        Icons.flag, "destino".tr, viaje.lugarDestino, theme),
                    _buildInfoRow(Icons.markunread_mailbox, "cp_origen".tr,
                        viaje.codigoPostalOrigen, theme),
                    _buildInfoRow(Icons.markunread_mailbox_outlined,
                        "cp_destino".tr, viaje.codigoPostalDestino, theme),
                    _buildInfoRow(Icons.calendar_today, "fecha_salida".tr,
                        viaje.fechaSalida, theme),
                    _buildInfoRow(Icons.date_range, "fecha_llegada".tr,
                        viaje.fechaLlegada, theme),
                    _buildInfoRow(Icons.confirmation_number,
                        "no_contenedores".tr, viaje.noContenedores, theme),
                    _buildInfoRow(Icons.straighten, "tam_contenedor_num".tr,
                        viaje.tamContenedorNum, theme),
                    _buildInfoRow(Icons.widgets, "tam_contenedor_tipo".tr,
                        viaje.tamContenedorTipo, theme),
                    _buildInfoRow(Icons.line_weight, "peso_min".tr,
                        "${viaje.pesoMin} TON", theme),
                    _buildInfoRow(Icons.line_weight_outlined, "peso_max".tr,
                        "${viaje.pesoMax} TON", theme),
                    _buildInfoRow(
                        Icons.sync_alt, "modalidad".tr, viaje.modalidad, theme),

                    const SizedBox(height: 20),

                    // 🔹 Inputs según el tipo de acción
                    if (viaje.tipo_venta == "Ofertar") ...[
                      // 🔹 Oferta por Full y Nº de Contenedores
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Oferta por Full",
                                    style: _labelStyle(theme)),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: viajeController.precioFull,
                                  keyboardType: TextInputType.number,
                                  decoration: _inputDecoration("Ingrese monto"),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Cont. Full", style: _labelStyle(theme)),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: viajeController.cantidadFull,
                                  keyboardType: TextInputType.number,
                                  decoration:
                                      _inputDecoration("No. contenedores"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // 🔹 Oferta por Sencillo y Nº de Contenedores
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Oferta por Sencillo",
                                    style: _labelStyle(theme)),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: viajeController.precioSencillo,
                                  keyboardType: TextInputType.number,
                                  decoration: _inputDecoration("Ingrese monto"),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Cont. Sencillo",
                                    style: _labelStyle(theme)),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: viajeController.cantidadSencillo,
                                  keyboardType: TextInputType.number,
                                  decoration:
                                      _inputDecoration("No. contenedores"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // 🔹 Botón de Confirmar
                      Obx(() {
                        return ElevatedButton.icon(
                          onPressed: viajeController.isLoading.value
                              ? null
                              : () {
                                  viajeController.registrarOferta(
                                    viajeId: viaje.id,
                                    tipo: viaje.tipo_venta,
                                  );
                                },
                          icon: const Icon(Icons.check_circle,
                              color: Colors.white),
                          label: viajeController.isLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Enviar Oferta",
                                  style: TextStyle(color: Colors.white),
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            minimumSize: const Size(double.infinity, 45),
                          ),
                        );
                      }),
                    ] else if (viaje.tipo_venta == "Tomar Carga") ...[
                      Text(
                        "Cantidad a llevar",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyMedium?.color
                              ?.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: viajeController.cantidadTomarCarga,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Ingrese cantidad",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        return ElevatedButton.icon(
                          onPressed: viajeController.isLoading.value
                              ? null
                              : () {
                                  viajeController.registrarOferta(
                                    viajeId: viaje.id,
                                    tipo: viaje.tipo_venta,
                                  );
                                },
                          icon: const Icon(Icons.check_circle,
                              size: 20, color: Colors.white),
                          label: viajeController.isLoading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Enviar Mi Oferta",
                                  style: TextStyle(color: Colors.white),
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            minimumSize: const Size(double.infinity, 45),
                          ),
                        );
                      }),
                    ] else ...[
                      // Fallback: muestra botones de acción originales
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.snackbar("action".tr, "offer_accepted".tr,
                              snackPosition: SnackPosition.BOTTOM);
                          Get.back();
                        },
                        icon: const Icon(Icons.check_circle,
                            size: 20, color: Colors.white),
                        label: Text("accept_offer".tr,
                            style: const TextStyle(color: Colors.white)),
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
                        onPressed: () {
                          Get.snackbar("action".tr, "offer_rejected".tr,
                              snackPosition: SnackPosition.BOTTOM);
                          Get.back();
                        },
                        icon: const Icon(Icons.cancel,
                            size: 20, color: Colors.white),
                        label: Text("reject_offer".tr,
                            style: const TextStyle(color: Colors.white)),
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

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      });
    },
  );
}

TextStyle _labelStyle(ThemeData theme) {
  return TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
  );
}

InputDecoration _inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  );
}

/// Widget para mostrar datos con icono
Widget _buildInfoRow(
    IconData icon, String title, String value, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, color: theme.primaryColor, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "$title:",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
        ),
        Text(
          value,
          style:
              TextStyle(fontSize: 15, color: theme.textTheme.bodyMedium?.color),
        ),
      ],
    ),
  );
}
