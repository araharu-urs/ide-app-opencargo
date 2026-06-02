import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_cargo/models/chat/chat_info_model.dart';
import 'package:open_cargo/models/chat/chat_model.dart';
import 'package:open_cargo/models/chat/lista_chat_model.dart';
import 'package:open_cargo/services/chat/chat_service.dart';
import 'package:open_cargo/utils/pusher/pusher.dart';
import 'package:open_cargo/widgets/exceptions/error_modal.dart';

class ChatController extends GetxController {
  var currentStep = 0.obs;
  var isProcessStarted = false.obs;
  var isSendingMessage = false.obs;

  late final int currentUserId;
  void startProcess() {
    isProcessStarted.value = true;
  }
final ScrollController scrollController = ScrollController();

  final TextEditingController messageController = TextEditingController();

  var chatInfo = Rxn<ChatInfoModel>();
  final box = GetStorage();
  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  late int chatId;
  final ChatService _chatService = ChatService();

  var chats = <ChatResumenModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    currentUserId = int.parse(box.read('id').toString());

    super.onInit();
    fetchUserChats();
  }

  @override
  void onClose() {
    
    PusherService().unsubscribeFromChatChannel(chatId);
    messageController.dispose();
    super.onClose();
  }

  Future<void> cerrarVista( int chatId) async {
    PusherService().unsubscribeFromChatChannel(chatId);
    //messageController.dispose();
    Get.back();
  }

  Future<void> fetchUserChats() async {
    isLoading.value = true;
    final box = GetStorage();
    final String userId = box.read('id');
    try {
      final result = await _chatService.getChatsByUser(userId);
      
      if (result != null) {
        chats.assignAll(result);
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
    }

    isLoading.value = false;
  }

  Future<void> sendMessage(int chatId) async {
    final contenido = messageController.text.trim();

    if (contenido.isEmpty) {
      Get.snackbar("Atención", "El mensaje no puede estar vacío",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isSendingMessage.value = true;
    final int userId = int.parse(box.read('id').toString());

    try {
      final enviado = await _chatService.sendMensaje(
        chatId: chatId,
        userId: userId,
        contenido: contenido,
        tipo: 'texto',
      );

      if (enviado) {
        messageController.clear();
        await fetchMensajes(chatId);
      } else {
        ErrorModal.show(Get.context!, "No se pudo enviar el mensaje");
      }
    } catch (e) {
      ErrorModal.show(Get.context!, e.toString());
    } finally {
      isSendingMessage.value = false;
    }
  }

  var mensajes = <MensajeModel>[].obs;
  var isLoadingMensajes = false.obs;

  /// 🔁 Cargar los mensajes de un chat específico
  Future<void> fetchMensajes(int chatId) async {
   
    PusherService().subscribeToChatChannel(chatId);
    isLoadingMensajes.value = true;
    final mensajesList = await _chatService.getMensajesByChat(chatId);
    if (mensajesList != null) {
      mensajes.assignAll(mensajesList);
       Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    }
    isLoadingMensajes.value = false;
  }

  Future<void> fetchChatInfo(int chatId) async {
    final info = await _chatService.getChatInfo(chatId);
    if (info != null) {
      chatInfo.value = info;
    }
  }
}
