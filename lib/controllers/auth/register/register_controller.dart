import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/models/user/roles_model.dart';
import 'package:open_cargo/services/auth/registro/registro_service.dart';
import 'package:open_cargo/services/users/users_service.dart';
import 'package:open_cargo/widgets/exceptions/error_modal.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController companyController =
      TextEditingController(); // Solo para algunos perfiles
  final TextEditingController rfcController =
      TextEditingController(); // Solo para Aduanas y Empresas
  final RegistroService registerService = RegistroService();
  var selectedProfileId = Rxn<int>();
  @override
  void onInit() {
    super.onInit();
    fetchRoles();
  }

  var isLoading = false.obs;
  var selectedProfile = "".obs;
  var obscurePassword = true.obs;
  var obscureConfirm = true.obs;
  final UserService _userService = UserService();

  RxList<Map<String, dynamic>> profiles = <Map<String, dynamic>>[].obs;
  RxList<RolModel> roles = <RolModel>[].obs;
  Future<void> fetchRoles() async {
    // isLoading.value = true;
    final rolesList =
        await _userService.getRoles(); // Llamar al servicio de roles

    if (rolesList != null) {
      profiles.assignAll(
        rolesList
            .map((role) => {
                  "id": role.id,
                  "icon": _getRoleIcon(
                      role.nombre), // Asigna un icono basado en el rol
                  "label": role.nombre,
                })
            .toList(),
      );
    }
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

  Future<void> registerUser() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final roleId = selectedProfileId.value;
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ErrorModal.show(Get.context!, "Todos los campos son obligatorios.");
      //Get.snackbar("Error", "Todos los campos son obligatorios.");
      return;
    }

    if (password != confirmPassword) {
      ErrorModal.show(Get.context!, "Las contraseñas no coinciden.");
      return;
    }

    if (roleId == null) {
      ErrorModal.show(Get.context!, "Por favor, selecciona un rol.");
      return;
    }
    isLoading.value = true;

    final response =
        await registerService.register(name, email, password, roleId);

    isLoading.value = false;

    if (response['success']) {
      Get.offAllNamed('/tabs'); 
    } else {
      ErrorModal.show(Get.context!, response.toString());
      //Get.snackbar("Error", response['message']);
    }
  }
}
