 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';
import 'package:open_cargo/controllers/auth/register/register_controller.dart';
Widget buildProfileSelector(RegisterController controller, ThemeData theme) {
  return Obx(() {
    if (controller.profiles.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selecciona tu tipo de perfil:",
          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.profiles.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final profile = controller.profiles[index];

              final bool isSelected =
                  controller.selectedProfile.value == profile["label"];

              return GestureDetector(
                onTap: () {
                  controller.selectedProfile.value = profile["label"];
                  controller.selectedProfileId.value = profile["id"];
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? ThemeUi.principal : theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.blueAccent : theme.dividerColor,
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            )
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(profile["icon"],
                          color: isSelected ? Colors.white : Colors.blueAccent,
                          size: 18),
                      const SizedBox(width: 8),
                      Text(
                        profile["label"],
                        style: TextStyle(
                          color: isSelected ? Colors.white : theme.textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  });
}
