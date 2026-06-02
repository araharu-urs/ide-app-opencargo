import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_cargo/env.dart';
import 'package:open_cargo/models/chat/chat_info_model.dart';
import 'package:open_cargo/models/chat/chat_model.dart';
import 'package:open_cargo/models/chat/lista_chat_model.dart';
import 'package:open_cargo/services/api/%20api_service.dart';

import 'package:open_cargo/widgets/exceptions/error_modal.dart';

class ChatService extends GetConnect {
   final headers = HttpHeadersService.getHeaders();
  Future<List<ChatResumenModel>?> getChatsByUser(String userId) async {
    try {
      final response = await get('${Env.baseUrl}/chats/$userId',headers: headers);

      if (response.statusCode == 200) {
        return ChatResumenModel.fromJsonList(response.body);
      } else {
        ErrorModal.show(Get.context!, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }

  Future<List<MensajeModel>?> getMensajesByChat(int chatId) async {
    try {
      final response = await get('${Env.baseUrl}/chats/messages/$chatId',headers: headers);

      if (response.statusCode == 200) {
        return MensajeModel.fromJsonList(response.body);
      } else {
        ErrorModal.show(Get.context!, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }

  Future<ChatInfoModel?> getChatInfo(int chatId) async {
    try {
      final box = GetStorage();
      final String? id = box.read('id');
      final response = await get('${Env.baseUrl}/chats/$chatId/$id/info',headers: headers);

      if (response.statusCode == 200) {
        return ChatInfoModel.fromJson(response.body);
      } else {
        ErrorModal.show(Get.context!, response.statusCode.toString());
        return null;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return null;
    }
  }

  Future<bool> sendMensaje({
    required int chatId,
    required String contenido,
    required int userId,
    required String tipo, // texto o imagen
  }) async {
    try {
      final response = await post(
        '${Env.baseUrl}/chats/send-message',
        {
          "chats_id": chatId,
          "user_id": userId, 
          "contenido": contenido,
          "tipo_mensaje": tipo,
        },headers: headers
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        ErrorModal.show(Get.context!,
            response.body['message'] ?? "Error al enviar el mensaje.");
        return false;
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
      return false;
    }
  }
}
