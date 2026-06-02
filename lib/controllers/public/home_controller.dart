import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_cargo/models/user/roles_model.dart';
import 'package:open_cargo/models/user/user_model.dart';
import 'package:open_cargo/services/users/users_service.dart';
import 'package:open_cargo/widgets/exceptions/error_modal.dart';
import 'package:open_cargo/widgets/exceptions/load_data_modal.dart';
import 'package:open_cargo/widgets/exceptions/success_modal.dart';

class HomeController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
  }

  final UserService _userService = UserService();
  var searchQuery = ''.obs;
  RxList<UserModel> users = <UserModel>[].obs;
  RxList<RolModel> roles = <RolModel>[].obs;
  RxList<UserModel> filteredUsers = <UserModel>[].obs;
  var currentPosition = LatLng(0.0, 0.0).obs; // Ubicación por defecto
  final mapController = MapController();
  var isLoading = false.obs;
  RxList<Map<String, dynamic>> tabs = <Map<String, dynamic>>[].obs;
  final box = GetStorage();
  @override
  void onInit() {
    final String? id = box.read('id');

  
      fetchRoles();
      fetchUsers();
    
    super.onInit();

    _getCurrentLocation();
    ever(searchQuery, (_) => filterUsers());
  }

  Future<void> fetchRoles() async {
    isLoading.value = true;
    final rolesList =
        await _userService.getRoles(); // Llamar al servicio de roles

    if (rolesList != null) {
      tabs.assignAll(
        rolesList
            .map((role) => {
                  "icon": _getRoleIcon(
                      role.nombre), // Asigna un icono basado en el rol
                  "label": role.nombre,
                })
            .toList(),
      );
    }

    isLoading.value = false;
  }

  IconData _getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'transporte':
        return Icons.local_shipping;
      case 'patios logísticos':
        return Icons.business;
      case 'aduanas':
        return Icons.account_balance;
      case 'almacenes':
        return Icons.warehouse;
      case 'oficinas':
        return Icons.location_city;
      case 'distribuidores':
        return Icons.store;
      default:
        return Icons.category; // Icono genérico para roles desconocidos
    }
  }

  /// 📌 Obtiene la lista de usuarios desde la API
  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      final userList = await _userService.getUsers();
      if (userList != null) {
        users.assignAll(userList);
        filteredUsers.assignAll(userList); // Inicializar lista filtrada
      }
      isLoading.value = false;
     // LoadDataModal.show(Get.context!);
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
    }
  }

  void filterUsers() {
    try {
      String query = searchQuery.value.toLowerCase();
      if (query.isEmpty) {
        filteredUsers.assignAll(users);
      } else {
        filteredUsers.assignAll(
          users
              .where((user) =>
                  user.name.toLowerCase().contains(query) ||
                  user.description.toLowerCase().contains(query))
              .toList(),
        );
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
    }
  }

  /// 📌 Obtiene la ubicación actual del usuario
  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("⚠️ Servicios de ubicación deshabilitados.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          print("⚠️ Permisos de ubicación denegados permanentemente.");
          return;
        }
      }

      // Obtener la ubicación actual
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Actualizar la posición con la ubicación real
      currentPosition.value = LatLng(position.latitude, position.longitude);
      mapController.move(currentPosition.value, 15.0); // Centrar mapa

      print("📍 Ubicación actual: ${currentPosition.value}");
    } catch (e) {
      print("❌ Error obteniendo ubicación: $e");
    }
  }
}
