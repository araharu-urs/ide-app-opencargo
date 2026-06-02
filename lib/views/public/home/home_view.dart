import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/public/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:open_cargo/views/public/home/widgets/build_list.dart';
import 'package:open_cargo/views/public/home/widgets/busqueda_view.dart';
import 'package:open_cargo/views/public/home/widgets/map_view.dart';
import 'package:open_cargo/views/public/home/widgets/tab_bar.dart';
import 'package:open_cargo/views/public/profile/profile_view.dart';
import 'package:open_cargo/widgets/no_data_found.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final HomeController homeController = Get.put(HomeController());
  // Estado del tab de filtros
  final RxInt mainTabIndex =
      0.obs; // Estado del tab principal (Búsqueda / Mapa)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Fondo suave
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Obx(() => mainTabIndex.value == 0
                  ? buildSearchView(homeController)
                  : buildMapView(homeController)), // Cambia la vista entre búsqueda y mapa
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: "recargar_usuarios",
        backgroundColor: ThemeUi.principal,
        onPressed: () {
          homeController.fetchUsers();
          homeController.fetchRoles();
        },
        child:
            const Icon(Icons.refresh, color: Colors.white), // Icono de recarga
      ),
    );
  }

 



 
}
