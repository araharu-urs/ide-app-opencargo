import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_cargo/services/users/users_service.dart';

class NotificationTokenController extends GetxController {
  final box = GetStorage();
  final isLoading = false.obs;
  final userId = RxnString(); // observable nullable para guardar el ID

  @override
  void onInit() {
    super.onInit();
    getUserId(); // Llama al obtener el ID al iniciar
  }

  /// 📌 Obtener ID del usuario desde GetStorage
  void getUserId() {
    final String? id = box.read('id');

    if (id != null && id.isNotEmpty) {
      userId.value = id;
      print("✅ ID del usuario obtenido: $id");
    } else {
      print("❌ No se encontró el ID del usuario en GetStorage");
    }
  }

  /// 📌 Enviar el token de notificaciones al servidor
  Future<void> sendNotificationToken(String token) async {
    if (userId.value == null) {
      print("⚠️ No se puede enviar el token: ID del usuario es null");
      return;
    }

    isLoading.value = true;
    final response = await UserService.registerToken(userId.value!, token);
    isLoading.value = false;

    if (response['success']) {
      print("✅ Token registrado correctamente");
    } else {
      print("❌ Error al registrar token: ${response['message']}");
    }
  }
}
