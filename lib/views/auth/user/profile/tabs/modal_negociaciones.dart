import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:open_cargo/controllers/viajes/viajes_controller.dart';
import 'package:open_cargo/views/auth/user/profile/chat/chat_view.dart';

class SeguimientoBottomSheet extends StatelessWidget {
  final int ofertaId;

  const SeguimientoBottomSheet({super.key, required this.ofertaId});

  @override
  Widget build(BuildContext context) {
    final ViajeController controller = Get.find<ViajeController>();
    controller.fetchOfertaEnProcesoDetalle(ofertaId); // Cargar detalle
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    final pasos = [
      "AGENTE ADUANAL SOLICITA INFORMACIÓN AL IMPORTADOR SOBRE LA FECHA DE ARRIBO DEL BUQUE Y DOCUMENTOS PARA EL DESPACHO.",
      "ARRIBO BUQUE A PUERTO LÁZARO CÁRDENAS",
      "PEDIMENTO EN VENTANILLA",
      "CARTA DE LIBERACIÓN",
      "CARTA PORTE LISTA",
      "MANIOBRA ENTREGADA",
      "PROCESO 5",
      "PROCESO 6",
    ];

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Obx(() {
          final detalle = controller.detalleOfertaProceso.value;

          if (detalle == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close,
                        size: 24,
                        color: isDark ? Colors.white : Colors.black87),
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    "Seguimiento del viaje #${detalle.viajeId}",
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: theme.textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                    text: "Usuario: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        "${detalle.usuario.name} (${detalle.usuario.email})"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              style: theme.textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                    text: "Ruta: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        "${detalle.origen} → ${detalle.destino}"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              style: theme.textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                    text: "Fecha: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: detalle.fecha),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: theme.textTheme.bodyMedium,
                                  children: [
                                    TextSpan(
                                        text: "Chat Establecido",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Get.to(
                                      () => ChatView(chatId: detalle.chatId));
                                },
                                icon: const Icon(Icons.chat_bubble_outline,
                                    size: 16,color: Colors.white,),
                                label: const Text("Abrir chat"),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  textStyle: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: pasos.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final isActivo = index < detalle.pasoActual;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Icon(
                                isActivo
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: isActivo ? Colors.green : Colors.grey,
                                size: 20,
                              ),
                              if (index != pasos.length - 1)
                                Container(
                                  width: 2,
                                  height: 30,
                                  color: isActivo
                                      ? Colors.green
                                      : Colors.grey.shade300,
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                "STEP ${index + 1}\n${pasos[index]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: isActivo
                                      ? (isDark ? Colors.white : Colors.black)
                                      : Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
