import 'package:open_cargo/controllers/public/home_controller.dart';
import 'package:open_cargo/views/auth/user/agencia/tabs_view.dart';
import 'package:open_cargo/views/auth/user/profile/tabs_view.dart';
import 'package:open_cargo/views/auth/user/settings/settings_view.dart';
import 'package:open_cargo/views/auth/user/transporte/transporte_view.dart';
import 'package:open_cargo/views/public/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TabControllerX extends GetxController {
  var selectedIndex = 0.obs;
  var pages = <Widget>[].obs;
  var titles = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTabs();
  }

  void _loadTabs() {
    final box = GetStorage();
    final String? role = box.read('rol');
final String? id = box.read('id');
    pages.clear();
    titles.clear();

    // Agregar siempre "Home"
    pages.add(HomeView());
    titles.add("Home");
    print(role);
    print(id);
    // Pestañas según el rol
    if (role == "Agencia") {
      pages.add(TabAgenciaView());
      titles.add("Agencia");
    } else if (role == "Transporte") {
      pages.add(TransporteView());
      titles.add("Transporte");
    } else if (role == "Publico") {
      pages.add(HomeView());
      titles.add("Público");
    }

    // Agregar "Profile" y "Settings" para todos
    pages.add(TabProfileView());
    titles.add("Profile");

    pages.add(SettingsView());
    titles.add("Settings");

    print("Tabs cargadas: $titles"); // 👈 Verificar que se cargaron bien

    update();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
