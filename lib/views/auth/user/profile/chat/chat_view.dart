import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/public/profile/chat/chat_controller.dart';
import 'package:open_cargo/models/chat/chat_model.dart';
import 'package:open_cargo/views/auth/user/profile/chat/widgets/build_status_badge.dart';
import 'package:open_cargo/widgets/exceptions/confirmacion_modal.dart';

class ChatView extends StatelessWidget {
  final int chatId;
  final ChatController controller = Get.put(ChatController());

  ChatView({super.key, required this.chatId}) {
    controller.fetchMensajes(chatId);
    controller.fetchChatInfo(chatId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeUi.principal,
        title: Obx(() {
          final chatInfo = controller.chatInfo.value;

          // Mostrar un loader si la información aún no está disponible
          if (chatInfo == null) {
            return Text(
              "Cargando información...",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
            );
          }

          return Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Text(
                  chatInfo.inicial, // Asegurar que no sea null
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatInfo.nombre,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'Poppins'
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    buildStatusBadge("Online"),
                  ],
                ),
              ),
            ],
          );
        }),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).iconTheme.color),
          onPressed: () => controller.cerrarVista(chatId),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              ConfirmModal.show(
                context: context,
                title: 'Iniciar Proceso',
                message: '¿Seguro que deseas iniciar el proceso?',
                onConfirm: () {
                  Get.back();
                },
              );
            },
            label: const Text(
              "Comenzar\nProceso",
              style: TextStyle(fontSize: 12, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[300],
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          const SizedBox(width: 10),
        ],
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Obx(() => controller.isProcessStarted.value
              ? _buildStepper()
              : const SizedBox()),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                controller: controller.scrollController, // 👈 Aquí
                reverse:
                    false, // NO lo pongas en true, tú haces el scroll manual al final
                padding: const EdgeInsets.all(10),
                itemCount: controller.mensajes.length,
                itemBuilder: (context, index) {
                  final mensaje = controller.mensajes[index];
                  final isMe = mensaje.userId == controller.currentUserId;

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(15),
                          topRight: const Radius.circular(15),
                          bottomLeft:
                              isMe ? const Radius.circular(15) : Radius.zero,
                          bottomRight:
                              isMe ? Radius.zero : const Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        mensaje.contenido,
                        style: TextStyle(
                          fontSize: 14,
                          color: isMe
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    final theme = Theme.of(Get.context!);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 10,
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.highlightColor.withOpacity(0.2),
            child: IconButton(
              icon: Icon(Icons.attach_file, color: theme.iconTheme.color),
              onPressed: () {
                Get.snackbar("Adjuntar Archivo", "Funcionalidad en desarrollo");
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Obx(() => TextField(
                  controller: controller.messageController,
                  enabled: !controller.isSendingMessage.value,
                  style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                  decoration: InputDecoration(
                    hintText: "Escribe un mensaje...",
                    hintStyle: TextStyle(color: theme.hintColor),
                    filled: true,
                    fillColor: theme.inputDecorationTheme.fillColor ??
                        theme.cardColor.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                )),
          ),
          const SizedBox(width: 10),
          Obx(() => CircleAvatar(
                backgroundColor: theme.primaryColor,
                child: controller.isSendingMessage.value
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () => controller.sendMessage(chatId),
                      ),
              )),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _stepperStep(0, "Solicitud"),
              _stepperStep(1, "En Proceso"),
              _stepperStep(2, "Revisión"),
              _stepperStep(3, "Finalizado"),
            ],
          ),
        ));
  }

  Widget _stepperStep(int stepIndex, String label) {
    return Obx(() {
      bool isActive = controller.currentStep.value >= stepIndex;

      return GestureDetector(
        onTap: () => controller.nextStep(),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: isActive ? Colors.blueAccent : Colors.grey[300],
              child: Icon(
                isActive ? Icons.check : Icons.circle,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.blueAccent : Colors.grey,
              ),
            ),
          ],
        ),
      );
    });
  }
}
