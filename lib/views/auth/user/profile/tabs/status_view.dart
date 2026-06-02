import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/viajes/viajes_controller.dart';
import 'package:open_cargo/models/viajes/negociaciones_model.dart';
import 'package:open_cargo/views/auth/user/profile/tabs/modal_negociaciones.dart';
import 'package:open_cargo/widgets/no_data_found.dart';

class TabStatus extends StatelessWidget {
  TabStatus({super.key});

  final ViajeController controller = Get.put(ViajeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeUi.principal,
        onPressed: () {
          controller.cargarOfertasProceso();
        },
        tooltip: 'Recargar',
        child: const Icon(Icons.refresh),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.ofertasProceso.isEmpty) {
          return EmptyDataWidget();
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.ofertasProceso.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final viaje = controller.ofertasProceso[index];
            return _buildViajeCard(context, viaje);
          },
        );
      }),
    );
  }

  Widget _buildViajeCard(BuildContext context, OfertaEnProcesoModel viaje) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final estadoColor = Colors.orange;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue[100],
          child: Text(
            viaje.origen[0],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
        title: Text(
          "${viaje.origen} → ${viaje.destino}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Theme.of(context).textTheme.titleMedium?.color,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📅 Fecha: ${viaje.fecha}",
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.circle, size: 10, color: estadoColor),
                  const SizedBox(width: 6),
                  Text(
                    viaje.estado,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: estadoColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          controller.mostrarSeguimientoBottomSheet(
            context,
            pasosActivos: int.tryParse(viaje.paso_actual.toString()) ?? 0,
            viaje:viaje.idOferta
          );
        },
      ),
    );
  }
}
