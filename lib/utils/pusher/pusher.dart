import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_cargo/controllers/public/profile/chat/chat_controller.dart';
import 'package:open_cargo/controllers/user/user_controller.dart';
import 'dart:math';
import 'package:open_cargo/env.dart';
import 'package:open_cargo/utils/notifications/notificacion.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

  final NotificationTokenController notificacionController =
      Get.put(NotificationTokenController());

  /// Inicializa y se suscribe a Pusher
  Future<void> initializePusher() async {
    try {
      await _pusher.init(
        apiKey: Env.pusherApiKey,
        cluster: Env.pusherCluster,
        onEvent: _onPusherEvent,
      );
      final String channelToken = _generateRandomToken(10);
      notificacionController.sendNotificationToken(channelToken);
      await _pusher.subscribe(channelName: channelToken);
      await _pusher.connect();

      if (kDebugMode) {
        print("✅ Suscrito a canal: chat-sala");
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Error al inicializar Pusher: $e");
      }
    }
  }

  String _generateRandomToken(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rand = Random.secure();
    return List.generate(length, (_) => chars[rand.nextInt(chars.length)])
        .join();
  }

  void _onPusherEvent(PusherEvent event) {
    if (kDebugMode) {
      print("📩 Evento recibido: ${event.eventName}");
      print("🔍 Payload RAW: ${event.data}");
    }

    if (event.eventName == 'notificacion-general') {
      try {
        final raw = event.data ?? '{}';

        // Algunos servidores mandan el data como string con saltos de línea
        final cleanData = raw.replaceAll('\n', '').trim();
        final Map<String, dynamic> data = jsonDecode(cleanData);

        final String title = data['title'] ?? 'Notificación';
        final String message =
            data['message'] ?? 'Tienes una nueva notificación.';

        NotificationService().showNotification(
          0,
          title,
          message,
        );

        if (kDebugMode) {
          print("✅ Notificación mostrada correctamente");
        }
      } catch (e, st) {
        print("❌ Error al procesar notificación: $e");
        print("📍 Stacktrace: $st");
      }
    }
    if (event.eventName == 'new-message') {
      try {
        final raw = event.data ?? '{}';
        final cleanData = raw.replaceAll('\n', '').trim();
        final Map<String, dynamic> data = jsonDecode(cleanData);

        final int chatId = data['chat'];

        if (kDebugMode) {
          print("💬 ID del chat recibido: $chatId");
        }

        // Obtener el controlador de chat y actualizar mensajes
        final ChatController chatController = Get.find<ChatController>();
        chatController.fetchMensajes(chatId);
      } catch (e, st) {
      
      }
    }
  }

  /// Manejo del nuevo mensaje recibido
  void _handleNewMessage(Map<String, dynamic> data) {
    final int chatId = data['sala_id'];
    final Map<String, dynamic> message = data['mensaje'];

    // Actualiza mensajes si hay un controlador escuchando
    // ChatController.to.fetchMessages(); ← Asegúrate que exista si lo usas
    _emitNotification(
      3,
      name: message['enviado_por'] ?? 'Usuario',
      message: message['contenido'] ?? '',
      imageUrl: message['imagen'],
    );

    if (kDebugMode) {
      print("🟢 Nuevo mensaje en chat $chatId: ${message['contenido']}");
    }
  }

  /// Emitir notificación de manera interna
  void _emitNotification(int chatId,
      {required String name, required String message, String? imageUrl}) {
    NotificationService().showNotification(
      0,
      name,
      message,
    );

    if (kDebugMode) {
      print("🔔 Notificación emitida para chat $chatId");
    }
  }

  /// Función pública para emitir notificación desde otro lugar
  void emitNotificationExternally({
    required int chatId,
    required String name,
    required String message,
    String? imageUrl,
  }) {
    _emitNotification(chatId, name: name, message: message, imageUrl: imageUrl);
  }

  /// Manejo de actualización de pasos del chat (si aplica)
  void _handleChatStepUpdate(Map<String, dynamic> data) {
    if (data['step_update'] != null) {
      if (kDebugMode) {
        print("🔁 Paso del chat actualizado: ${data['step_update']}");
      }
    }
  }

  Future<void> subscribeToChatChannel(int chatId) async {
    try {
      final box = GetStorage();
      final String? id = box.read('id');
      await _pusher.subscribe(channelName: "chat.$chatId-user.$id");
      debugPrint("✅ Suscrito al canal: chat.$chatId");
    } catch (e) {
      debugPrint("❌ Error al suscribirse a chat.$chatId: $e");
    }
  }

  Future<void> unsubscribeFromChatChannel(int chatId) async {
    try {
      final box = GetStorage();
      final String? id = box.read('id');
      await _pusher.unsubscribe(channelName: "chat.$chatId-user.$id");
      debugPrint("📤 Desuscrito del canal: chat.$chatId");
    } catch (e) {
      debugPrint("❌ Error al desuscribirse de chat.$chatId: $e");
    }
  }
}
