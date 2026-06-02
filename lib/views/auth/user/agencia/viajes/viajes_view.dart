// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/viajes/viajes_controller.dart';
import 'package:open_cargo/views/auth/user/agencia/widgets/cargas_publicadas.dart';
import 'package:open_cargo/views/auth/user/agencia/widgets/crear_viaje_modal.dart';
import 'package:open_cargo/views/auth/user/agencia/widgets/header.dart';
import 'package:open_cargo/widgets/no_data_found.dart';

class AgenciaView extends StatelessWidget {
  AgenciaView({super.key});

  final ViajeController viajeController = Get.put(ViajeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Fondo suave
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              buildHeader(),
              const SizedBox(height: 20),
              _buildTitle(),
              const SizedBox(height: 20),
              Expanded(child: _buildCargasList()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "recargar_viajes",
        backgroundColor: ThemeUi.principal,
        onPressed: () {
          viajeController.fetchViajesByUser();
        },
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        "Mis cargas publicadas",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode
              ? Colors.white.withOpacity(0.9)
              : Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }

  Widget _buildCargasList() {
    return Obx(() {
      if (viajeController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (viajeController.viajes.isEmpty) {
        return EmptyDataWidget();
      }

      return ListView.separated(
        itemCount: viajeController.viajes.length,
        separatorBuilder: (context, index) => Divider(
          color: Theme.of(context).dividerColor.withOpacity(0.2),
        ),
        itemBuilder: (context, index) {
          final viaje = viajeController.viajes[index];

          return ListTile(
            title: Text(
              "${viaje.lugarOrigen} - ${viaje.lugarDestino}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Modalidad: ${viaje.modalidad}",
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.color
                        ?.withOpacity(0.6),
                  ),
                ),
                Text(
                  "Tipo: ${viaje.tipo_venta}",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                showDetailsModal(viaje.id); // Llamar al modal con los detalles
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeUi.principal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Ver Detalles",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      );
    });
  }
}
