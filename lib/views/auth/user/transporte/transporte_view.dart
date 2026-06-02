import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/controllers/viajes/viajes_controller.dart';
import 'package:open_cargo/models/viajes/viajes_model.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/views/auth/user/transporte/widgets/info_row.dart';
import 'package:open_cargo/views/auth/user/transporte/widgets/filtro_dropdown.dart';
import 'package:open_cargo/views/auth/user/transporte/widgets/modal_detalle.dart';
import 'package:open_cargo/widgets/no_data_found.dart';

class TransporteView extends StatelessWidget {
  TransporteView({super.key});

  final RxString selectedModalidad = 'Todos'.obs;
  final RxString selectedTipoVenta = 'Todos'.obs;

  @override
  Widget build(BuildContext context) {
    final ViajeController viajeController = Get.put(ViajeController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Viajes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: ThemeUi.principal,
        elevation: 2,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                FiltroDropdown(
                  icono: Icons.directions_car,
                  selectedValue: selectedModalidad,
                  opciones: ['Todos', 'Full', 'Sencillo'],
                ),
                const SizedBox(width: 10),
                FiltroDropdown(
                  icono: Icons.sell,
                  selectedValue: selectedTipoVenta,
                  opciones: ['Todos', 'Ofertar', 'Tomar Carga'],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Obx(() {
          if (viajeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // 🔍 Filtrar viajes
          final filteredViajes = viajeController.viajes.where((viaje) {
            final matchesModalidad = selectedModalidad.value == 'Todos' ||
                viaje.modalidad == selectedModalidad.value;
            final matchesTipoVenta = selectedTipoVenta.value == 'Todos' ||
                viaje.tipo_venta == selectedTipoVenta.value;

            return matchesModalidad && matchesTipoVenta;
          }).toList();

          if (filteredViajes.isEmpty) {
            return EmptyDataWidget();
          }

          return ListView.builder(
            itemCount: filteredViajes.length,
            itemBuilder: (context, index) {
              final viaje = filteredViajes[index];

            return Container(
  padding: const EdgeInsets.all(15),
  margin: const EdgeInsets.only(bottom: 12),
  decoration: BoxDecoration(
    color: theme.cardColor,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: theme.shadowColor.withOpacity(0.05),
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Cabecera: Modalidad, Origen-Destino y Estado
      Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.primaryColor.withOpacity(0.2),
            radius: 24,
            child: Text(
              viaje.modalidad[0].toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: theme.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${viaje.lugarOrigen} - ${viaje.lugarDestino}",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Estado: ${viaje.estado}",
                  style: TextStyle(color: theme.hintColor),
                ),
              ],
            ),
          ),
        ],
      ),

      const SizedBox(height: 10),

      // Información de fechas y modalidad
      buildInfoRow(context, "Fecha salida", viaje.fechaSalida, theme),
      const SizedBox(height: 4),
      buildInfoRow(context, "Fecha llegada", viaje.fechaLlegada, theme),
      const SizedBox(height: 4),
      buildInfoRow(context, "Modalidad", viaje.modalidad, theme),
      const SizedBox(height: 4),
      buildInfoRow(context, "Tipo", viaje.tipo_venta, theme),

      const SizedBox(height: 10),

      // Información de Contenedores (con ícono de camión)
      Row(
        children: [
          Icon(Icons.local_shipping, color: theme.primaryColor, size: 20),
          const SizedBox(width: 8),
          Text(
            "${viaje.contenedoresTomados} (USADOS) / ${viaje.tamContenedorNum} (DISPONIBLES)",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
        ],
      ),

      const SizedBox(height: 12),

      // Botón "Ver Detalle"
      Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton.icon(
          onPressed: () {
            viajeController.fetchViajeDetalle(viaje.id);
            showViajeDetalleModal(viaje.id);
          },
          icon: const Icon(Icons.visibility, size: 18, color: Colors.white),
          label: const Text("Ver Detalle", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeUi.principal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ),
      ),
    ],
  ),
);

            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "recargar_viajes_transporte",
        backgroundColor: ThemeUi.principal,
        onPressed: () {
          viajeController.fetchViajes();
        },
        child: const Icon(Icons.refresh, color: Colors.white, size: 28),
      ),
    );
  }

  // 📌 Widget para mostrar filas de información
}
